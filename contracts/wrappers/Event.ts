import { Address, beginCell, Cell, Contract, ContractABI, contractAddress, ContractProvider, Sender, toNano, TupleItem } from 'ton-core'
import { compileFunc } from '@ton-community/func-js'
import { readFileSync } from 'fs';
import { Bet } from './Bet'
import { ContractExecutor } from 'ton-emulator/dist/emulator/ContractExecutor';
import { ContractSystem } from 'ton-emulator/dist/emulator/ContractSystem';

export class Event implements Contract {
    readonly address: Address
    readonly init: { code: Cell; data: Cell }
    readonly executor: ContractExecutor

    constructor (address: Address, init: { code: Cell; data: Cell }, executor: ContractExecutor) {
        this.address = address
        this.init = init
        this.executor = executor
    }

    static async create (system: ContractSystem, oracle: Address, uid: number): Promise<Event> {
        const stateInit = await this.getStateInit(oracle, uid)
        const address = contractAddress(0, stateInit)
        return new Event(address, stateInit, system.contract(address))
    }

    async bet (via: Sender, outcome: boolean, amount: bigint) {
        await via.send({
            to: this.address,
            init: this.init,
            value: amount + toNano('0.25'),
            body: beginCell()
                .storeUint(0x60e6b243, 32)
                .storeBit(outcome)
                .storeUint(amount, 256)
            .endCell()
        })
    }

    async startEvent (via: Sender) {
        await via.send({
            to: this.address,
            init: this.init,
            value: toNano('0.05'),
            body: beginCell()
                .storeUint(0x380ce405, 32)
            .endCell()
        })
    }

    async finishEvent (via: Sender, winner: boolean) {
        await via.send({
            to: this.address,
            init: this.init,
            value: toNano('0.05'),
            body: beginCell()
                .storeUint(0x54a94f2a, 32)
                .storeBit(winner)
            .endCell()
        })
    }

    private async runGetMethod (method: string, stack?: TupleItem[] | undefined) {
        var res = await this.executor.get(method)
        if (!res.success) throw(res.error)
        return res.stack
    }

    async getTotalBets () {
        const t = (await this.runGetMethod('get_total_bets')).readTuple()
        return [t.readBigNumber(), t.readBigNumber()]
    }

    async getStartedFinished () {
        const t = (await this.runGetMethod('get_started_finished')).readTuple()
        return [t.readBoolean(), t.readBoolean()]
    }

    async getWinner () {
        return (await this.runGetMethod('get_winner')).readBoolean()
    }

    static async getCode (): Promise<Cell> {
        let result = await compileFunc({
            targets: ['stdlib.fc', 'opcodes.fc', 'event.fc'],
            sources: (path) => readFileSync('func/' + path).toString()
        })
        if (result.status === 'error') {
            throw(result.message)
        }
        return Cell.fromBoc(Buffer.from(result.codeBoc, 'base64'))[0]
    }

    static async getStateInit (oracle: Address, uid: number): Promise<{ code: Cell, data: Cell }> {
        return {
            code: await this.getCode(),
            data: beginCell()
                .storeUint(uid, 128)
                .storeAddress(oracle)
                .storeUint(0, 515)
                .storeRef(await Bet.getCode())
            .endCell()
        }
    }
}