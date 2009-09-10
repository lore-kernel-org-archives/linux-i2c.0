From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] Removing deprecated drivers from
	drivers/i2c/chips
Date: Thu, 10 Sep 2009 08:26:09 +0200
Message-ID: <20090910062609.GA26454@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de> <8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8bd0f97a0909091654h290180e5ob79178583aca143f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> the Blackfin defconfigs refer to an input driver for the PCF8574, not
> the I2C client driver

Yup, I am aware of that. With the exception of:

blackfin/configs/PNAV-10_defconfig:773:CONFIG_SENSORS_PCF8574=3Dm

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqonAEACgkQD27XaX1/VRsuggCgvHIQBK0PDoMqr0mqllZhomK8
ym8An2/4gTJoai3W+CzOM659DgzCeQuK
=yoJc
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
