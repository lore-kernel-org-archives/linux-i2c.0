From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 4/5] i2c: davinci: use bus recovery infrastructure
Date: Fri, 3 Apr 2015 22:18:46 +0200
Message-ID: <20150403201846.GH2016@katana>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-5-git-send-email-grygorii.strashko@ti.com>
 <20150318203151.GA12072@katana>
 <550C67D6.3080909@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFBW6CQlri5Qm8JQ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550C67D6.3080909-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--nFBW6CQlri5Qm8JQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The I2C specs say in 3.1.16 that the recovery procedure should be used
> > when SDA is stuck low. So, I do wonder if we should apply the recovery
> > after a timeout. Stuck SDA might be one reason for timeout, but there
> > may be others...
>=20
> This is ancient code. And regarding your question -
> Might be it would be reasonable to add call of
> i2c_davinci_wait_bus_not_busy() at the end of i2c_davinci_xfer()?
> This way we will wait for Bus Free before performing recovery.

That might be an improvement, but the generic question still remains:
Is a timeout a reason for recovery? SDA stuck low is one reason for a
timeout. I have problems making up my mind here between being pragmatic
and being in accordance with the specs.

> Of course,  i2c_davinci_wait_bus_not_busy() has to be fixed first
> as proposed by Alexander Sverdlin here:
>  https://patchwork.ozlabs.org/patch/448994/.=20

Okay, good that you said it. So I'll give his patch series priority over
this one.


--nFBW6CQlri5Qm8JQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVHvWmAAoJEBQN5MwUoCm2E9AQAJxNNrXZF8jlfD8QCiNZgzi1
YKuTRXhkWcUaAokU+Am9+DqUL7BTRnRZjNaqMFVVPo6xx6aSN9pvi9XTD3TGQIXW
wHT+AGLSSMWUUVeOsPyHYEVHxienQ5Aen869HSs0jg79YbFJ7+g+MiF4Gn3XG+Qo
Ay6clqsuCU4T8jUMEzWOJJMkGlX1foo0/Iw+7iZJwj1LEF/vWkGriAWR7F2pKMFY
yZY2AS++wXKP5dxEOHRDg3QOzhB/hK7cMwk0fJICa+35sLSVZig7WoZ7KhW8lueJ
KLXEUIegGySyBrzh60u8u2EVFx7gl89Go4jDb4kq5vYtxujw7qNrz2zOYHKBR9sg
q9afej8EYC8Ls1ejMIqoIiqrGgtoK1SkK5VPwcVXG8SpnQYkswrxwJrISKWtGJoZ
mUTcw9bSTDhVyDgMN9BRJH9wass+OG2RzcY+g2xDrT0kdHdjIOTZFRcqMW9TS6tb
lHEYzif8U/VYaDpATLU3jLIVLks1tWSpUAfjtLVh6ONNIgfktxmCTE3FAw1q1pCr
KCzY3iBikCCIw+SnmYffbrujSmAqUOl4LhV2KRmYZNcWe+jl85vHlBYtZ4krORf9
22+AhZI7DfZRQXp85s8tOU995oqAWQqM7e/2g+W5ZkZDSnCB/31GFll0vhDrNhZB
EyfHlrAPaZEZBT2ZZESY
=x/Bq
-----END PGP SIGNATURE-----

--nFBW6CQlri5Qm8JQ--
