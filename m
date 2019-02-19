From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Tue, 19 Feb 2019 14:27:04 +0100
Message-ID: <20190219132704.pmtai25fltxkwso6@ninjato>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
 <20190205131641.GF12401@kunai>
 <1550109268.30065.13.camel@mhfsdcap03>
 <20190215090257.geumssb2cucs7rzt@ninjato>
 <1550316723.30065.44.camel@mhfsdcap03>
 <20190216122915.hchghozcn7ntdkbm@ninjato>
 <1550582023.30065.52.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k2kejit4druie2cz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550582023.30065.52.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: Qii Wang <qii.wang@mediatek.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, ryder.lee@mediatek.com, xinping.qian@mediatek.com, liguo.zhang@mediatek.com, Rob Herring <robh@kernel.org>
List-Id: linux-i2c@vger.kernel.org


--k2kejit4druie2cz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Maybe you think that MT8183 SoC only has the I3C controllers. Actuall=
y,
> > > there are I2C and I3C controllers on MT8183 SoC. We will remove
> > > "mediatek,share-i3c" for I2C controller driver, so these patches are
> > > just to support the I2C controllers on MT8183 SoC. For the I3C
> > > controller we will send some new patches which are based on i3c
> > > framework directories(kernel/drivers/i3c), not based on
> > > i2c-mt65xx.c.
> >=20
> > Sounds perfect to me. If it turns out that the I3C driver can share
> > things with the I2C driver, we can discuss it then. But unless we have
> > an I3C driver and know for sure, the above strategy seems good to me.
> >=20
>=20
> Can I push the V4 patches of I2C controller driver now? or you just want
> an I3C driver that is compatible with the I2C controller?

If the V4 series does not use the "mediatek,share-i3c" binding anymore,
please resend it. From what I recall, it should be OK then.

> According to our plan, I2C controller will use
> i2c-mt65xx.c(kernel/drivers/i2c/busses/)and I3C controller will use
> i3c-xxx.c(kernel/drivers/i3c/master/)

Sounds OK from what I understood. The I2C fallback from I3C will be
interesting.


--k2kejit4druie2cz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxsBCgACgkQFA3kzBSg
KbaQMA//RJ3BJa9WaL2VJq/24hYu8KHYFLR8oSwjgTCVTU5CEx/wuhF9Aw06Zntr
WkkM9aCiuqmp2J2WdtYjAHZoaKybFrvF4ktxWQ/iaopO1MHWBFoF4ZbOlKlTiO6s
bT/LA2xCHrc2iDdmgTTNJm9EzAWag9oqx1GYUjwYmMGuwz3H+buaCztv0OKJLz7F
jD5GQTAd1NfDFU+FSM+SAzcSTpI4rIEMr3V6wgGELwmpzS2Tg9MlZIoAcfwvIKyT
gGTlX+nwqQuM1x1NmCsoc8zi2feG32yFbQJg+7lihFMGLsqwbyBVXDY7IBhWuDwG
DWU1+KxNRUsNb5J1HGU/31EfVp4vdaQnZ0yHHx9LRwTcYSJgkXK+tHrfquH+5SQ7
fEbTLai903NE/2E2/OCZ3fJA0uuiwwhr7nVh9SDhFlglFUnmb2YuLZl9OKhtKTss
Fis7vn51hOLOOe3BAY1QFab8/MZ8gBG6/kxaKsf1X5PMXT3CVICGDLerIjFYSqa9
XajG/uYjvOvJWfT400Kkbh/xmXnQg+7TDeohwFvqgwVe32d+3iV4rFxDOklQYGms
VVT9Ahq82ZCjUoj4+21q0B1mI+5E6FwSh83u6ATe0aUD01vwlrsbnd9P3MlGtLeM
Rw86N9PlDnLbaG08s/74s/tJ98/f9ykiH5XelxbdXnfdY20GeUA=
=Bofb
-----END PGP SIGNATURE-----

--k2kejit4druie2cz--
