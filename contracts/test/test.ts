import { ContractSystem } from 'ton-emulator'
import { Contract, contractAddress, OpenedContract, toNano, CommonMessageInfoInternal } from 'ton-core'
import { expect } from 'chai'
import { Bet } from '../wrappers/Bet'
import { Event } from '../wrappers/Event'
import { Treasure } from 'ton-emulator/dist/treasure/Treasure'

describe('ozare contracts', () => {
    var system: ContractSystem
    var oracle: Treasure
    var players: Treasure[] = []

    beforeEach(async () => {
        system = await ContractSystem.create()
        oracle = await system.treasure('oracle')
        for (let i = 0; i < 10; i += 1) {
            players.push(await system.treasure('player' + i))
        }
    })

    it('should accept bets', async () => {
        const event = await Event.create(system, oracle.address)
        await event.bet(players[0], false, toNano('1'))
        let txs = await system.run()
        expect(txs).to.have.lengthOf(4)
        expect(txs[2].endStatus).to.equal('active')
        if (txs[3].inMessage?.info.type == 'internal') {
            expect(txs[3].inMessage?.info.value.coins).to.equal(49000000n)
        }

        await event.bet(players[1], true, toNano('2'))
        txs = await system.run()
        expect(txs).to.have.lengthOf(4)
        expect(txs[2].endStatus).to.equal('active')
        if (txs[3].inMessage?.info.type == 'internal') {
            expect(txs[3].inMessage?.info.value.coins).to.equal(49000000n)
        }

        const [amountA, amountB] = await event.getTotalBets()
        expect(amountA).to.be.equal(toNano('1'))
        expect(amountB).to.be.equal(toNano('2'))
    })
})