From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: fix broken timing calculation
Date: Fri, 16 Aug 2013 18:10:45 +0200
Message-ID: <20130816161045.GC3046@katana>
References: <1373041680-26939-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1373041680-26939-1-git-send-email-LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2013 at 06:28:00PM +0200, Lothar Wa=DFmann wrote:
> The timing calculation is rather bogus and gives extremely wrong
> results for higher frequencies (on an i.MX28). E.g. instead of 400 kHz
> I measured 770 kHz.
>=20
> Implement a calculation that adheres to the I2C spec and gives exact
> results for I2C frequencies from 12.56 kHz to 960 kHz.
>=20
> Also the bus_free and leadin parameters are programmed according to
> the I2C spec for standard and fast mode.
>=20
> This was tested on a Ka-Ro TX28 module with a DS1339, TSC2007, PCA9554
> and SGTL5000 client.
>=20
> Signed-off-by: Lothar Wa=DFmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>

Applied to for-next, thanks! Please mention stuff like the whitespace
fix in the changelog, too.


--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDk8EAAoJEBQN5MwUoCm2Wq4P/Rs1/bog82Ip4iIVo6tGax+n
9z6Ib9y9rPMYXla75/kYd6U0fbMUaLIUr3ZVDM4+7ElGiIgdyZCfu0Eq8UkLnruJ
WJ0jRBkNuYtPEh3PYCXR7uJcAseWGRvcMUl3OkVTw29kjTMhcdiHF3hcoyWoI4q5
91orLLEaI0kDzcvCg32BDvan/nU4uL53pA3JBFbGtsWkqL/HiJ7nT41XbjfV9UIJ
Ry3eIano9j91wHswzZPXCjR7MnJFFZ6QRkzOL5u3KAFiNAfpmcuVwO5leuI7kqtb
CBtIokI0KX3iOdANdCa+nDw/ht2+ktiIj/keDodqAG3zpBh7geqyr2IdSsYg4PY+
vbc8/8+Ol7TrPFvKvDol/CedutODi7zYva1stgxIwr4StYgr6YUWZsYxhvRkKcGd
noGBTYPjzpWiYI12IgLA6WzkHdLQpWQyleEdKzzE/EIsKgt0po+bEyyQFQuKSzdY
Qa173sCoenYS3lyWvmSOEy+vV5AhO7owosyvaJqCbdsJ0UzNdqZEqT5dkCO2MQZV
FTjzIYmm00hjXtTsWn1GVtHyJkQKPMHy7iIFDjk3SdqzU3jsCK4V3UAeepepbwU/
4FfHvstRrWoyAX8HMgyddH8hNcVVcDD88rXwD4DfHPnRPPPHQ7i9qPOus4TJVNzt
V9/pzYGvP41Qr7YOPBTh
=MIgF
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
