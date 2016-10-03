From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 2/7] i2c: bcm2835: Protect against unexpected TXW/RXR interrupts
Date: Mon, 03 Oct 2016 11:58:32 -0700
Message-ID: <878tu5xns7.fsf@eliezer.anholt.net>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org> <1475085056-5205-3-git-send-email-noralf@tronnes.org> <87oa37fzx6.fsf@eliezer.anholt.net> <d93a0590-1783-b913-9362-007628cb17d6@tronnes.org> <1708178720.178936.b155d019-5320-4754-bbe2-4afc1ae71cd6.open-xchange@email.1und1.de> <0c943ee9-d152-79c4-2ad7-8a88c2d9c960@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c943ee9-d152-79c4-2ad7-8a88c2d9c960@tronnes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, Stefan Wahren <stefan.wahren@i2se.com>, wsa@the-dreams.de, swarren@wwwdotorg.org
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Noralf Tr=C3=B8nnes <noralf@tronnes.org> writes:

> Den 29.09.2016 07:37, skrev Stefan Wahren:
>>> Noralf Tr=C3=B8nnes <noralf@tronnes.org> hat am 29. September 2016 um 0=
0:22
>>> geschrieben:
>>>
>>>
>>>
>>> Den 29.09.2016 00:00, skrev Eric Anholt:
>>>> Noralf Tr=C3=B8nnes <noralf@tronnes.org> writes:
>>>>
>>>>> If an unexpected TXW or RXR interrupt occurs (msg_buf_remaining =3D=
=3D 0),
>>>>> the driver has no way to fill/drain the FIFO to stop the interrupts.
>>>>> In this case the controller has to be disabled and the transfer
>>>>> completed to avoid hang.
>>>>>
>>>>> (CLKT | ERR) and DONE interrupts are completed in their own paths, and
>>>>> the controller is disabled in the transfer function after completion.
>>>>> Unite the code paths and do disabling inside the interrupt routine.
>>>>>
>>>>> Clear interrupt status bits in the united completion path instead of
>>>>> trying to do it on every interrupt which isn't necessary.
>>>>> Only CLKT, ERR and DONE can be cleared that way.
>>>>>
>>>>> Add the status value to the error value in case of TXW/RXR errors to
>>>>> distinguish them from the other S_LEN error.
>>>> I was surprised that not writing the TXW/RXR bits on handling their
>>>> interrupts was OK, given that we were doing so before, but it's a level
>>>> interrupt and those bits are basically ignored on write.
>>>>
>>>> This patch and 3, 4, and 6 are:
>>>>
>>>> Reviewed-by: Eric Anholt <eric@anholt.net>
>>>>
>>>> Patch 5 is:
>>>>
>>>> Acked-by: Eric Anholt <eric@anholt.net>
>>>>
>>>> Note for future debug: The I2C_C_CLEAR on errors will take some time to
>>>> resolve -- if you were in non-idle state and I2C_C_READ, it sets an
>>>> abort_rx flag and runs through the state machine to send a NACK and a
>>>> STOP, I think.  Since we're setting CLEAR without I2CEN, that NACK will
>>>> be hanging around queued up for next time we start the engine.
>>> Maybe you're able to explain the issues I had with reset:
>>> https://github.com/raspberrypi/linux/issues/1653
>>>
>>> Should we put your note into the commit message?
>>> It will most likely be lost if it just stays in this email.
>> I prefer to have this kind of information as a code comment.
>
> Eric, does this look good to you as a code comment:
>
> /*
>   * Note about I2C_C_CLEAR on error:
>   * The I2C_C_CLEAR on errors will take some time to resolve -- if you=20
> were in
>   * non-idle state and I2C_C_READ, it sets an abort_rx flag and runs thro=
ugh
>   * the state machine to send a NACK and a STOP. Since we're setting CLEAR
>   * without I2CEN, that NACK will be hanging around queued up for next ti=
me
>   * we start the engine.
>   */
>
>
> If it is, I'll resend the series with this change and add all the ack's=20
> and r-b's.

Looks good to me.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX8qpYAAoJELXWKTbR/J7omKoP/2G6uscvNV2eb94PSgQMM55A
gg7tPKmH/RCbASyFj3N3m4PCo9+SSz20+aIIr39amG2d1h1rAo6YXunq0FbGSw4m
G8eAtu16FBzhhx8oDoVnPAmNpUqwhuXKJ3OkdUtkZvqCBfMMhMbnNBgnXcjbOU8b
DQiSj1cw0Q+hUgZ60S3RufyEeLfS+p8O6ojUkHBPVmg/AB+eEclnz3NlQgu2dnbC
fR9dlyTb6HSHFotb8UF+ExgOWMaPyc/WpJUH0oF9gRynsFF8r5QQk8OHZYxxGRZc
xB8y0oJUrdrfq2TuWKZp5ro9tiZt239hzvBymxjJPdHZZuOWMvOQ6qAlI23sPM57
YAXgX2v1A214dHfOF/kczV7G+QVL+UC/dr/Ko6e4YH+BSZ7u/kiCO6tE9o5X/NRh
9yjsJTlrfvR65qymkuZgVmYBrMy+Alc1Wrwg8H7/fMPTGIS3ROAGc7/ZW5tWFEfm
dPwXDo/CpogmGC2nEvCkqZgd2e4/fyJnEPA3S86Adia/Ks4ASyaU4o7egeZbTj/H
DOSbXEHZgbtks5WjZviCZwMY1FNvoTPBn3GHETrdo4OXKPGs4+jP+DcBJeR0pRSv
aW45jF4gInl7/KmerUs7SqQuRuw+VwuZU2LGfMbXUibnzb+c3RKcbo0YIQBtaNna
HO8xOldYFuk7nsBlWldn
=IO45
-----END PGP SIGNATURE-----
--=-=-=--
