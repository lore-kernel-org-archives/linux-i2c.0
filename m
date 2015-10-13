From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: Re: [PATCH] i2c: at91: fix write transfers by clearing pending
 interrupt first
Date: Tue, 13 Oct 2015 18:47:25 +0200
Message-ID: <561D359D.8000500@atmel.com>
References: <1444746104-20615-1-git-send-email-ludovic.desroches@atmel.com>
 <561D20E7.5070405@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561D20E7.5070405@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@lysator.liu.se>, Ludovic Desroches <ludovic.desroches@atmel.com>, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com
List-Id: linux-i2c@vger.kernel.org

Le 13/10/2015 17:19, Peter Rosin a =E9crit :
> On 2015-10-13 16:21, Ludovic Desroches wrote:
>> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>>
>> In some cases a NACK interrupt may be pending in the Status Register=
 (SR)
>> as a result of a previous transfer. However at91_do_twi_transfer() d=
id not
>> read the SR to clear pending interruptions before starting a new tra=
nsfer.
>> Hence a NACK interrupt rose as soon as it was enabled again at the I=
2C
>> controller level, resulting in a wrong sequence of operations and st=
range
>> patterns of behaviour on the I2C bus, such as a clock stretch follow=
ed by
>> a restart of the transfer.
>>
>> This first issue occurred with both DMA and PIO write transfers.
>>
>> Also when a NACK error was detected during a PIO write transfer, the
>> interrupt handler used to wrongly start a new transfer by writing in=
to the
>> Transmit Holding Register (THR). Then the I2C slave was likely to re=
ply
>> with a second NACK.
>>
>> This second issue is fixed in atmel_twi_interrupt() by handling the =
TXRDY
>> status bit only if both the TXCOMP and NACK status bits are cleared.
>>
>> Tested with a at24 eeprom on sama5d36ek board running a linux-4.1-at=
91
>> kernel image. Adapted to linux-next.
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>> Fixes: 93563a6a71bb ("i2c: at91: fix a race condition when using the=
 DMA controller")
>> Reported-by: Peter Rosin <peda@lysator.liu.se>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>> Cc: stable@vger.kernel.org #4.1
>=20
> The regression is gone with this patch (vanilla 4.2), thank you!
>=20
> However, looking at the bus, there are two NACKs after each
> successful chunk of memory written by the eeprom driver.
>=20
> Looking at the eeprom driver, I expect this on the bus:
>=20
> S 0x50 0x00 "hello there guys" P
> S 0x50 NACK P
> delay for at least 1 ms (since the eeprom driver has a msleep(1) call=
).
> S 0x50 NACK P
> delay for at least 1 ms
> ...
> ...
> S 0x50 NACK P
> delay for at least 1 ms
> S 0x50 0x10 "and girls\n" P
>=20
> This is not what I observe on the bus, most of the time there is a
> second NACK immediately following the first. I suspect that it is
> the i2c bus driver that somehow confuses itself and reissues the
> command for some reason?
>=20
> But this behavior has been there since the beginning, so it's probabl=
y
> orthogonal, and killing the data corrupting regression is much more
> important to me than fussing over a surplus failed transfer. Hence
>=20
> Tested-by: Peter Rosin <peda@lysator.liu.se>
>=20
> Cheers,
> Peter
>=20

Hi Peter,

sama5d3x and sama5d4x don't support the so called "Alternative Command =
mode"
whereas sama5d2x do. The Alternative Command mode comes with a new hard=
ware
mechanism inside the I2C controller which locks the transmission of dat=
a on
the I2C bus when a NACK is detected. It means that even if a data is wr=
itten
into the THR, the I2C controller doesn't push this data on the I2C bus =
but
retains the data in the THR (and its associated FIFO for sama5d2x and f=
uture
SoCs) until the driver unlocks the transmitter by writing the LOCKCLR (=
Lock
Clear) bit in the Control Register. Then and only then, the transmitter=
 outputs
pending data again.
This new mechanism was introduced to cope with an unwanted DMA write in=
to the
THR after a NACK. Indeed, as I've tried to explain in my patch, when a =
first
NACK is detected, the I2C controller sets the TXCOMP, NACK and TXRDY bi=
ts
alltogether in the Status Register. However setting the TXRDY bit also =
triggers
the DMA controller to write the next data into the THR. Pitifully, WITH=
OUT the
new lock mechanism, writing into the THR starts a new I2C frame. Since =
the
eeprom is likely not to be ready yet, it replies by a second NACK. So y=
ou
see on the scope two consecutive NACKs.

On sama5d3x and sama5d4x, which do not support this lock mechanism, you=
 are
likely to see a successful write transfer followed by two NACKs then a =
delay
and finally a new successful write transfer. This is the case 2b:

1 - A successfull write transfer is completed.
2 - The at24 driver immediately tries to perform the next write transfe=
r...
3 - ... but the eeprom is not ready yet and replies with a first NACK.
4 - The I2C controller detects this NACK and sets the NACK, TXCOMP and =
TXRDY
    bits in its Status Register (and interrupts the CPU).
5 - The DMA controller is triggered by the TXRDY bit to write the next =
data
    into the THR.
6 - WITHTOUT the lock mechanism, the I2C controller starts a new frame =
because
   of the write into the THR by the DMA controller...
7 - ... but the eeprom is still not ready and replies with a second NAC=
K.

8 - starting from 4, the CPU handles the interrupt generated by the fir=
st NACK.
    Depending on the timing, it has already masked the interrupted befo=
re the
    second NACK. In such a case, the NACK bit is pending in the Status
    Register. Then it reports the first NACK error to the at24 driver.
9 - The at24 driver handles the NACK error: it sleeps for a while befor=
e
    retrying to perform the write operation.
10 - With the new patch, the I2C controller reads the Status Register t=
o clear
     pending (NACK) interrupts before actually starting this new (retri=
ed)
     transfer.


So if you are using DMA transfers on a sama5d3x board, you're are likel=
y to
see, as I did see, a valid write transfer followed by 2 NACKs, then a d=
elay and
finally a new write transfer.
The 2nd NACK is not wanted but expected. Without the lock mechanism, th=
ere is
nothing we can do at the I2C controller level. However a workaround may=
 exist:
inserting a small delay after a successful write transfer should give t=
he
eeprom enough time to be ready to process the next write so even the fi=
rst NACK
would disappear.
This is what I saw while debugging with dev_info() traces. Those traces=
 had the
side effect of inserting delays hence changing the timing.

As you see, we have to deal with some known hardware design quirks, whi=
ch are
fixed by the lock mechanism. Without the lock mechanism, the interrupt =
handler
and the CPU are likely to come too late to cancel the DMA transfer befo=
re the
DMA controller writes a new byte into the THR, hence generating an unwa=
nted
frame.

Best Regards,

Cyrille
