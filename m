From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Tue, 5 Feb 2019 14:16:41 +0100
Message-ID: <20190205131641.GF12401@kunai>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: qii wang <qii.wang@mediatek.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, ryder.lee@mediatek.com, xinping.qian@mediatek.com, liguo.zhang@mediatek.com
List-Id: linux-i2c@vger.kernel.org


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +  - mediatek,share-i3c: i3c controller can share i2c function.

I am not happy with this binding. There must be a better way of using
the I3C controller in I2C mode. I think it would be easier to tell if we
had an I3C driver to see how it implements I2C fallback there. Is the
I3C driver on the way?


--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZjLUACgkQFA3kzBSg
KbZ3kw/+MPQnVnSHx074f3k4k9AbHCPpsJjFvArfPHwjRjIzGcf8jm/qxMrSppV5
Jjhbjy4VBTdXWt27pyjEhZyc/cypfl+PgCypWi51nvXor7AVu+Cn0oKPeSvQM6QF
6LnUyxnQ+g2gLPM0iZR4QyiY34YVGY3XL6hYcsNFYsX5ezVgFmlH1Rc7m2K1b5KT
CdKaULa8YvRaBfEdCJr3vxszVr8dJXocollbbbWFxTM7O6mIeSKhJ2nG8PiZVhYc
gA6wKFyS+RQrIwRZSAUXvuP6haDpWMzzUCJ6WvHiByGwnuXKq1lk9d4IBe7qjqx4
M8o0gX+uyCV28q6EeUn4s7hWMVp8YL/bjyaVlwmtphNypRRBs9iqeIhSsJ1LdvWD
8m5eTFDdRE2cWfbAM4XfKQ2KPOYVQlVsCo5NFFN28xzfGzFrp1ilIaw1rbM+8nYH
pf942Oxyk2cjoxJJv/O2xoJckESWcNfX7snlYiyFJcGhSQITn/FcFQQSc2uKNX8Q
1hByqi4GD2B2U9lwSWGaiu5yuz3kgwYpcqc0hED7dkOS9dk7vDIGuV88dZS5jo09
rIcU1UwVtCSWLtoIMLVc+PYZEsjtmmlx7293W3BWZjBAoLVUQpPVrdUAl1vM93Lp
NQi1oxly7GIeo2AvFM83rdiI1bcmndZv5yZwgCpbPl0Bf5XgdHY=
=/6Dp
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
