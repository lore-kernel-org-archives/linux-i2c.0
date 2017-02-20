From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RFC 1/3] i2c: bcm2835: Avoid possible NULL ptr dereference
Date: Mon, 20 Feb 2017 19:22:15 +0100
Message-ID: <20170220182214.izi46a7lbzck7q4r@ninjato>
References: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com>
 <1487280047-29608-2-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s6nbjhsjjtgw43x4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44782 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751935AbdBTSWR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 20 Feb 2017 13:22:17 -0500
Content-Disposition: inline
In-Reply-To: <1487280047-29608-2-git-send-email-stefan.wahren@i2se.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>, Peter Robinson <pbrobinson@gmail.com>, Martin Sperl <kernel@martin.sperl.org>, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org


--s6nbjhsjjtgw43x4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 09:20:45PM +0000, Stefan Wahren wrote:
> Since commit e2474541032d ("bcm2835: Fix hang for writing messages
> larger than 16 bytes") the interrupt handler is prone to a possible
> NULL pointer dereference. This could happen if an interrupt fires
> before curr_msg is set by bcm2835_i2c_xfer_msg() and randomly occurs
> on the RPi 3. Even this is an unexpected behavior the driver must
> handle that with an error instead of a crash.
>=20
> CC: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> CC: Martin Sperl <kernel@martin.sperl.org>
> Reported-by: Peter Robinson <pbrobinson@gmail.com>
> Fixes: e2474541032d ("bcm2835: Fix hang for writing messages larger than =
16 bytes")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied to for-next, thanks (will be in 4.11)!

Note for patches 2+3: I usually don't take DTS changes via I2C, so this
likely needs to go via arm-soc or some other bcm tree.


--s6nbjhsjjtgw43x4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlirM9YACgkQFA3kzBSg
KbZDvA/9H3SLoBMp4dbfr6Qk7SI6WGdFdsHe+dh6zv7lb9tQ0vLTB4DTaU+5Ijpd
gSYudVPZJe60RLS4rYRLB8HW1H9Cq4H9XwIlUuLnOHhMcpQmkW37BW1QsRpvoTIc
TJKTA+XzEsCWTKAda+jXA5WUOENmNbzKx51a9nCe+lStUtqoDGdEDiW7gRiM4kC8
3PYlqywfgDNeGHrDsyITL2GdjFIDE3y/B6rrdXTYQxotqVSE6D9PNnQAHBeL7QVO
LOrrMoaBfI6p9cILKGiIVekpL2e8CBK5XL/f8365GApT/1tsrVRsKnmGFnRZOpbd
xDsvDc9QNmehRf1zgc+BVXfYo83hlU5wQcKorI4l15KtPBvS89XFCZQhf+/H3Nfd
36SmWVb6UihfJ9YCzZMQQZbzmNoi+GnaEzldkVALgAGBAHQtet30UVVwTie7QZHz
9oPsJ+LShxeMSVMcXlK0G4zUdusqZkdYvFJAJ+M74HFxygto+X8uEju20uBus+TL
qu9fVlpYRoiduoKZ62zzCQrvgT2MMI9bZg2XGNoIwlKbqLVm+96gJQnH6Op4BDqZ
KONXj+ARMuFPn1VKpwB4Sc+CfYBkNe6IGKxv+PS+nPEyhBQDk4P/dvjWWLbNKoYI
V7XlQ614onjJkTKeXs0RWXfijbXJNrzsHBFRr8DE6BxJ7Ek4YMM=
=WcBm
-----END PGP SIGNATURE-----

--s6nbjhsjjtgw43x4--
