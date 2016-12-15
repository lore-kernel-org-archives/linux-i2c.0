From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6 2/5] i2c: Add STM32F4 I2C driver
Date: Thu, 15 Dec 2016 20:42:07 +0100
Message-ID: <20161215194207.GB1741@katana>
References: <1481559342-6106-1-git-send-email-cedric.madianga@gmail.com>
 <1481559342-6106-3-git-send-email-cedric.madianga@gmail.com>
 <20161213092031.d2ax2pnpzzicriel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161213092031.d2ax2pnpzzicriel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: M'boumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	if (ret) {
> > +		dev_err(i2c_dev->dev, "bus not free\n");
> > +		ret =3D -EBUSY;
>=20
> I'm not sure if "bus not free" deserves an error message. Wolfram?

I tend to agree. But I never enforced it up to now, never found the time
to double check if I could/should enforce it.


--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYUvIOAAoJEBQN5MwUoCm2U94P/jlXNnsX4eT1aH2J13k73rEP
nLMb9iHyoo51sJ8Nu8Hhq8ILFp46ROl9z5ZH7EmPrTeWBosu07RBAYxQxo4X/ufB
vsqxM/GKy7Z+wDSxWOzQKlgbgyO4zj6H/s1p+CsPidRvNoZ3D5D2PXWd6h5EvAId
8OGHhbACigdY6wMiv5iZQoZbtgCsxf37hhwz/zJBz4bK2owriAnYcnguTcaIKaeQ
AgwffZv8dkwF4Rubmc0H2MYETGtUP6t+Sr4GTx3mTx1IrRLT3Q2j28XoA8IkbSLD
u1CUYUyA+ukucPRWdN7b6up01djvtS63NWZhke1/QQWApasdjjEy4R52B+fqDE+a
Xg9zI2Xu0nG2NhoYFxxs1/LgVCGnoR2JPntkf6woqGJ0SFocR37SfFPk+My56H5z
VK6+RAX7inRpRGX/XI0/q2Q9NSWS/tm07I15TguehWWdPG8IonCehEK5oLOR8r0/
9iW12I06l3W865R428VkiZXeW23kOd/qlVHTsnodD9zXLfZeeaekH8XwSfZxVzZG
9KQ8a//lXdorTSLwNsJd/9Zg1rbctMnGhUMMkpL1HYDeSMqcOfu64zag3l8EOhIa
RGKrYb7K4rxzG8NaV1HLHw8pu9041rnZMXB88+YppBWUbceLZ4kPmv7esSLa6CHd
TcBA5U1AH8guhVYIkUzl
=aABL
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
