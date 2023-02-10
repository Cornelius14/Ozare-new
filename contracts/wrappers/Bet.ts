import { Address, beginCell, Cell, Contract, ContractProvider, Sender, StateInit, toNano, TupleItem } from 'ton-core'
import { compileFunc } from '@ton-community/func-js'
import { readFileSync } from 'fs'
import { ContractExecutor } from 'ton-emulator/dist/emulator/ContractExecutor'

export class Bet implements Contract {
    readonly address: Address
    readonly executor: ContractExecutor

    constructor (address: Address, executor: ContractExecutor) {
        this.address = address
        this.executor = executor
    }

    async close (via: Sender) {
        await via.send({
            to: this.address,
            value: toNano('0.25'),
            body: beginCell()
                .storeUint(0x12d4de36, 32)
            .endCell()
        })
    }

    private async runGetMethod (method: string, stack?: TupleItem[] | undefined) {
        var res = await this.executor.get(method)
        if (!res.success) throw(res.error)
        return res.stack
    }

    async getOwner () {
        return (await this.runGetMethod('get_owner')).readAddress()
    }

    async getEvent () {
        return (await this.runGetMethod('get_event')).readAddress()
    }
    
    async getOutcome () {
        return (await this.runGetMethod('get_outcome')).readBoolean()
    }

    async getAmount () {
        return (await this.runGetMethod('get_amount')).readBigNumber()
    }

    static async getCode (): Promise<Cell> {
        let result = await compileFunc({
            targets: ['stdlib.fc', 'opcodes.fc', 'bet.fc'],
            sources: (path) => readFileSync('func/' + path).toString()
        })
        if (result.status === 'error') {
            throw(result.message)
        }
        return Cell.fromBoc(Buffer.from(result.codeBoc, 'base64'))[0]
    }

    static async getStateInit (owner: Address, event: Address, outcome: boolean, amount: bigint): Promise<{ code: Cell, data: Cell }> {
        return {
            code: await this.getCode(),
            data: beginCell()
                .storeAddress(owner)
                .storeAddress(event)
                .storeBit(outcome)
                .storeUint(amount, 256)
            .endCell()
        }
    }
}