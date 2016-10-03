From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 2/7] i2c: bcm2835: Protect against unexpected TXW/RXR interrupts
Date: Mon, 03 Oct 2016 12:42:29 -0700
Message-ID: <8760p9xlqy.fsf@eliezer.anholt.net>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org> <1475085056-5205-3-git-send-email-noralf@tronnes.org> <87oa37fzx6.fsf@eliezer.anholt.net> <d93a0590-1783-b913-9362-007628cb17d6@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:38286 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751824AbcJCTmd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 3 Oct 2016 15:42:33 -0400
In-Reply-To: <d93a0590-1783-b913-9362-007628cb17d6@tronnes.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, wsa@the-dreams.de, swarren@wwwdotorg.org
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Noralf Tr=C3=B8nnes <noralf@tronnes.org> writes:

> Den 29.09.2016 00:00, skrev Eric Anholt:
>> Noralf Tr=C3=B8nnes <noralf@tronnes.org> writes:
>>
>>> If an unexpected TXW or RXR interrupt occurs (msg_buf_remaining =3D=3D =
0),
>>> the driver has no way to fill/drain the FIFO to stop the interrupts.
>>> In this case the controller has to be disabled and the transfer
>>> completed to avoid hang.
>>>
>>> (CLKT | ERR) and DONE interrupts are completed in their own paths, and
>>> the controller is disabled in the transfer function after completion.
>>> Unite the code paths and do disabling inside the interrupt routine.
>>>
>>> Clear interrupt status bits in the united completion path instead of
>>> trying to do it on every interrupt which isn't necessary.
>>> Only CLKT, ERR and DONE can be cleared that way.
>>>
>>> Add the status value to the error value in case of TXW/RXR errors to
>>> distinguish them from the other S_LEN error.
>> I was surprised that not writing the TXW/RXR bits on handling their
>> interrupts was OK, given that we were doing so before, but it's a level
>> interrupt and those bits are basically ignored on write.
>>
>> This patch and 3, 4, and 6 are:
>>
>> Reviewed-by: Eric Anholt <eric@anholt.net>
>>
>> Patch 5 is:
>>
>> Acked-by: Eric Anholt <eric@anholt.net>
>>
>> Note for future debug: The I2C_C_CLEAR on errors will take some time to
>> resolve -- if you were in non-idle state and I2C_C_READ, it sets an
>> abort_rx flag and runs through the state machine to send a NACK and a
>> STOP, I think.  Since we're setting CLEAR without I2CEN, that NACK will
>> be hanging around queued up for next time we start the engine.
>
> Maybe you're able to explain the issues I had with reset:
> https://github.com/raspberrypi/linux/issues/1653

One of the questions I think you might have is "what state does the
controller end up in after the various interrupts?"

ERR:
=2D produced if we get a nack that's not at the end of a read.

=2D Proceeds to repeated start if BCM2835_I2C_C_ST is queued, otherwise
  stop.

CLKT:
=2D Triggered by a counter outside of the state machine when stretching
  happens and then times out.

=2D Sets cs_override, which causes proceeding through the state machine as
  if the clock wasn't getting stretched, until the end of the next byte
  sent/received.

=2D According to Wolfram we shouldn't be timing out on clock stretching
  for i2c, just on the transfer as a whole
  (https://patchwork.kernel.org/patch/9148431/), so I wrote
  https://github.com/anholt/linux/commit/894200276239d2e4c60b378bdc52164fcb=
13af8d.
  However, I don't see an obvious way to get back to IDLE while the
  slave is still stretching, without triggering the clock stretching
  timeout path.

DONE:
=2D Signaled at STOP, and just moves to IDLE state which keeps scl/sda
  high and waits for a BCM2835_I2C_C_ST while we're not clearing the
  FIFOs (if you do signal start while the fifos are clearing, the start
  will hang around until the fifo clear is done).  This is the only way
  to get to IDLE.

I'm don't think I have an answer to the "what should I do?" question you
had, but hopefully this helps.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX8rSlAAoJELXWKTbR/J7o/HcP/1PyEP33RlKvIjgm2CxCQXYv
yKB1snh0YBID8sWkrkdOOJ289RkAbdimCLcEoYhD1x0sj6zipriFnqP/OvZje1tL
3HRAg8RrSJhEBRKCY7A/a0CcHySVLaSyFwn/Umxu6FjNIs6zahy7/RqWGVqGADOb
0HW5ZpiomD1sQYQeSrgkOdGoTk/51YZ1zAe82eVuSENWTmETnC/X0KOt9gKaPKia
YNKfsLEU7FgBZy45jUqSiqnM+ahMpCBvTF6UwGgCYW+6R/zf4iTBgqzMgUQlLtb6
Wy5Ty7ReWJg4HvpHDtdex8o2HGFCW4UKKTU0Seukw4yeo+K9c6J3HSGA9X53PuEz
o7qritr0l13wsbO1B8GWIth45ZnxZrhAw3B3FoTQbMLSwPS2osJVleh4MYPTnHqY
Pj/aB0vtGaO5kYsO0u1rziDQklN7eB3hXQMDD0TVDte6D1I1fh6lJkp+fU3PhpVN
VR/SYK2ieSh6ERSh7nZh/UqfjXTyadRtvrvr2bVahjhyBZVeGczTqxC1XcfWxVmp
wzbWBJAgrF+4QADesQvFszsQzvo3AXXdlYwfMlDEB6B7TEv9fifanQC8FI2jlJ0X
JyL3Bi3eG5PL4xMiAYPHgQq34vDuaHL8h+/Am/YDuZlQZXBbhLvcO8BCzxwJJCfd
m1LdeUyc7vyGKs1dE4w2
=Ou7f
-----END PGP SIGNATURE-----
--=-=-=--
