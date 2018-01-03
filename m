From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] i2c: mediatek: Add i2c compatible for MediaTek MT2712
Date: Thu, 4 Jan 2018 00:55:54 +0100
Message-ID: <20180103235554.euwpwsaayx4qnsao@ninjato>
References: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
 <1513666263-6443-3-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2347089293396977800=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1513666263-6443-3-git-send-email-jun.gao@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jun Gao <jun.gao@mediatek.com>
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============2347089293396977800==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6o2m37ld6rzajrik"
Content-Disposition: inline


--6o2m37ld6rzajrik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 02:51:02PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
>=20
> Add i2c compatible for MT2712. Compare to MT8173 i2c controller,
> internal divider of i2c source clock need to be configured for
> MT2712 i2c speed calculation.
>=20
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

Applied to for-next, thanks!


--6o2m37ld6rzajrik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpNbYoACgkQFA3kzBSg
KbZRaxAAmL5Clq4EqhkfuPEFJVg9egdayPWRO9JupJaLWgsaA7gnJKrTrg4DTnbA
d3HzvpXFBLNcchAGUkQwFwNqQB9QNkpYAaAOXGi3ltSu1TJf+cRY2TFzrYBY0X7A
F6hnO4hxlw00ywHgbhiDKEMeOehlo3E+wJd9/yjNJUrI0rT/ZDJk9AGaAJdx/WVs
7GBUkyyaIUO0CRv7OHRQ3wobSyrKxcTAFPlkNOScb/ZjLbTNd4YNhw940glJUS0x
M6qWB9zB8mO1EV3ZwLOVWOUAJg5raTweXishcvcpAB3X4vfuF1SG+AvQoAmd7NOG
GO0BnL2GEfjdQyrcTp8E56Dxs6JaAYMfeJ9/icWFyImUvhRBPimeXcOoHC3k8N0z
KG5tVpybYJt1A/1LNLmphGoAMSKguxZhvfLIjVYr/rPIAZnmRbiTZg0kacPoXYof
r5OuJ8AC6dVVvrBFhQ0l3Q/b2a0HqosJihKkd72jqRklhVwZmKvt+sDFwKbXJjvp
4XG/YYrWJylMtddZVXsC5ZJwozgyQPCzslO6fzm4OUyZFO6jAq40RT8I1OgSgDu/
a6SnTrhMYwCKVCtBXwLYCbexmR7OLnOI9+R2RJ/GHpZAnIou2jZ3AhuapdDnJNBx
khfQvTZmY2NQQiSw2EQwA1zrGn+X2TQ9AZjPv85p/AoUFEuHUcQ=
=HKHU
-----END PGP SIGNATURE-----

--6o2m37ld6rzajrik--


--===============2347089293396977800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2347089293396977800==--
