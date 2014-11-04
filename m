From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: create proper topology in sysfs
Date: Tue, 4 Nov 2014 15:33:09 +0100
Message-ID: <20141104143309.GA12933@katana>
References: <1414960809-16860-1-git-send-email-wsa@the-dreams.de>
 <20141103205534.GA18937@roeck-us.net>
 <20141103210200.GA6242@katana>
 <20141103224908.GA18594@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141103224908.GA18594-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Ok, I think I know the problem. In my case, the parent adapter
> and the mux device are the same (since both are on the same chip
> and the mux is really merged into the i2c controller).
>=20
> I'll have to figure out how to fix that.

Maybe something like this on top helps already? It skips link creation
if the parent device is the parent i2c adapter. We should have this
anyway...

--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -184,8 +184,11 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_ada=
pter *parent,
 		return NULL;
 	}
=20
-	WARN(sysfs_create_link(&parent->dev.kobj, &priv->adap.dev.kobj, priv->ada=
p.dev.kobj.name),
-				"can't create compatibility link for old mux name scheme\n");
+	/* If necessary, create symlink to match old mux name scheme */
+	if (mux_dev !=3D &parent->dev)
+		WARN(sysfs_create_link(&parent->dev.kobj, &priv->adap.dev.kobj,
+					dev_name(&priv->adap.dev)),
+					"can't create compatibility link for old mux name scheme\n");
=20
 	dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
 		 i2c_adapter_id(&priv->adap));
@@ -198,7 +201,8 @@ void i2c_del_mux_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_mux_priv *priv =3D adap->algo_data;
=20
-	sysfs_remove_link(&priv->parent->dev.kobj, adap->dev.kobj.name);
+	if (priv->adap.dev.parent !=3D &priv->parent->dev)
+		sysfs_remove_link(&priv->parent->dev.kobj, dev_name(&adap->dev));
 	i2c_del_adapter(adap);
 	kfree(priv);
 }


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUWOOkAAoJEBQN5MwUoCm2NWIP/RnqPUtxbrTF0/34tBy6ay4p
whiApOP1Y+JZsQwiNa+0tkxCQV+wkDU7kD8eYrQ3Qc3gFvIT5ijKBrXvmjM70cqJ
uokYKnIwmaxEA+M8wroynlmje3MB3OYiz6fDjIOE7ctPP3ago4V1VfF8abNEPNma
OBBgkSXIjW8xFiaDiWF6YuMfi3c+qDIOl20uL+bXth7hPLA7mfT3EpceSgzNtHtF
XD2ivNPflEW4HPD9jqoYmB9QrHb0EDG3a9rliDC978AKE7g+jIED9MzQ1Spnm8EC
wdCSi4KmOPVU2FcLu7SjAjY6mH/NbPW6n3jgPKZcrAaZMdWLCGos8b8DbOcEwtSA
PY+vta1D0JEk/awFEJquiPFSEG/I65las1ZuwPs3H9ofBOilYUX5RXA4wJ57TR8U
x+mPAEiv0Jxz2P01qqrTb+dbaaxUYpu3BN/BmzVHtAMUZfyteC9IVUTitp87iogS
L3IgKYWc/c7eXRFPgDZbdxOHn0Zd2K7WB0eUeEZb8SbBiguZesBzTeroAME4VSpQ
7LjratY+dULWE7g9x1vT0qQZA3HwZwl3TFFSqZ9wB4gBUSBxeVAKKFYewXsujoB1
dSRCPixIDlhYd3KKXoq8R2WoQVnyC8E1dzcogmWOqgETBv2DfVFZUMu/3nQn9Qud
kl+D03w02fFkUaL07C/c
=W+FH
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
