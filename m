From: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Mon, 15 Mar 2010 11:43:48 +0200
Message-ID: <af0693f01003150243u4d4d76e7t71b37ecd452896ea@mail.gmail.com>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	 <af0693f01002220812n5a6060cejc00d1ebbd7b9424d@mail.gmail.com>
	 <20100222225805.00432574@hyperion.delvare>
	 <af0693f01002231521q4f99eb63ocd607670625fadfa@mail.gmail.com>
	 <20100228120817.275ef279@hyperion.delvare>
	 <af0693f01002280545n622b1c41v1f8c104e57fb51b6@mail.gmail.com>
	 <20100228211949.3297a0ff@hyperion.delvare>
	 <af0693f01003020453m7ca6891bjca4833c7fa45f44d@mail.gmail.com>
	 <20100312141901.04299a55@hyperion.delvare>
	 <20100312172421.5b4907e6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100312172421.5b4907e6-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Fri, Mar 12, 2010 at 6:24 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Fri, 12 Mar 2010 14:19:01 +0100, Jean Delvare wrote:
>> This is an interesting point. During simple transactions, or block
>> transactions under E32B, we don't really care about the delay, because
>> the controller takes care of the transaction on its own, and the only
>> thing the delay affects is how long the user waits for the answer. For
>> block transactions without E32B, it's different because the bus is
>> really waiting for us to trigger the sending or receiving of the next
>> data byte, so if we wait too long, we keep the bus busy for a long
>> time, which is bad both for multi-master buses, and when talking to a
>> slave which stops data processing while an I2C transaction is in
>> progress. I presume that some masters or slaves would even consider
>> that a transaction is stuck if it waits too long without sending
>> data. The SMBus specification defines the hardware timeout as 25 ms.
>>
>> The SMBus specification defines Tlow:mext as the maximum delay between
>> data bytes on the wire, with value 10 ms. While msleep(1) at HZ=1000
>> should be fine in this respect (it will sleep 2 ms max), and even at
>> HS=250 (it will sleep 8 ms max), it is not OK at HZ=100, as msleep(1)
>> may sleep up to 20 ms. Fortunately this is still below the hardware
>> timeout of 25 ms. msleep(0) may be better, but I'm not sure if it is
>> semantically acceptable (only one driver is using it so far). So maybe
>> we should indeed not sleep at this point. That being said, your naive
>> patch is hardly acceptable as is, as it may lead us to busy-wait for
>> 100 * 100 us = 10 ms. It also shortens the timeout from 200 ms (at
>> HZ=1000) to 10 ms, which I think is too short.
>>
>> If you have observed the ICH9 SMBus on the scope, can you tell me at
>> which frequency it is operating? If udelay(100) was always sufficient,
>> this suggests a bus frequency of at least 90 kHz, which is much faster
>> than I expected...
>
> FWIW, testing on my ICH3-M (SMBus block read), I get a delay between
> bytes of 460 us. This is a maximum bus speed of 19.6 kHz. Same test on
> an ICH5 reports a delay of 670 us, which would be 13.5 kHz max. I have
> a hard time believing that you got delays below 100 us on your ICH9...
>
> Also note that, in both cases, the first delay is always much larger,
> as the controller must send the beginning of the transaction up to the
> second data byte. The SMBus block read is the worst case scenario, as
> it must first send an address byte, the command byte, then the address
> byte again (direction change), then it reads the block length and
> finally the first data byte. This is 45 bits on the wire, not counting
> the start conditions. I get a ~2380 us delay on ICH3-M and ~3420 us
> delay on ICH5.
>
> So changing the code the way you suggested isn't trivial. Busy-waiting
> for up to 3500 us for the first transaction isn't very appealing.
> Busy-waiting for a total of 3500 + 670 * 31 (worst case) = 24270 us or
> almost 25 ms, is hardly pleasant either, latency will suffer, it's
> almost worse than software bit-banging. Now I have to agree that the
> current implementation ("long" sleeps) isn't good either. Maybe the
> msleep(0) approach would be the least evil... Oh well, at some point we
> really want to switch to interrupts.
Thanks for prompt reply :)
I'll provided more number later on, once I get to it in the lab.
I have it in my mind to dig into ICH9 data sheet (for the start) to
add interrupt support.
Btw, have anyone started it?

Thanks,
Felix R.
