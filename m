From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH] i2c: at91: fix write transfers by clearing pending
 interrupt first
Date: Tue, 13 Oct 2015 20:01:34 +0200
Message-ID: <561D46FE.4090801@lysator.liu.se>
References: <1444746104-20615-1-git-send-email-ludovic.desroches@atmel.com>
 <561D20E7.5070405@lysator.liu.se> <561D359D.8000500@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561D359D.8000500@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com
List-Id: linux-i2c@vger.kernel.org

On 2015-10-13 18:47, Cyrille Pitchen wrote:
> Le 13/10/2015 17:19, Peter Rosin a =E9crit :
>> On 2015-10-13 16:21, Ludovic Desroches wrote:
>>> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>>>
>>> In some cases a NACK interrupt may be pending in the Status Registe=
r (SR)
>>> as a result of a previous transfer. However at91_do_twi_transfer() =
did not
>>> read the SR to clear pending interruptions before starting a new tr=
ansfer.
>>> Hence a NACK interrupt rose as soon as it was enabled again at the =
I2C
>>> controller level, resulting in a wrong sequence of operations and s=
trange
>>> patterns of behaviour on the I2C bus, such as a clock stretch follo=
wed by
>>> a restart of the transfer.
>>>
>>> This first issue occurred with both DMA and PIO write transfers.
>>>
>>> Also when a NACK error was detected during a PIO write transfer, th=
e
>>> interrupt handler used to wrongly start a new transfer by writing i=
nto the
>>> Transmit Holding Register (THR). Then the I2C slave was likely to r=
eply
>>> with a second NACK.
>>>
>>> This second issue is fixed in atmel_twi_interrupt() by handling the=
 TXRDY
