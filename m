From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 4/5] i2c: sirfsoc: support reverse direction of address
Date: Wed, 28 Aug 2013 11:41:36 +0200
Message-ID: <20130828094136.GG4086@katana>
References: <1376385091-30597-1-git-send-email-Baohua.Song@csr.com>
 <1376385091-30597-5-git-send-email-Baohua.Song@csr.com>
 <20130819180654.GE8626@katana>
 <CAGsJ_4xoPCJyWZ=_nN6wZBAy2qMER=cKOqY_t8K_jAX8fZWGmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xoPCJyWZ=_nN6wZBAy2qMER=cKOqY_t8K_jAX8fZWGmA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Rongjun Ying <rongjun.ying-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Hmm, you are not advertising I2C_FUNC_PROTOCOL_MANGLING so users should
> > not use it.
>=20
> Wolfram, good comments. the old codes did miss
> I2C_FUNC_PROTOCOL_MANGLING which i will fix in v2.
>=20
> > Does the master allow to implement the rest of mangling,
> > too?
> >
>=20
> i think only I2C_M_REV_DIR_ADDR. i didn't hear I2C_M_NOSTART,
> I2C_M_IGNORE_NAK from hardware guys.

Hmm, since the driver can't support all of MANGLING, it might be wise to
not advertise it. I am undecided how to handle this generally. Until
then, I'll accept this patch (and the series) as is.


--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHcXQAAoJEBQN5MwUoCm2oJIP/jlGweE836miBwUtezMVY8zv
M6//efmUr7ghWv7h35FlkxHAgrTKdcjZzno9DBJo3LmfTNHYRBPql4erD2Jft+9y
0u24Rs9brOmdDeGaNC1zejqgi/TWsHp8YG2kE3LQjyxsdIpuWMdgT15418xDFVM1
n8DcGLE1uGUeAMoUH4Esj/SCrzL4eZL8ByDwLdolbTGU6eyCrqvbnvkgFXYet3YK
4PSCs3k3l5nwtoADKTwa9L8NbCsJtmd9iHhGWomGlfMp71NIy/6lnP5WjkJwC9PD
qJPkIJv9BjoADx+KoxpVl/dRSDPeJnArQ1uUcj+5ofWpuYXZn1oKsFONtOwxUzix
DNKqEk6+e4DL8Zy/wWdZpYq+Yen7nOaR0KMBnZCN4/fbEMk0u2xL991sY/wquzij
4ycy993blXihUWH4aqXbBkCiPAqhlJ9MO0VNtmOcHLlpKUr9/CDRAM5IrXrhVsvm
Y2pJzlxXCZCvh7z1owjNOwQ965qxrYYhaAxOOru/aQpzDoZUGVJ9sof3ymSKQp8D
tsyCN90gZEskXk84vqJrmT3NBDbxIsJm9nQI2HHQOjEsFe8gZOD13ZgG7KNRrSyo
PoReDAKIZVU5aIFBFcQQHdMLrO3xabNz1DyXLzPsY82TIS0V1JOyBMDf+u9g8hgC
goWiKpVjgRvb/cI8771w
=afhi
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--
