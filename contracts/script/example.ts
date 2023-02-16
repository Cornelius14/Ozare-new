import axios from 'axios';
import { keyPairFromSecretKey } from 'ton-crypto/dist/index';
import {
  TonClient,
  WalletContractV3R2,
} from 'ton/dist/index';

import { Event } from '../wrappers/Event';

const liveScoreBaseUrl = `https://livescore6.p.rapidapi.com/matches/v2`;
const rapidApiKey = "07585b4120mshbc941a57c6ebd11p11de9bjsn089233df6ab2'"; 
// As long as the repo is private this (^) is alright, should be using a process.env on production for this,
// and squashing all commits before making repo public

const Category = {
  soccer: "soccer",
  cricket: "cricket",
  basketball: "basketball",
  tennis: "tennis",
  hockey: "hockey"
}

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
    
    const category = Category.basketball;

    const allMatches = await getAllMatchesByDate("20230312", category)
    const matchEid: string = allMatches.Stages[0].Events[0].Eid as string;

    const matchDetails = await getMatchDetails(matchEid, category);
    
    // Start event
    await event.startEvent(sender)

    // Finish event
    // result is boolean (true/false)
    // false => outcome 0
    // true => outcome 1
    const result: boolean = false // outcome 0
    await event.finishEvent(sender, result)
}

const getAllMatchesByDate = async (date: string, category: string, timezone: number = 0-7) => {
  /// This function is used to return all matches that 
  /// happen on the date var,
  /// the format of date is a "YYYYMMDD" since the api expects a string
  
  const options = {
    method: 'GET',
    url: `${liveScoreBaseUrl}/list-by-date`,
    params: {Category: category, Date: date, Timezone: timezone.toString()},
    headers: {
      'X-RapidAPI-Key': `${rapidApiKey}`,
      'X-RapidAPI-Host': 'livescore6.p.rapidapi.com'
    }
  };

  try {
    const resp = await axios.request(options)
    return resp.data
  } catch (e) {
    console.error(e)
  }
}

const getMatchDetails = async (eid: string, category: string) => {
  /// Returns a specific match's details

  const options = {
    method: 'GET',
    url: `${liveScoreBaseUrl}/get-scoreboard`,
    params: {Eid: eid, Category: category},
    headers: {
      'X-RapidAPI-Key': 'SIGN-UP-FOR-KEY',
      'X-RapidAPI-Host': 'livescore6.p.rapidapi.com'
    }
  };

  try {
    const resp = await axios.request(options)
    return resp.data
  } catch (e) {
    console.error(e)
  }
}

main()