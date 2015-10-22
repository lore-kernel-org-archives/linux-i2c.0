From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] i2c: at91: manage unexpected RXRDY flag when
 starting a transfer
Date: Thu, 22 Oct 2015 15:08:47 +0200
Message-ID: <20151022130847.GE1517@katana>
References: <1445435048-25889-1-git-send-email-ludovic.desroches@atmel.com>
 <1445435048-25889-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58516 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbbJVNIy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 22 Oct 2015 09:08:54 -0400
Content-Disposition: inline
In-Reply-To: <1445435048-25889-2-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, peda@lysator.liu.se, cyrille.pitchen@atmel.com


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2015 at 03:44:04PM +0200, Ludovic Desroches wrote:
> In some cases, we could start a new i2c transfer with the RXRDY flag
> set. It is not a clean state and it leads to print annoying error
> messages even if there no real issue. The cause is only having garbage
> data in the Receive Holding Register because of a weird behavior of the
> RXRDY flag.
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Fixes: 93563a6a71bb ("i2c: at91: fix a race condition when using the DMA
> controller")
> Reported-by: Peter Rosin <peda@lysator.liu.se>
> Tested-by: Peter Rosin <peda@lysator.liu.se>
> Cc: stable@vger.kernel.org #4.1

    SMATCH
drivers/i2c/busses/i2c-at91.c:602 at91_do_twi_transfer warn: unused return:=
 sr =3D at91_twi_read()

drivers/i2c/busses/i2c-at91.c: In function 'at91_do_twi_transfer':
drivers/i2c/busses/i2c-at91.c:550:11: warning: variable 'sr' set but not us=
ed [-Wunused-but-set-variable]
  unsigned sr;
           ^

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKN/fAAoJEBQN5MwUoCm2qcsP/3xR/eLcoYMI49N8BReGCV4a
FMUXvwHz2nTlwNE24628gjVLPj7Mwj5Vou0qobN2voCdsB+q3FU2OuArznmKnAxG
Bb2b+H1bsPUrIgXa/wGGgBojm6tEovkkyl7KecFXZXMPGf5RDQQ2OzN25C3PK4JL
jX9aS3+KbjWNh3hB3ba6U8QVAWbuPN2T+xHZ4pnmmOOMdwdYwEYG9KpbiPARSzcF
UXT3hY8/1hzorjI64MrcfExxN1bOi+uFCmnsZG8KUB85UXGwdBRLIlig8aFtT9Gn
EfpOGp6qNqCVSJe6E79PHr5ArCJq94Sr3ydc1piuBE26u9qqx7MD8Ve+INVonUvW
RB4zefNwmCbtxU8W/1OSdVGrraJwCc/m63lcTtatMhRExxSQdzSPXdHot/zVWCA1
bePyn+hFbP5qx1CgJlrTCVuNtHRqt5LHYRff5NinHmittnPiMLKApNndiuRKbrie
v8LQA4ANv5YapGeOMSfNl8INVC0oGd2yqovvCCDh0F+s9YlBuOjZQJf1mU2o13Q4
tVZG5Wce0g0yTkIF5ULLs8cYke5CB8YbJLVrAQOtPWMEIuk5GkwUjj9UDDejBsPm
t/PijqxvFVxCM26ycpEz/3PwC3kldvDZOHQs3SglQcLtSuvIHuV8/ukMv1l9F/HP
KUHZHhprGqHWPeqXW7CX
=OYhx
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--
