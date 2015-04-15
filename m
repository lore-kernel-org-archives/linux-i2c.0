From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: master build: 2 failures 15 warnings (v4.0-5833-g6c373ca89399)
Date: Wed, 15 Apr 2015 20:01:01 +0100
Message-ID: <20150415190101.GV6023@sirena.org.uk>
References: <E1YiR8T-0003Hq-6F@debutante>
 <20150415180824.GT6023@sirena.org.uk>
 <20150415185953.GB1125@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/VJ4CeYXmhr865LQ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150415185953.GB1125@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, kernel-build-reports-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--/VJ4CeYXmhr865LQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 15, 2015 at 08:59:53PM +0200, Wolfram Sang wrote:
> On Wed, Apr 15, 2015 at 07:08:25PM +0100, Mark Brown wrote:

> > > 	arm64-allmodconfig
> > > ../drivers/i2c/busses/i2c-jz4780.c:181:2: error: implicit declaration of function 'readw' [-Werror=implicit-function-declaration]
> > > ../drivers/i2c/busses/i2c-jz4780.c:187:2: error: implicit declaration of function 'writew' [-Werror=implicit-function-declaration]

> Where do these reports got to? I sadly missed them.

kernel-build-reports-cunTk1MwBs8s++Sfvej+rw@public.gmane.org is probably the best place to
subscribe.

--/VJ4CeYXmhr865LQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVLrVsAAoJECTWi3JdVIfQIRwH/1jMbB6wNMxvM/ySTD3+yjle
+fQ+odLPVndbgZgrcA5ApvpKqRfonugOuXHY+XKRhjjEi6P7VPDKqQM3sSfeSXFj
KEyyjApALXQQCqpm5WI22Q9n8PwitO4QlwhUV0ggpweeQB2AlzPGLIHsWfMGrUKL
rlL2jnW8SaX9XFgiNfDdmVqJYImUu4QTYBB4/guO6MaF7Y1aUSKYLkCYzMATEwFU
tbm5+JDx/TcceFdzM0TWS6Nft0O7d0NtDfYE3dSQnxhtdiY4TTtTv5ES1U6QtgT1
OE7DWRqxu9NCJB2xxXaE5mavIHEaDDLl1yCiI4nBoUXKYJRNKrIiTiGhdRuR2Zs=
=EyYf
-----END PGP SIGNATURE-----

--/VJ4CeYXmhr865LQ--
