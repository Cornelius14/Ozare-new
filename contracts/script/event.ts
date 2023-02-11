import { Address, Sender } from 'ton-core'
import { TonClient } from 'ton'
import { Event } from '../wrappers/Event'

async function deployEvent (client: TonClient, oracle: Sender, uid: number): Promise<Event> {
    const event = await Event.create(client, oracle.address!, uid++)
    await event.deploy(oracle)
    return event
}