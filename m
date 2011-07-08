From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] power: Remove obsolete cleanup for clientdata
Date: Fri, 8 Jul 2011 11:15:56 +0200
Message-ID: <20110708091556.GE2048@pengutronix.de>
References: <1308603674-19264-1-git-send-email-w.sang@pengutronix.de>
 <1308603674-19264-3-git-send-email-w.sang@pengutronix.de>
 <20110621105456.05839025@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110621105456.05839025-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 21, 2011 at 10:54:56AM +0200, Jean Delvare wrote:
> On Mon, 20 Jun 2011 23:01:14 +0200, Wolfram Sang wrote:
> > A few new i2c-drivers came into the kernel which clear the clientdata-p=
ointer
> > on exit or error. This is obsolete meanwhile, the core will do it.
> >=20
> > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Cc: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>=20
> Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Anton, can you pick it for 3.1?

>=20
> > ---
> >=20
> > This is more a cleanup than a bugfix. Still, would be happy to have this
> > obsolete programming style largely removed in 3.0 if possible.
> >=20
> >  drivers/power/max17042_battery.c |    2 --
> >  1 files changed, 0 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_=
battery.c
> > index c5c8805..09f7496 100644
> > --- a/drivers/power/max17042_battery.c
> > +++ b/drivers/power/max17042_battery.c
> > @@ -183,7 +183,6 @@ static int __devinit max17042_probe(struct i2c_clie=
nt *client,
> >  	ret =3D power_supply_register(&client->dev, &chip->battery);
> >  	if (ret) {
> >  		dev_err(&client->dev, "failed: power supply register\n");
> > -		i2c_set_clientdata(client, NULL);
> >  		kfree(chip);
> >  		return ret;
> >  	}
> > @@ -202,7 +201,6 @@ static int __devexit max17042_remove(struct i2c_cli=
ent *client)
> >  	struct max17042_chip *chip =3D i2c_get_clientdata(client);
> > =20
> >  	power_supply_unregister(&chip->battery);
> > -	i2c_set_clientdata(client, NULL);
> >  	kfree(chip);
> >  	return 0;
> >  }
>=20
>=20
> --=20
> Jean Delvare
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4WyswACgkQD27XaX1/VRvWcQCeJntita/8HAm/Uw3pzgsLAz5i
5QoAoMuEUm9Gn6Qz4i6Gfo9fka/a6HQt
=LFtg
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
