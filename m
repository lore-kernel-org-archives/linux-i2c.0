From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: i2c imx: suspicious use of runtime PM calls
Date: Mon, 24 Aug 2015 14:09:30 +0200
Message-ID: <20150824120930.GB3608@katana>
References: <55D8ECBA.6050505@gmail.com>
 <CY1PR0301MB0858E9E871CC1D399F45B1B3CF620@CY1PR0301MB0858.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CY1PR0301MB0858E9E871CC1D399F45B1B3CF620-YrwGdl+PljlUWoKpOwApjpwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Just by chance I stumbled across this driver and the recently added
> > runtime PM code.
> > Two things in i2c_imx_probe look suspicious to me:
> >=20
> > - You activate the I2C clock and then initialize runtime PM with
> >=20
> >     pm_runtime_enable(&pdev->dev);
> >     pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_TIMEOUT);
> >     pm_runtime_use_autosuspend(&pdev->dev);
> >=20
> >   Seems like a call to pm_runtime_set_active is missing to tell runtime
> > PM that the device is in status "active" now.
> =20
> Thanks, you are right. I will fix it in next patch.

Thanks Heiner for the report. I dropped this patch and will wait for a
new version.


--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV2wl5AAoJEBQN5MwUoCm2bfQP/30JRnXwU41D16+kbdha0FPw
5l8/1Iq+AkU6T6KfJK1AMcqLDj7cyDR2+y72QoJq4Qn+ib0uhdGfzpI0GJdC49qz
FesJ9nDPe8phZR7q2XcC3931QH2Yra9GT08169kEM/MAcKIRNvXnndgGh7oZBr7f
+bBOzftXiUYj6NH61ZI8s67AJdjVs8qmrIc0U6xP6dd2p1PhynG5Q70wzKZXRGvS
3bDD5gsIF+nwruuNe17otKzHYAP/b6MfvLZEIhNnsBU6258oqb7QV5sDUWuDrI1r
0ku+/xkx9h7dINjP4+GAZRXMIt7LgCq0eRdNQ9VMAI7ZZMOfk8jMh6YP9tgcJupk
27aGDN/hw4zRVOZoinjJeEmGpp8NEucY4av/Ml93/fyYqYmJYn/zy6AyLns4J+bs
9Wt0Ex9CyWTapu1zdbtLX4C4HqELJmwXcxuYTWwIcr2BejpbZsBsv0oPuVs4jFp8
o8o2x1Oq2h4yT4zr8WEbHXS1S07tk2Zs/RDlnDVZMVzW5M52Q4WnSbpXDhJ878zU
T9fUzQN9nMuwovCszuZgd1BGpmAw9RcI0kTbVARVv5f/9ZZZlTsO6aA5bkiTAa4E
64JzmWbNYUhw69QSSf/KU9qHUsEGgwlFjDDQxhyuwg5ixls1Q2uUWyLdO6waC6qI
a9cVn2tPsh0lNYfODhsk
=edKR
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
