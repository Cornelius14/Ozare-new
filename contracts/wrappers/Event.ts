import { Address, beginCell, Cell, Contract, ContractABI, contractAddress, ContractProvider, Sender, toNano } from 'ton-core'
import { compileFunc } from '@ton-community/func-js'
import { readFileSync } from 'fs';
import { Bet } from './Bet'
import { ContractExecutor } from 'ton-emulator/dist/emulator/ContractExecutor';

export class Event implements Contract {
    readonly address: Address
    readonly init: { code: Cell; data: Cell }

    constructor (address: Address, init: { code: Cell; data: Cell }) {
        this.address = address
        this.init = init
    }

    static async create (oracle: Address): Promise<Event> {
        const stateInit = await this.getStateInit(oracle)
        const address = contractAddress(0, stateInit)
        return new Event(address, stateInit)
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

    async processBet (via: Sender, player: Address, outcome: boolean, amount: bigint) {
        await via.send({
            to: this.address,
            init: this.init,
            value: toNano('0.05'),
            body: beginCell()
                .storeUint(0x733c3caa, 32)
                .storeAddress(player)
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

    async getTotalBets (executor: ContractExecutor) {
        var res = await executor.get('get_total_bets')
        if (!res.success) throw(res.error)
        const t = res.stack.readTuple()
        return [t.readBigNumber(), t.readBigNumber()]
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

    static async getStateInit (oracle: Address): Promise<{ code: Cell, data: Cell }> {
        return {
            code: await this.getCode(),
            data: beginCell()
                .storeAddress(oracle)
                .storeUint(0, 515)
                .storeRef(await Bet.getCode())
            .endCell()
        }
    }
}