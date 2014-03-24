From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: new bus driver for efm32
Date: Mon, 24 Mar 2014 20:08:56 +0100
Message-ID: <20140324190856.GA11532@katana>
References: <1395414236-22647-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140324170131.GB7524@katana>
 <20140324184114.GK23076@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140324184114.GK23076-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > +config I2C_EFM32
> > > +	tristate "EFM32 I2C controller"
> > > +	depends on OF && (ARCH_EFM32 || COMPILE_TEST)
> >=20
> > Is EFM32 DT only? Do we need the dependency on OF?
> yes, efm32 is DT only. Still for the COMPILE_TEST branch the OF is
> needed.

Really? of_* functions should have empty templates if OF is not
selected, I'd think.


--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMILIAAoJEBQN5MwUoCm2zuQP/jKBuBTWQvOs0YUsKA+waaBh
a0bgblGdxmD6w/C+Nfc179zz/Ujt6PEH9gxfFLZcoAYeG023PfeRZ/v0cYBr2AIl
zC+ehPW9r/R06fbJIfMdDUNN1PjY8/JdeKy2haknF+cvythDcP3A9K6QNjIMZFEb
yd3/u3hrK3Mi+GGvT7JZueR0NNVARCFiaScjFOuv9tGT73DU5Zp+Kb4YV3NaoxGV
ZuKxjFAUTev24Q7eNtb6bw2sRL1URyRQEHvB7Ixy31WQpVvLBhRjaPmizrK3XGYJ
xzf3zJNI2dppFJJAGbzyzuHeW2kSlsDZClYtDAT2VSA29Y9i0VlAKZ/H8goGgBz8
pk1c/v2y0KGzzzfDNBfvlPrBvCokoTZL7TGO15tMg+UkYJtUXLwd6lxTLPqjLcXo
4ZA6rPj+NkftTwCdSYLMzz8h/83Ux99ITo01m7kjZAxySqSJJIq+yTaRKZ9R94IM
XiAE3POtiXQS5J9byhxn6NA47aNauSni1igtgEGrKIMvlYHciJ9wQ5pNn3hzlV1J
rCKgyfdIgHj64AkFVEr8d/RlWenSPW3xRnOE3tCK+HlRgHmbw9ej+iTEmVapDuTy
lpES1vZz1wFnJH26W2vWlex63fDerj9nwHecbXKfsFgUIN26dEbHV1h5bbiSx5ww
1TRjm/a4mM3jrjB5Bvm0
=lBJN
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
