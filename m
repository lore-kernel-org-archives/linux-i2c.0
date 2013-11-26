From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH -next] i2c: bcm-kona: remove duplicated include from
 i2c-bcm-kona.c
Date: Tue, 26 Nov 2013 13:48:03 +0100
Message-ID: <20131126124803.GE7427@katana>
References: <CAPgLHd_Qe5m940n=-233S0-d7e9dmbz1mc0owL18jZR7g6cP2g@mail.gmail.com>
 <CAPdLdqn3dHtwOGGmkQZcch+=JCw3=23H4JKT=Zh-KBKrqDB+hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPdLdqn3dHtwOGGmkQZcch+=JCw3=23H4JKT=Zh-KBKrqDB+hg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Mayer <markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c=
-bcm-kona.c
> > index 865e5dd..1d74da5 100644
> > --- a/drivers/i2c/busses/i2c-bcm-kona.c
> > +++ b/drivers/i2c/busses/i2c-bcm-kona.c
> > @@ -20,7 +20,6 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/clk.h>
> >  #include <linux/io.h>
> > -#include <linux/clk.h>
> >  #include <linux/slab.h>
> >
> >  /* Hardware register offsets and field defintions */
> >
>=20
> Reviewed-by: Markus Mayer <markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

IMO such trivial patches are rather acks than reviews. Mileages do vary,
I know.


--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSlJiDAAoJEBQN5MwUoCm2o6gP/i1chjQEkiXYBRNeeM7vUKNp
NAqyrA6SFXXA5evaCStvr6VCjBu29FLyh5h1QRXWKz6Gnt/VK5015+aXWP5m6A2O
FUmiyQC9IgGukTKmiMWx2GgXhexP+icQGHBcLMHXXuA+Eg79MJdeD9eT86iXGFdz
LWuJEdQGPXsaMYKCp4UV0pEjplgbvY9PyOCAt7L0bIclo37Emb/i4s1HLvfH4xU8
4okXSlhO5CcZ8yjkxMyIhYXncSKKQfQQBOUwietlvWf/OcTgwOfg4GpsaxZwIrM2
IsUEZkkdsB5083kXxwuAtnR7ipjhykg4OKrqkkqFu983EpotlMQ3xERT9JdstgSr
w1UbycmANsIAeKea60lISbsDKkAdA6k4xnN5aIzvtI4PlG1IRUWLrmc8YVb7J7Ds
6x+Q/OPWNhVKvhBiIxXtpGXbYwu4tUIeBlrvKKxv8L1inf1GB1xkS8m1OtUZv3um
OOTBCJelmR3it8DJpleTrMOP7nHlkUZC+PrjNp/qMA77yka4ca9P/gjWkqKT1BI4
3foUUwGcxpLh0NA4/e2soFMFn5k9YxDUefx0XJvFI1ToWZzRlolmZiLfBhf+Lfbp
CL5ogPtwkAq/+hNir1iZrC3mg/iivJ5Cl73oAZZozPZhxaFUF7hrqWxCoMUa/BZx
uMtB6ZkHgdBff0+15Wdi
=pce2
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--
