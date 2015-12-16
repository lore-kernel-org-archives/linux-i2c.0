From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: linux-next: Tree for Dec 16 (i2c/busses/i2c-emev2)
Date: Wed, 16 Dec 2015 22:18:48 +0100
Message-ID: <20151216211847.GA12629@katana>
References: <20151216164343.0cb641ce@canb.auug.org.au>
 <5671D210.5050306@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5671D210.5050306@infradead.org>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@sang-engineering.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2015 at 01:05:20PM -0800, Randy Dunlap wrote:
> On 12/15/15 21:43, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Changes since 20151215:
> >=20
> > The drm-misc tree gained a conflict against Linus' tree.
> >=20
> > The i2c tree gained a build failure for which I applied a patch.
> >=20
> > The gpio tree gained a build failure so I used the version from
> > next-20151215.
> >=20
>=20
> on x86_64, when CONFIG_I2C_SLAVE is not enabled:

We are working on it...


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcdU3AAoJEBQN5MwUoCm237kP/2XDPGshICmVsg84tsFpvdQk
DKuiQ8VhrGBMgWuM9Jzp04fbn4v5p6QEVJAwXoEGEQN9A8pkD9u+bzh71bH0mNK+
5rQxmPc9D3QZMV1B0Fk/kVB7PchqjfrKtgq2bC5VsqTSdFqs/x/05ckS36vl38yQ
l9vNkmQJkhsniD0eXd/gksUsAqRWbuZVOzIVWL318yg2bi/99C/5/UsxnONTz2gv
2IvLPyfhU9rGTtXi/RE0djK/79TUSazdWYJVSSlhXSWwdamHJ5t4y3XwwTLNm+Bg
nLel0xaSGkZDqGe8T9QRZPIy62VlI7wqLUs2GxCaWtwLcSyMSdDZZxdw+OKvuVnB
mSdD5ETzJyASVwPdIwpoEQB/ILsSa/QyptjeqBoJ6c7XGo6x4F++12HfzCJ7TwVL
VKHI2+j4+XCLUa39SffAzPf9T4B3v9ith97RjyFyK39hCocCkKUMPN2qHN1EfpHl
PWgOSdVPwhYYF4WWGczZKGowDzjnuM59f/Xcbj87vOgLY36UnzuOeJxm1Lv71zLx
IEmg9ADnPZhefbBSyRfxvlOMe8DHxrX3pojVBrJVlYpeP+Ze4r6VWhRt9rZTwmm1
6lY88Ps8Ci5mVFQClv2ZKB7rQ0G6pfxfFF/RRUaQkqPcz/woErihp8xkRgWhpMFf
mOT4tleUQuM0WsWuQ4hg
=KO3H
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
