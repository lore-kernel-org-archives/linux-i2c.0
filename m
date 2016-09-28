From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 2/7] i2c: bcm2835: Protect against unexpected TXW/RXR interrupts
Date: Wed, 28 Sep 2016 15:00:05 -0700
Message-ID: <87oa37fzx6.fsf@eliezer.anholt.net>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org> <1475085056-5205-3-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:57473 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754001AbcI1WAM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Sep 2016 18:00:12 -0400
In-Reply-To: <1475085056-5205-3-git-send-email-noralf@tronnes.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, swarren@wwwdotorg.org
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Noralf Tr=C3=B8nnes <noralf@tronnes.org> writes:

> If an unexpected TXW or RXR interrupt occurs (msg_buf_remaining =3D=3D 0),
> the driver has no way to fill/drain the FIFO to stop the interrupts.
> In this case the controller has to be disabled and the transfer
> completed to avoid hang.
>
> (CLKT | ERR) and DONE interrupts are completed in their own paths, and
> the controller is disabled in the transfer function after completion.
> Unite the code paths and do disabling inside the interrupt routine.
>
> Clear interrupt status bits in the united completion path instead of
> trying to do it on every interrupt which isn't necessary.
> Only CLKT, ERR and DONE can be cleared that way.
>
> Add the status value to the error value in case of TXW/RXR errors to
> distinguish them from the other S_LEN error.

I was surprised that not writing the TXW/RXR bits on handling their
interrupts was OK, given that we were doing so before, but it's a level
interrupt and those bits are basically ignored on write.

This patch and 3, 4, and 6 are:

Reviewed-by: Eric Anholt <eric@anholt.net>

Patch 5 is:

Acked-by: Eric Anholt <eric@anholt.net>

Note for future debug: The I2C_C_CLEAR on errors will take some time to
resolve -- if you were in non-idle state and I2C_C_READ, it sets an
abort_rx flag and runs through the state machine to send a NACK and a
STOP, I think.  Since we're setting CLEAR without I2CEN, that NACK will
be hanging around queued up for next time we start the engine.

Patch 7 I had questions about but probably will send an ack when you
reply.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX7D1lAAoJELXWKTbR/J7o9jUQAKIrO2s27CtGt1bs66TsjDtw
Z6PLUCogwtYcojHiRS1mTg3Jzmn+E2BS3emV+Xqh0ratXjaA+GqQlgGyiRtBBeES
A7NlMEL/vqBDiKLmdSos7SC2q3/n4m8Mh9h+jJ8ZUoIQJ25En8eraS4fzyRMRJ39
DJv7V9DQb8AhtbZw4/+TiMl3pkA50g05jmJtLQN27v+SBEuKimouONOtIULI/Yew
5Xz6Tdj8yP3ZJ/71avSixr6chA12yBCQdtNuDWbfggFsx66DMPhuU++KP6YOVC0/
FymU7I1K68Y/BvFFBLOaJbRyknDtJnv5u5l5c/GdWgT6EmyoS5qUU33CcICeLnHX
cygNQvekNZndSngjv/Ew3nmrm9hrfpNh4692z4dc/cg1JA+v/qtePNctTc0Vej/C
l+KHHEvZp2seMqgDws2TzgKkhcfU2cMLYeGNRwrS0rnzUPR1lCRG0EfFfPueNrn3
G+iJm8aP5ZU0wBdY5eJswHhqbMi80csavqd/cNYl1ibfMPREG+ZLOpv+IN5TehUQ
3IXCZDa4HNQMBGF+WSz1WW0CLGDGomRvU6AIyeJbso31PqdIqWtmshcvRcmWBfI2
uIdDiQbsqOWUcqv5zu7Jnok82L0KK6dJmZxzzK82HccLWMQlveXhGJd2UOhzdfUV
b2CUkRKRrMD1ghdmumrs
=Qtg7
-----END PGP SIGNATURE-----
--=-=-=--
