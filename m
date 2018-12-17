From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Tue, 18 Dec 2018 00:06:29 +0100
Message-ID: <20181217230629.i7i3kbreurgt7u73@ninjato>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
 <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
 <20181211202931.xav4gzi7rzh2scgx@ninjato>
 <1544693547.11699.40.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1765357498413480999=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1544693547.11699.40.camel@mhfsdcap03>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Qii Wang <qii.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============1765357498413480999==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gph3bc2aynqejfb4"
Content-Disposition: inline


--gph3bc2aynqejfb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > What is "multi-user"? Why can't you add this offset to the reg-property
> > directly?

=2E..

> MT8183 doesn't need to support muti-user according to the latest project
> information, and I'll remove this feature from patches.

Okay. It will be dropped then, thanks for the heads up!

> > > +  - mediatek,share-i3c: i3c controller can share i2c function.
> >=20
> > Please explain in more detail? Is this an I3C controller?
>=20
> Yes, it is a i3c controller, and it is compatible with i2c. I only use
> the feature of i2c, so I need a flag to do some extra settings.

Can't you derive this from the compatible? If it is
"mediatek,mt8183-i2c", then you know you need these extra settings?


--gph3bc2aynqejfb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwYK/UACgkQFA3kzBSg
Kbae4A/+MilZ2mxtZBN5/KQAX4PI8TwMRQpdfTOFfHZL1U1qxKqJm5ojSZvI3Dle
BxpSYHyWhFGblcmMckmfTHFSVfPu12UB7ma0h3A/h/6gXTemtuS1LXMolzhA6rIx
ShCNSsmji6Wk4AH0Bjok+uaO+0dP6SzWX978UmQdNPRAXg12Txf39t8cFzdwkh6t
/kN6UcNP9aUgVXASp/FXlDfGUQEQvN5opoae8JzBJYvmO7/hbECqRykVlQ1S5p4e
cwuRjPohrvKGkAwvWuyL7IoZVFotwtd9NEFE56xpykuDKMHstnmqbUS9vYKboWmZ
oLA0B075zO/iAYhAjKmbD25NAGGIucaTXpB0OsgRdRuQMs6K0rdyUZ9j81iry27N
zU5wKtoim8klrsgqQTHu+pZ1gYYgKP+M0lu7Hc1P4AYGE/qiEx4KSTX8ZBB7xXPm
JndAI+ElJracuCTvxDBPZfx5YlQnqOngKwGSwLInVGClA3sm7gRZu8TY8/5jlx7r
f8evwPSN6A7bSTSLJi5RbKe9PkmXA3XFMa7FWamrluxeVdf1jAmXC39VAF+mIvVi
ncoTmAmoVIo88lSX7qUNjZVGS6syFgQ3WYZ6lxu0b7lbx7j2PggOZl2l3dc9d+vP
GbV9jZYhcSF/57+zDFY0TIvfKT/JxyU9FZCuEHTdGcS3zosRL4E=
=FiE4
-----END PGP SIGNATURE-----

--gph3bc2aynqejfb4--


--===============1765357498413480999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1765357498413480999==--
