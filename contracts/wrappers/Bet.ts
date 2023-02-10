import { Address, beginCell, Cell, Contract, ContractProvider, Sender, StateInit, toNano } from 'ton-core'
import { compileFunc } from '@ton-community/func-js'
import { readFileSync } from 'fs';

export class Bet implements Contract {
    constructor (readonly address: Address) {}

    async close (provider: ContractProvider, via: Sender) {
        await provider.internal(via, {
            value: toNano('0.05'),
            body: beginCell()
                .storeUint(0x12d4de36, 32)
            .endCell()
        })
    }

    async deposit (provider: ContractProvider, via: Sender, params: { amount: bigint }) {
        await provider.internal(via, {
            value: toNano('0.05'),
            body: beginCell()
                .storeUint(0x49d59d40, 32)
                .storeUint(params.amount, 256)
            .endCell()
        })
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