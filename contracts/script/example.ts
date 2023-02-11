import { TonClient, WalletContractV3R2 } from 'ton'
import { keyPairFromSecretKey } from 'ton-crypto'
import { Event } from '../wrappers/Event'

async function main () {
    // create 
    const client = new TonClient({
        endpoint: 'https://toncenter.com/api/v2/jsonRPC',
        apiKey: 'YOUR_API_KEY'
    })

    const keypair = keyPairFromSecretKey(Buffer.from('1234abcd'))

    const wallet = WalletContractV3R2.create({
        workchain: 0,
        publicKey: keypair.publicKey
    })

    const sender = wallet.sender(
        client.provider(wallet.address, wallet.init),
        keypair.secretKey
    )

    // Deploy new Event contract
    const event = await Event.create(client, wallet.address, 123)
    await event.deploy(sender)

    // Get the Event address
    const addr = event.address

    // Start event
    await event.startEvent(sender)

    // Finish event
    // result is boolean (true/false)
    // false => outcome 0
    // true => outcome 1
    const result: boolean = false // outcome 0
    await event.finishEvent(sender, result)
}

main()