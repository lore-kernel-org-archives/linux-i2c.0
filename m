From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: master build: 2 failures 15 warnings (v4.0-5833-g6c373ca89399)
Date: Wed, 15 Apr 2015 20:59:53 +0200
Message-ID: <20150415185953.GB1125@katana>
References: <E1YiR8T-0003Hq-6F@debutante>
 <20150415180824.GT6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150415180824.GT6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, kernel-build-reports-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2015 at 07:08:25PM +0100, Mark Brown wrote:
> On Wed, Apr 15, 2015 at 06:30:01PM +0100, Build bot for Mark Brown wrote:
>=20
> For the past couple of days -next has been failing to build on both arm
> and arm64 with:
>=20
> > 	arm64-allmodconfig
> > ../drivers/i2c/busses/i2c-jz4780.c:181:2: error: implicit declaration o=
f function 'readw' [-Werror=3Dimplicit-function-declaration]
> > ../drivers/i2c/busses/i2c-jz4780.c:187:2: error: implicit declaration o=
f function 'writew' [-Werror=3Dimplicit-function-declaration]

Where do these reports got to? I sadly missed them.



--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLrUpAAoJEBQN5MwUoCm2fYUP/ilQON3SiAEPQCQ78SaFZ5CS
nDLvNTjIqvsncqkWdx8py/OboEtRiFYnTnYXHQgSx1jZWWRmnmD2FwkC2H1Nb+rA
NOOF8yXJ2VKTM2yeaLBplhezNXlbDKtQT7mTQYO1uYD3HKEaotxcTioo7op+pSwF
nZiY5AY6D+S7HB3bpwh9mVEmcRl1S7E/Yv43OGMXqsrOsVaiWzMtDFVSl4u/XxjM
KUP/+fUlbZhgBNcGl0/ACo/68cbUa1Ffo7kUvkM+qcRtmKY79DiYMkwuNLRapYyM
7GSM5HSirhMaT1y5c1oYwpvf+MrP79QnzusUs6isrG88eU72lncfrdkeghBmsXyo
yxiwOBihjpKHtm5sb7yKOUuNVVMRciHd+30cf+wLlXIYB4VXP+ug8EGXPfbaSPYb
SrNPV6AO/aJLgK2yFT9elJlD35vjzxD0aZK4+K2FS0egn/fg98cV2D1J8Djb++at
oXpmOlDpEQX7bTVhgpQnVlzXIE2COEH/ROr6ryFsNSrBi31KyHlQMny3uq1ChmzI
UMa9oCnVqcwIsPjZnPBLqPg+VGjte9nx9CQpIdv1tJ9CNig5Gzb7GIPhREcO/nUv
5O++6Ht6ncTr/5DAFa8ciS2TI3ZVlJEB2UP8EVjEJwapBRdP78En3A0jk2sUD/xc
nGEiq/GAMtNZJHBJglQ+
=U1mp
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
