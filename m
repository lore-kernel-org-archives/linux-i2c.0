From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Accessing EEPROM from Linux driver
Date: Tue, 24 Jan 2012 11:06:36 +0100
Message-ID: <20120124100636.GB2609@pengutronix.de>
References: <CAGm1_ku3N0ksJ4USt9Rae=Yo3xcTFX=dLVh6=YMkFjUaLABu-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGm1_ku3N0ksJ4USt9Rae=Yo3xcTFX=dLVh6=YMkFjUaLABu-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> sysfs from userland. What were the appropriate method of accessing
> EEPROM from a network driver? AFAIK no functions were exported from
> eeprom.c.

Please state always which version you are using. There is code exactly
for your use case in the driver since ~2.6.30 (and clearly described as
such).

437 /*
438  * This lets other kernel code access the eeprom data. For example, it
439  * might hold a board's Ethernet address, or board-specific calibration
440  * data generated on the manufacturing floor.
441  */

Regards,

    Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8egqwACgkQD27XaX1/VRtDhwCbBRcvU5X/cT6bl4Ik1zMqy+Zw
LVQAoLpZ0L3a0+hvZjsNeIq9e6LAJfjP
=IJLu
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
