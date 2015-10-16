From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH] i2c: at91: fix write transfers by clearing pending
 interrupt first
Date: Fri, 16 Oct 2015 11:08:42 +0200
Message-ID: <5620BE9A.10302@lysator.liu.se>
References: <1444746104-20615-1-git-send-email-ludovic.desroches@atmel.com>
 <561D20E7.5070405@lysator.liu.se> <561D359D.8000500@atmel.com>
 <561D46FE.4090801@lysator.liu.se> <20151014054321.GA20049@odux.rfo.atmel.com>
 <56203B0E.1030104@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:45659 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbJPJIy (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Oct 2015 05:08:54 -0400
In-Reply-To: <56203B0E.1030104@lysator.liu.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com

On 2015-10-16 01:47, Peter Rosin wrote:
> On 2015-10-14 07:43, Ludovic Desroches wrote:
>> On Tue, Oct 13, 2015 at 08:01:34PM +0200, Peter Rosin wrote:
>>> On 2015-10-13 18:47, Cyrille Pitchen wrote:
>>>> Le 13/10/2015 17:19, Peter Rosin a =E9crit :
>>>>> On 2015-10-13 16:21, Ludovic Desroches wrote:
>>>>>> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>>>>>>
>>>>>> In some cases a NACK interrupt may be pending in the Status Regi=
ster (SR)
>>>>>> as a result of a previous transfer. However at91_do_twi_transfer=
() did not
>>>>>> read the SR to clear pending interruptions before starting a new=
 transfer.
>>>>>> Hence a NACK interrupt rose as soon as it was enabled again at t=
he I2C
>>>>>> controller level, resulting in a wrong sequence of operations an=
d strange
>>>>>> patterns of behaviour on the I2C bus, such as a clock stretch fo=
llowed by
>>>>>> a restart of the transfer.
>>>>>>
>>>>>> This first issue occurred with both DMA and PIO write transfers.
>>>>>>
>>>>>> Also when a NACK error was detected during a PIO write transfer,=
 the
>>>>>> interrupt handler used to wrongly start a new transfer by writin=
g into the
>>>>>> Transmit Holding Register (THR). Then the I2C slave was likely t=
o reply
>>>>>> with a second NACK.
>>>>>>
>>>>>> This second issue is fixed in atmel_twi_interrupt() by handling =
the TXRDY
>>>>>> status bit only if both the TXCOMP and NACK status bits are clea=
red.
>>>>>>
>>>>>> Tested with a at24 eeprom on sama5d36ek board running a linux-4.=
1-at91
>>>>>> kernel image. Adapted to linux-next.
>>>>>>
>>>>>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>>>>>> Fixes: 93563a6a71bb ("i2c: at91: fix a race condition when using=
 the DMA controller")
>>>>>> Reported-by: Peter Rosin <peda@lysator.liu.se>
>>>>>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>>>> Cc: stable@vger.kernel.org #4.1
>>>>>
>>>>> The regression is gone with this patch (vanilla 4.2), thank you!
>>>>>
>>>>> However, looking at the bus, there are two NACKs after each
>>>>> successful chunk of memory written by the eeprom driver.
>>>>>
>>>>> Looking at the eeprom driver, I expect this on the bus:
>>>>>
>>>>> S 0x50 0x00 "hello there guys" P
>>>>> S 0x50 NACK P
>>>>> delay for at least 1 ms (since the eeprom driver has a msleep(1) =
call).
>>>>> S 0x50 NACK P
>>>>> delay for at least 1 ms
>>>>> ...
>>>>> ...
>>>>> S 0x50 NACK P
>>>>> delay for at least 1 ms
>>>>> S 0x50 0x10 "and girls\n" P
>>>>>
>>>>> This is not what I observe on the bus, most of the time there is =
a
>>>>> second NACK immediately following the first. I suspect that it is
>>>>> the i2c bus driver that somehow confuses itself and reissues the
>>>>> command for some reason?
>>>>>
>>>>> But this behavior has been there since the beginning, so it's pro=
bably
>>>>> orthogonal, and killing the data corrupting regression is much mo=
re
>>>>> important to me than fussing over a surplus failed transfer. Henc=
e
>>>>>
>>>>> Tested-by: Peter Rosin <peda@lysator.liu.se>
>>>>>
>>>>> Cheers,
>>>>> Peter
>>>>>
>>>>
>>>> Hi Peter,
>>>>
>>>> sama5d3x and sama5d4x don't support the so called "Alternative Com=
mand mode"
>>>> whereas sama5d2x do. The Alternative Command mode comes with a new=
 hardware
>>>> mechanism inside the I2C controller which locks the transmission o=
f data on
>>>> the I2C bus when a NACK is detected. It means that even if a data =
is written
>>>> into the THR, the I2C controller doesn't push this data on the I2C=
 bus but
>>>> retains the data in the THR (and its associated FIFO for sama5d2x =
and future
>>>> SoCs) until the driver unlocks the transmitter by writing the LOCK=
CLR (Lock
>>>> Clear) bit in the Control Register. Then and only then, the transm=
itter outputs
>>>> pending data again.
>>>> This new mechanism was introduced to cope with an unwanted DMA wri=
te into the
>>>> THR after a NACK. Indeed, as I've tried to explain in my patch, wh=
en a first
>>>> NACK is detected, the I2C controller sets the TXCOMP, NACK and TXR=
DY bits
>>>> alltogether in the Status Register. However setting the TXRDY bit =
also triggers
>>>> the DMA controller to write the next data into the THR. Pitifully,=
 WITHOUT the
>>>> new lock mechanism, writing into the THR starts a new I2C frame. S=
ince the
>>>> eeprom is likely not to be ready yet, it replies by a second NACK.=
 So you
>>>> see on the scope two consecutive NACKs.
>>>>
>>>> On sama5d3x and sama5d4x, which do not support this lock mechanism=
, you are
>>>> likely to see a successful write transfer followed by two NACKs th=
en a delay
>>>> and finally a new successful write transfer. This is the case 2b:
>>>>
>>>> 1 - A successfull write transfer is completed.
>>>> 2 - The at24 driver immediately tries to perform the next write tr=
ansfer...
>>>> 3 - ... but the eeprom is not ready yet and replies with a first N=
ACK.
>>>> 4 - The I2C controller detects this NACK and sets the NACK, TXCOMP=
 and TXRDY
>>>>     bits in its Status Register (and interrupts the CPU).
>>>> 5 - The DMA controller is triggered by the TXRDY bit to write the =
next data
>>>>     into the THR.
>>>> 6 - WITHTOUT the lock mechanism, the I2C controller starts a new f=
rame because
>>>>    of the write into the THR by the DMA controller...
>>>> 7 - ... but the eeprom is still not ready and replies with a secon=
d NACK.
>>>>
>>>> 8 - starting from 4, the CPU handles the interrupt generated by th=
e first NACK.
>>>>     Depending on the timing, it has already masked the interrupted=
 before the
>>>>     second NACK. In such a case, the NACK bit is pending in the St=
atus
>>>>     Register. Then it reports the first NACK error to the at24 dri=
ver.
>>>> 9 - The at24 driver handles the NACK error: it sleeps for a while =
before
>>>>     retrying to perform the write operation.
>>>> 10 - With the new patch, the I2C controller reads the Status Regis=
ter to clear
>>>>      pending (NACK) interrupts before actually starting this new (=
retried)
>>>>      transfer.
>>>>
>>>>
>>>> So if you are using DMA transfers on a sama5d3x board, you're are =
likely to
>>>> see, as I did see, a valid write transfer followed by 2 NACKs, the=
n a delay and
>>>> finally a new write transfer.
>>>> The 2nd NACK is not wanted but expected. Without the lock mechanis=
m, there is
>>>> nothing we can do at the I2C controller level. However a workaroun=
d may exist:
>>>> inserting a small delay after a successful write transfer should g=
ive the
>>>> eeprom enough time to be ready to process the next write so even t=
he first NACK
>>>> would disappear.
>>>> This is what I saw while debugging with dev_info() traces. Those t=
races had the
>>>> side effect of inserting delays hence changing the timing.
>>>>
>>>> As you see, we have to deal with some known hardware design quirks=
, which are
>>>> fixed by the lock mechanism. Without the lock mechanism, the inter=
rupt handler
>>>> and the CPU are likely to come too late to cancel the DMA transfer=
 before the
>>>> DMA controller writes a new byte into the THR, hence generating an=
 unwanted
>>>> frame.
>>>
>>> Ok, now I get it, I should have been reading the source code commen=
ts instead
>>> of the commit message. My bad. That 2a) case from the atmel_twi_int=
errupt comment
>>> seems very nasty indeed! Is it clear what will happen if the second=
 frame after
>>> the first NACKed frame isn't NACKed too? May that transfer be cance=
led half way
>>> through at a later point, or will it be a complete transfer as spec=
ified by the
>>> issuing driver? What will be reported to the issuing driver for suc=
h an i2c
>>> transfer that was first NACKed but then wasn't in the second traili=
ng frame?
>>>
>>
>> We were discussing about this case and we are worried that it simply
>> hangs the transfer wihout sending a stop command. We never get this =
case
>> yet so we keep it in mind but we don't correct it since we are not s=
ure
>> of the behavior and on side effects it can introduce. I think the
>> i2c-at91 driver will return a spurious error to the eeprom driver bu=
t it won't
>> let the physical i2c bus in a proper state.
>=20
> I have started to get this when I run with this patch:
>=20
> [   73.310000] at91_i2c f0014000.i2c: RXRDY still set!
> [  198.200000] at91_i2c f0014000.i2c: RXRDY still set!
> [  509.880000] at91_i2c f0014000.i2c: RXRDY still set!
> [  615.750000] at91_i2c f0014000.i2c: RXRDY still set!
> [  617.750000] at91_i2c f0014000.i2c: RXRDY still set!
> [ 1766.640000] at91_i2c f0014000.i2c: RXRDY still set!
> [ 2035.380000] at91_i2c f0014000.i2c: RXRDY still set!
> [ 2227.190000] at91_i2c f0014000.i2c: RXRDY still set!
> [ 2313.100000] at91_i2c f0014000.i2c: RXRDY still set!
>=20
> My USB serial dongle was hung which was why I didn't notice until jus=
t now.
>=20
> This is probably not when communication with the eeprom though, and c=
ertainly not
> writing to it, but perhpaps when polling the temperature (using the j=
c42 driver).
> I'll investigate further in the morning to see if I can pinpoint it.

Yep, it's the jc42 accesses that triggers this (to the same chip as the
eeprom, but a different block of transistors I suppose).

