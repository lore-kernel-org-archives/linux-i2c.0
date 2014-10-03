From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] I2C/ACPI: Fix possible ZERO_SIZE_PTR pointer
 dereferencing error.
Date: Fri, 3 Oct 2014 02:55:21 +0200
Message-ID: <20141003005521.GF1323@katana>
References: <1407810818-33672-1-git-send-email-Li.Xiubo@freescale.com>
 <20140819150355.GD15371@katana>
 <20140819151604.GU1660@lahna.fi.intel.com>
 <20140819153808.GE15371@katana>
 <20140819154555.GW1660@lahna.fi.intel.com>
 <53F4638F.5070704@intel.com>
 <20140820101814.GC1660@lahna.fi.intel.com>
 <20140930091949.GI1325@katana>
 <20140930094008.GP1786@lahna.fi.intel.com>
 <20140930103553.GK1325@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140930103553.GK1325@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 12:35:53PM +0200, Wolfram Sang wrote:
> > So the only caller of acpi_i2c_space_handler() is ACPICA and we sure can
> > require it to validate the parameters it passes.
>=20
> Fine, I'd say. Thanks!

What I meant to say by this: Yes, that should really be done in ACPICA
:)

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULfP5AAoJEBQN5MwUoCm22z8P/RbwxacjoJ/hE4N5bYkg86uq
Spiw+GpdKTrxaCN+Rz8Cs5QTRZiUpvzcKISf/xCHhz5+Os7kC3FH9iqe/jyevl5R
H3wHWcedLIM16z4Sg1ucQxjibIcNll8l7KE7V/aHs2GGMNXt6weln6bvAGMGVklt
VrN6jZv2DaZNNY2eQrikXKokheYYS8CmhGFuchAy8apfNfRX8Esz5itqkw2h3MOI
ajpoNdeAl7sQsoxgWUIJ2QN6Cvp4N+DOKyWqomQHXgjteUhD00dKeqKAEYtXocVZ
kWf++cz4CYR9+wUar5a0rUfD5/5C0Nx7pYx0ypQD2b/b3e/JIyMTzObpmedjEl+6
Dw161ZZofvVtvtO+OZtVRvkEzw1cEjgMIruT4kxDf4yLRjNCMakFmmd3RDzLO6x3
Y1+/+x3mACsYWJmTg3dSBRoRwTew1ndokf0yMcP9AkiWH2aK3Zo4BHeVQ4FNLxNc
78/NOk71446j3MYU4uTF+YBCL4FtvtVv3Lvv+rYDKpWvfGIiA6gLvKoGHXBjuPTz
SOwwk8FjmcTg8IdNgauqxInW8H28gRS2Joqm85/tjwRz4chvURcsLNCiJSH7Gbk0
gddvCsdNItTH+lka43PjRZLlyCDG8Y9lNW5hnH2x+nsrSZYpSEwWW5vlfZT3T7aX
k1kOkny+jJiRzAJ09yd+
=rsW6
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
