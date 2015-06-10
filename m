From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6 0/6] i2c: at91: add support to FIFOs and alternative
 command
Date: Wed, 10 Jun 2015 22:09:48 +0900
Message-ID: <20150610130947.GG1592@katana>
References: <cover.1433866582.git.cyrille.pitchen@atmel.com>
 <20150610125708.GE1592@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150610125708.GE1592@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> After fixing the version string in patch 5 as mentioned there, and added
> the acks from Ludovic for the previous version.
>=20
> Applied to for-next, thanks!

And unrelated to your series, just in case you feel like it, my code checke=
rs
say:

drivers/i2c/busses/i2c-at91.c:213: style: Checking if unsigned variable 'bu=
f_len' is less than zero.
drivers/i2c/busses/i2c-at91.c:254: style: Checking if unsigned variable 'bu=
f_len' is less than zero.
drivers/i2c/busses/i2c-at91.c:293: style: Checking if unsigned variable 'bu=
f_len' is less than zero.


--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeDcbAAoJEBQN5MwUoCm2AJYQAJQ9b4F/nfBCg7SXJQnt0bas
ONgk0EkR4xXuuUhD2FkDFOPrU9xVCu4Kl5srqkJe6vUCFa4xNPOSyV+l9n3DuPq9
CPEW0lU0NY2UoSUtoz91QxozIqAo/eGMen1w4BykXxpImF9DP9KBDh0Oy3H3K4Yi
+FHad3fpBc1zyeWVc45BVE4BdcjiiARTV8sTTmeHT4FSH2aISOXaTDHYXuH3QTh5
Xg5mcA4LkqKhQUyG6faoHf11xuYzsWLZOu99pE46YowWienCQk4Hiw6OB7dlgYWT
64zWiE9AtuU2SgvUjtr8Jv0tHtKJRvKdB1SsiUA5NQOajr7kG2a9THUgPMcmX5Rv
U7DJEwesXHdnOZoNrCWiqXRQTZqQM61NenMLJawb0nCGHE70UxMEjUemnzlQQYzn
T2jUACR2FQ9ESKcFufjqoWdpRY8g2cbQL+IP6ZkmWlgjw6CSu63U5XnStoNScmBq
bQWcwZ+XzUO4J41ubI/I1uti9Qg2Oa/VZkWpaQWKXSSHhPFVCOiVhZDooQx0PSzb
gpoLfFCVO4SjCTFn1TrPUYIumAIV1VQEl8asPmHHan6aYt1x9gC41HU+Q8Cd3dAa
voqgw+OnbF2MS66utcK/ZX9E2kJ/uwXRQMi75sMyzE01ipblqa2MTWBrkJumEL5L
G5sl3bCslXVOweR+pf4G
=TyGE
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--