Looking at the i2c bus, the accesses normally go like this:

[0.000000] S 0x18 W 0x05 S 0x18 R 0xc1 0xbe NACK P
[0.000521] S 0x18 W 0x04 S 0x18 R 0x00 0x00 NACK P
[0.001024] S 0x18 W 0x03 S 0x18 R 0x00 0x00 NACK P
[0.001524] S 0x18 W 0x02 S 0x18 R 0x00 0x00 NACK P
[0.196991] S 0x18 W 0x05 S 0x18 R 0xc1 0xbe NACK P
[0.197514] S 0x18 W 0x04 S 0x18 R 0x00 0x00 NACK P
[0.198019] S 0x18 W 0x03 S 0x18 R 0x00 0x00 NACK P
[0.198520] S 0x18 W 0x02 S 0x18 R 0x00 0x00 NACK P

I.e. chunks of four transfers every ~200 ms (I removed the 1Hz rate
limiter in the jc42 driver to get more frequent incidents).

But when the diagnostic (RXRDY still set!) is output it continues
with this:

[0.399755] S 0x18 W 0x05 S 0x18 R 0xc1 0xbe NACK P
[0.404998] S 0x18 W 0x04 S 0x18 R 0x00 0x00 NACK P
[0.405508] S 0x18 W 0x03 S 0x18 R 0x00 0x00 NACK P
[0.406008] S 0x18 W 0x02 S 0x18 R 0x00 0x00 NACK P

Notice the ~5 ms delay (about the time it should take to output
the diagnostic at 115200 baud) after the access to register 0x05
at 0.399755.

This is the only thing that I can observe on the bus, so it appears
to be harmless.

It appears that the i2c access at 0.399755 finds the TWI
registers in an odd state, but nothing from the access at
0.198520 appears to have gone wrong. Is this a race? Anyway,
the diagnostic is pretty frequent and annoying. printk_once?

Cheers,
Peter
