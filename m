From: "M'boumba Cedric Madianga" <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 2/5] i2c: Add STM32F4 I2C driver
Date: Thu, 12 Jan 2017 21:58:23 +0100
Message-ID: <CAOAejn3tPi0fjy+t-UhMTvAq7LfdKJJdbcLw2su1-YAGDZMxew@mail.gmail.com>
References: <1483607246-14771-1-git-send-email-cedric.madianga@gmail.com>
 <1483607246-14771-3-git-send-email-cedric.madianga@gmail.com>
 <20170111082208.vzu7xgpd4eakyldl@pengutronix.de> <CAOAejn2eOy2sn1VkE979ne23Sj9L6+kaQDNpL1EUKb2m=6sGXw@mail.gmail.com>
 <20170111153940.dtxzvtdici3r7l54@pengutronix.de> <CAOAejn2pW20VPP_yGtvJ_ufvj6Xj1poBiiA2WqkALiaLyyONug@mail.gmail.com>
 <20170112120309.fmrt2lwz3vklqmti@pengutronix.de> <CAOAejn289GLOSP-nPJnO_VpXLpyhTsF1bWQ7Ns9OfgPQCa8YTw@mail.gmail.com>
 <20170112174902.j52foglkdouyz36n@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170112174902.j52foglkdouyz36n-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2017-01-12 18:49 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>:
> On Thu, Jan 12, 2017 at 02:47:42PM +0100, M'boumba Cedric Madianga wrote:
>> 2017-01-12 13:03 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengut=
ronix.de>:
>> > Hello Cedric,
>> >
>> > On Thu, Jan 12, 2017 at 12:23:12PM +0100, M'boumba Cedric Madianga wro=
te:
>> >> 2017-01-11 16:39 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pen=
gutronix.de>:
>> >> > On Wed, Jan 11, 2017 at 02:58:44PM +0100, M'boumba Cedric Madianga =
wrote:
>> >> >> 2017-01-11 9:22 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@p=
engutronix.de>:
>> >> >> > This is surprising. I didn't recheck the manual, but that looks =
very
>> >> >> > uncomfortable.
>> >> >>
>> >> >> I agree but this exactly the hardware way of working described in =
the
>> >> >> reference manual.
>> >> >
>> >> > IMHO that's a hw bug. This makes it for example impossible to imple=
ment
>> >> > SMBus block transfers (I think).
>> >>
>> >> This is not correct.
>> >> Setting STOP/START bit does not mean the the pulse will be sent right=
 now.
>> >> Here we have just to prepare the hardware for the 2 next pulse but th=
e
>> >> STOP/START/ACK pulse will be generated at the right time as required
>> >> by I2C specification.
>> >> So SMBus block transfer will be possible.
>> >
>> > A block transfer consists of a byte that specifies the count of bytes
>> > yet to come. So the device sends for example:
>> >
>> >         0x01 0xab
>> >
>> > So when you read the 1 in the first byte it's already too late to set
>> > STOP to get it after the 2nd byte.
>> >
>> > Not sure I got all the required details right, though.
>>
>> Ok I understand your use case but I always think that the harware manage=
s it.
>> If I take the above example, the I2C SMBus block read transaction will
>> be as below:
>> S Addr Wr [A] Comm [A]
>>            S Addr Rd [A] [Count] A [Data1] A [Data2] NA P
>>
>> The first message is a single byte-transmission so there is no problem.
>>
>> The second message is a N-byte reception with N =3D 3
>>
>> When the I2C controller has finished to send the device address (S
>> Addr Rd), the ADDR flag is set and an interrupt is raised.
>> In the routine that handles ADDR event, we set ACK bit in order to
>> generate ACK pulse as soon as a data byte is received in the shift
>> register and then we clear the ADDR flag.
>> Please note that the SCL line is stretched low until ADDR flag is cleare=
d.
>> So, as far I understand, the device could not sent any data as long as
>> the SCL line is stretched low. Right ?
>>
>> Then, as soon as the SCL line is high, the device could send the first
>> data byte (Count).
>> When this byte is received in the shift register, an ACK is
>> automatically generated as defined during adress match phase and the
>> data byte is pushed in DR (data register).
>> Then, an interrupt is raised as RXNE (RX not empty) flag is set.
>> In the routine that handles RXNE event, as N=3D3, we just clear all
>> buffer interrupts in order to avoid another system preemption due to
>> RXNE event but we does not read the data in DR.
>
> In my example I want to receive a block of length 1, so only two bytes
> are read, a 1 (the length) and the data byte (0xab in my example). I
> think that as soon as you read the 1 it's already to late to schedule
> the NA after the next byte?

Not really. This 2-byte reception is also correctly managed.
Indeed, in this case, when the controller has sent the device address,
the ADDR flag is set and an interrupt is raised.
So, as long as the ADDR flag is not cleared, the SCL line is stretched
low and the device could not send any data.
During this address match phase, for a 2-byte reception, we enable
NACK and set POS bit (ACK/NACK position).
As POS=3D1, the NACK will be sent for the next byte which will be
received in the shift register instead of the current one.
So in this example, the next byte will be the last one.
After that, we clear the ADDR flag and the device is allowed to send data.

When the first data is received in the shift register,  the RXNE flag
is set and an interrupt is raised.
As it is a 2-byte reception, we just clear all interrupts buffer to
avoid another preemption due to RXNE but we does not read DR.

Then, the second and last byte is received in the shift register.
The NACK is automatically sent by I2C controller as it was configured
to do that in the address match phase described above.
Moereover, as the first byte has not been read in DR, the BTF event
flag is set and an interrupt is raised.
Again, the SCL line is stretching low as long as data register has not
been read.
In the meantime, we set STOP bit to generate the pulse and we launch 2
consecutive read of DR to retrieve the 2 data bytes and release SCL
stretching.

In that way, NA and STOP are generated as expected even for a 2-byte recept=
ion.

Best regards,

Cedric
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