>>> status bit only if both the TXCOMP and NACK status bits are cleared=
=2E
>>>
>>> Tested with a at24 eeprom on sama5d36ek board running a linux-4.1-a=
t91
>>> kernel image. Adapted to linux-next.
>>>
>>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>>> Fixes: 93563a6a71bb ("i2c: at91: fix a race condition when using th=
e DMA controller")
>>> Reported-by: Peter Rosin <peda@lysator.liu.se>
>>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>>> Cc: stable@vger.kernel.org #4.1
>>
>> The regression is gone with this patch (vanilla 4.2), thank you!
>>
>> However, looking at the bus, there are two NACKs after each
>> successful chunk of memory written by the eeprom driver.
>>
>> Looking at the eeprom driver, I expect this on the bus:
>>
>> S 0x50 0x00 "hello there guys" P
>> S 0x50 NACK P
>> delay for at least 1 ms (since the eeprom driver has a msleep(1) cal=
l).
>> S 0x50 NACK P
>> delay for at least 1 ms
>> ...
>> ...
>> S 0x50 NACK P
>> delay for at least 1 ms
>> S 0x50 0x10 "and girls\n" P
>>
>> This is not what I observe on the bus, most of the time there is a
>> second NACK immediately following the first. I suspect that it is
>> the i2c bus driver that somehow confuses itself and reissues the
>> command for some reason?
>>
>> But this behavior has been there since the beginning, so it's probab=
ly
>> orthogonal, and killing the data corrupting regression is much more
>> important to me than fussing over a surplus failed transfer. Hence
>>
>> Tested-by: Peter Rosin <peda@lysator.liu.se>
>>
>> Cheers,
>> Peter
>>
>=20
> Hi Peter,
>=20
> sama5d3x and sama5d4x don't support the so called "Alternative Comman=
d mode"
> whereas sama5d2x do. The Alternative Command mode comes with a new ha=
rdware
> mechanism inside the I2C controller which locks the transmission of d=
ata on
> the I2C bus when a NACK is detected. It means that even if a data is =
written
> into the THR, the I2C controller doesn't push this data on the I2C bu=
s but
> retains the data in the THR (and its associated FIFO for sama5d2x and=
 future
> SoCs) until the driver unlocks the transmitter by writing the LOCKCLR=
 (Lock
> Clear) bit in the Control Register. Then and only then, the transmitt=
er outputs
> pending data again.
> This new mechanism was introduced to cope with an unwanted DMA write =
into the
> THR after a NACK. Indeed, as I've tried to explain in my patch, when =
a first
> NACK is detected, the I2C controller sets the TXCOMP, NACK and TXRDY =
bits
> alltogether in the Status Register. However setting the TXRDY bit als=
o triggers
> the DMA controller to write the next data into the THR. Pitifully, WI=
THOUT the
> new lock mechanism, writing into the THR starts a new I2C frame. Sinc=
e the
> eeprom is likely not to be ready yet, it replies by a second NACK. So=
 you
> see on the scope two consecutive NACKs.
>=20
> On sama5d3x and sama5d4x, which do not support this lock mechanism, y=
ou are
> likely to see a successful write transfer followed by two NACKs then =
a delay
> and finally a new successful write transfer. This is the case 2b:
>=20
> 1 - A successfull write transfer is completed.
> 2 - The at24 driver immediately tries to perform the next write trans=
fer...
> 3 - ... but the eeprom is not ready yet and replies with a first NACK=
=2E
> 4 - The I2C controller detects this NACK and sets the NACK, TXCOMP an=
d TXRDY
>     bits in its Status Register (and interrupts the CPU).
> 5 - The DMA controller is triggered by the TXRDY bit to write the nex=
t data
>     into the THR.
> 6 - WITHTOUT the lock mechanism, the I2C controller starts a new fram=
e because
>    of the write into the THR by the DMA controller...
> 7 - ... but the eeprom is still not ready and replies with a second N=
ACK.
>=20
> 8 - starting from 4, the CPU handles the interrupt generated by the f=
irst NACK.
>     Depending on the timing, it has already masked the interrupted be=
fore the
>     second NACK. In such a case, the NACK bit is pending in the Statu=
s
>     Register. Then it reports the first NACK error to the at24 driver=
=2E
> 9 - The at24 driver handles the NACK error: it sleeps for a while bef=
ore
>     retrying to perform the write operation.
> 10 - With the new patch, the I2C controller reads the Status Register=
 to clear
>      pending (NACK) interrupts before actually starting this new (ret=
ried)
>      transfer.
>=20
>=20
> So if you are using DMA transfers on a sama5d3x board, you're are lik=
ely to
> see, as I did see, a valid write transfer followed by 2 NACKs, then a=
 delay and
> finally a new write transfer.
> The 2nd NACK is not wanted but expected. Without the lock mechanism, =
there is
> nothing we can do at the I2C controller level. However a workaround m=
ay exist:
> inserting a small delay after a successful write transfer should give=
 the
> eeprom enough time to be ready to process the next write so even the =
first NACK
> would disappear.
> This is what I saw while debugging with dev_info() traces. Those trac=
es had the
> side effect of inserting delays hence changing the timing.
>=20
> As you see, we have to deal with some known hardware design quirks, w=
hich are
> fixed by the lock mechanism. Without the lock mechanism, the interrup=
t handler
> and the CPU are likely to come too late to cancel the DMA transfer be=
fore the
> DMA controller writes a new byte into the THR, hence generating an un=
wanted
> frame.

Ok, now I get it, I should have been reading the source code comments i=
nstead
of the commit message. My bad. That 2a) case from the atmel_twi_interru=
pt comment
seems very nasty indeed! Is it clear what will happen if the second fra=
me after
the first NACKed frame isn't NACKed too? May that transfer be canceled =
half way
through at a later point, or will it be a complete transfer as specifie=
d by the
issuing driver? What will be reported to the issuing driver for such an=
 i2c
transfer that was first NACKed but then wasn't in the second trailing f=
rame?

My guess is that the issuing driver will get the result of the first NA=
CK, and
that anything after that didn't really happen as far as the rest of the=
 kernel
is concerned? And while that is OK for my eeprom case, it might not be =
for any
other i2c device, where a spurious access might destruct important stat=
e such
as bits that are cleared on read, or something like that. Or am I missi=
ng
something?

Some warning about using DMA for i2c on sama5d[34]x might be in place i=
f
I'm correct, no?

Cheers,
Peter
