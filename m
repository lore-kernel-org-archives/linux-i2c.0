From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] I2C: mpc: insert DR read in i2c_fixup()
Date: Tue, 3 Jun 2014 09:11:14 +0200
Message-ID: <20140603071114.GA2653@katana>
References: <1400247398-23778-1-git-send-email-valentin.longchamp@keymile.com>
 <20140602162719.GI2654@katana>
 <538D7017.40908@keymile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <538D7017.40908-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Cox <adrian-nKrwMtk+6Wm9FHfhHBbuYA@public.gmane.org>, "Boschung, Rainer" <Rainer.Boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Have you checked other manuals if this always has been the proposed
> > procedure?
>=20
> I have just checked the RMs of the Freescale CPUs I am familiar with, and=
 it is
> the same procedure:
> - MPC8360E (PowerQUICC II Pro family): 15.5.7
> - MPC8548E (PowerQUICC III family): 11.5.6
>=20
> So I think this is the correct procedure for this module according to sev=
eral RMs.

Thanks.

> >> --- a/drivers/i2c/busses/i2c-mpc.c
> >> +++ b/drivers/i2c/busses/i2c-mpc.c
> >> @@ -107,6 +107,7 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_=
id)
> >>  static void mpc_i2c_fixup(struct mpc_i2c *i2c)
> >>  {
> >>  	int k;
> >> +	u8 dr;
> >=20
> > Looks like we can drop this variable since the value read is not used?
>=20
> That's correct it is not used. I have added it to make sure that this is =
not
> "optimized" out but I guess the readb call is enough for this purpose ?

I'd think so, but it needs your test :)


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjXUSAAoJEBQN5MwUoCm28pQP/iuFcPloKtwG5XUc0jMEtk6B
v69o301QCO0Bf9+5KKcuxkjyzLYhYvK585yvlxMD/6s0RD4ZebKX15fT5CVhgMqR
r/ffqhAkYCfCJm8YEywSIh7bFH6+EJcziOeSkwALdW62EP/xRZzDP7zQfuaMMZht
XtbcrR9oj/vPYV9LVtMlT+96TmQeQeRzwj4Od4wz9K+jY69kJIgYcAzDC6UGcRkf
bUcfv7YBqWSvrYW7mkAUnp1VaO6PhdxElgz01A7LiKFHSaBwLZ8wkVREgEyVzpfV
ZX3T2XsIBpZbGKWJF7qjYm0BwFP7QT4UHXZj38da6v0aCudRz7Cghp/hhwUw3iYK
MxY1Fh10+fuB3Hkc7DuTzjHs2Xkt2PhPlHyyS1Ubb7eM6+ez3mGVTptM7TKSzJf9
6mas0iGu0DvNMQCOGAUgESi7cCOwmCx9dqsW2IYulwnmR7mOBBBa1FjrvmuOXswy
+aw/ZnMHPV8bYLsdTrJd0O1Ou9JUX513iqgxXWjb/nBl5JSEmEsOcE0ULVs76uv3
OsmZ4XJree57cHr2/bTHLhZuGcBuzEV+HVZ7bkI93z36gIrB8V6wTy2Qfmacuu5n
7uEH9fRCAdEpge+DTvWqqB6ew+oHTgrwSflMIu9ypZmOpU2Xr8FXjq2/rCYAQ6FL
S1s96FTf2ZdSkKuGOKuJ
=G9f4
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
