From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [Patch v2] power/mpc85xx: Add delay after enabling I2C master
Date: Tue, 24 Sep 2013 00:32:01 +0200
Message-ID: <20130923223200.GB3244@katana>
References: <1379369185-14590-1-git-send-email-yorksun@freescale.com>
 <20130923071012.GD3051@katana>
 <5240B626.9050904@freescale.com>
 <20130923220921.GA3244@katana>
 <5240BDDA.3050206@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5240BDDA.3050206-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I see. It is using device tree to match. But the device tree doesn't
> have enough information. Many platforms don't specifiy if compatible
> with mpc85xx, so they fall into .compatible =3D "fsl-i2c".=20

:( Can those be fixed to use proper "fsl,mpc8544-i2c"?

> Please advise.

My PPC knowledge is a bit dusty: What about SVR/PVR to detect the 8544
at runtime?

Regards,

   Wolfram


--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSQMFgAAoJEBQN5MwUoCm2HUgQAJPEacBhyuD3gHMNeuiYTWUH
84tU8Jd0zzw0z4d5DdiHTnlZtus45L2BiFnVLdJtjLXWzN49GhZrRQiTR2AYqJf9
+H1bk3n3Q40vwI6/YLDhSBdqERXj9Nb9sk4xEGKVCoaBKRkbOFtpB1/UV7hWJBRq
4/4jkndg+itvseS42ihy/1EZ0TPN7H0MMfdcPlrAqePSRIah6claQG4/gMuhwsuc
uVNBOgojO07XkOD7y0quLJfkVBSXcizZcz6wl/4KlSaK2EO+q3LLl41tr9mA7y9F
tMmIILvQ9OCRt1tkswIYbJRvxDtNTpYubNzEjSDSLm8f7l5tFgnGXpjBoQ6K+bQf
mVvdjBTNDYXcM0p4C/W8m5U24qvr6NeDNOAMQH+MXf67p2iHSs2TmujqBMrvTqj7
JdvGty0jmIg+9CMjPz0HvgXZXfdYHYUNtW+vmRbu5DQ3P2esgXvwiKo3T/Y5yguo
loHwkiOyYBrJIBS9j8kL25yYdFObb/qZLzbcBx7joY2TOOyghgQYcRncjdxTmJoV
BLh2BHRNGbGKboPCwV7GVdVYAMOGogKYInSK9k8kfSd8fIGCHT9IFs4UdISXKuvi
j100kfYRlPziJPfpc/z++JdkZcxFHYZK2z6cauhexvM3EQhNJn2hb2cSBtlU1dOP
m9FHJaPbLOkbe9nKeP9p
=H2y9
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
