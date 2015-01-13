From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: use {readl|writel}_relaxed instead of
 readl/writel
Date: Tue, 13 Jan 2015 12:52:05 +0100
Message-ID: <20150113115205.GE7660@katana>
References: <1418279201-3886-1-git-send-email-jszhang@marvell.com>
 <20141219104315.0ccbba9c@xhacker>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141219104315.0ccbba9c@xhacker>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2014 at 10:43:15AM +0800, Jisheng Zhang wrote:
> Dear all,
>=20
> Is there any issue I need to resolve so that the patch can be merged?

Adding Mika to the loop. He uses the driver a lot (and knows other
people who do)...


> On Wed, 10 Dec 2014 22:26:41 -0800
> Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org> wrote:
>=20
> > readl/writel is too expensive especially on Cortex A9 w/ outer L2 cache.
> > This introduces i2c read/write errors on Marvell BG2/BG2Q SoCs when the=
re
> > are heavy L2 cache maintenance operations at the same time.
> >=20
> > The driver does not perform DMA, so it's safe to use the relaxed versio=
n.
> > From another side, the relaxed io accessor macros are available on all
> > architectures now, so we can use the relaxed versions instead.
> >=20
> > Signed-off-by: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-designware-core.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-designware-core.c
> > b/drivers/i2c/busses/i2c-designware-core.c index 23628b7..e279948 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.c
> > +++ b/drivers/i2c/busses/i2c-designware-core.c
> > @@ -170,10 +170,10 @@ u32 dw_readl(struct dw_i2c_dev *dev, int offset)
> >  	u32 value;
> > =20
> >  	if (dev->accessor_flags & ACCESS_16BIT)
> > -		value =3D readw(dev->base + offset) |
> > -			(readw(dev->base + offset + 2) << 16);
> > +		value =3D readw_relaxed(dev->base + offset) |
> > +			(readw_relaxed(dev->base + offset + 2) << 16);
> >  	else
> > -		value =3D readl(dev->base + offset);
> > +		value =3D readl_relaxed(dev->base + offset);
> > =20
> >  	if (dev->accessor_flags & ACCESS_SWAP)
> >  		return swab32(value);
> > @@ -187,10 +187,10 @@ void dw_writel(struct dw_i2c_dev *dev, u32 b, int
> > offset) b =3D swab32(b);
> > =20
> >  	if (dev->accessor_flags & ACCESS_16BIT) {
> > -		writew((u16)b, dev->base + offset);
> > -		writew((u16)(b >> 16), dev->base + offset + 2);
> > +		writew_relaxed((u16)b, dev->base + offset);
> > +		writew_relaxed((u16)(b >> 16), dev->base + offset + 2);
> >  	} else {
> > -		writel(b, dev->base + offset);
> > +		writel_relaxed(b, dev->base + offset);
> >  	}
> >  }
> > =20
>=20

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtQblAAoJEBQN5MwUoCm2L9oQAKjk2uGq6kH5QKyveBeq+Lsh
GXPoKimISTJmsbip+Y8IDWFa3try5o9VTSU5qFRJM0iLPvJoAdi2WnYuEKQNQgPU
2OSAKRjdXjdoyp7lx6piblqgFFcfhamUYoQ5vd4tlcJ5WbqHS7/UsOWtfmH4s7SD
vaPVrD3usWAOjRZsxhJ4c4zK6AzJJgAiMBBSy4YI7iAUYp6WKLEObTBya4VM3eju
qXfwro3Zc2O1Y7paUNptQi+/H75zrbEgR+mtmtDuDy5xHB8dYN07Je8QjmgytCls
HHDQEnQuBUb8fqE+OZvJHmK2hPQXW/x8Cq4Nv34n0DN0DlRokkG9kaLk8sVqv+88
FQ6aLrHc6QoKWQlU2HZEfLOXKvwoRsT2QmTXTkKRaL1Ft7Z++CZ0ab6X9MzKf8oi
pFrBGPDR8g0nL3TsRZG64VMvSlEKJFBUpQ2X6CV1pjCfi2DojwrSaBq0ydbT3LCx
Uqij2ZNrqsQeq1hwfYWGsUE2WESibiJLYXenmJA9zAMq+As4UETMwc15JgT15PxF
Lezp5BkpEhW3jzEHc62tnrXfNAVt7aDPLI4+ZPN9/7Qh+rRfJAosQ41e3tio5OcH
d6JBd3KBzRi4MZ2Ro+jKAmYeI9+2Glea8y0PYMEQ+BHhsXEHhimKVYewDghzrYPm
o+lhU/izIQe4n+hOnNnN
=mtX6
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
