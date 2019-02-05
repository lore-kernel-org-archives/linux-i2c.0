From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 3/6] i2c: mediatek: remove completion_done()
Date: Tue, 5 Feb 2019 14:13:06 +0100
Message-ID: <20190205131306.GE12401@kunai>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-4-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548057574-8061-4-git-send-email-qii.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: qii wang <qii.wang@mediatek.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, ryder.lee@mediatek.com, xinping.qian@mediatek.com, liguo.zhang@mediatek.com
List-Id: linux-i2c@vger.kernel.org


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 03:59:31PM +0800, qii wang wrote:
> Completion_done() is useless when we don't use its return value,
> so we remove it.
>=20
> Signed-off-by: qii wang <qii.wang@mediatek.com>

Applied to for-next, thanks!


--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZi+IACgkQFA3kzBSg
KbYX9A/+Iivc9MIigT8flNM1FNz4z+XyRPcIdNWzZOJTkrPhh+nvPaQg9Ou28BOY
h/19/ZuwrjWE9UjJt1YFXN2zUyuczWwFz9FQeK0YA4nF8z8k1kaQTOlC1zmPkw14
nSzKTjWjyMYxx/R1vuv4XLWjOkgrhr1GCsRle6ytq/Yuuh/By+yQVg6FXxPWQCue
JyaHEsvgN2TYezWwdSKO4NOyMF2yURo3b4VHhL3DVKFWFzkRPm7SZvlqAaDYIQKx
c9oJuUCJE55yTNx0d4YlQQreZZawxYyTVwfLREM5oztgY807+LYFL1pd0+b+EzrL
1A6cw4IFABGWEnnLWy9XpVwliNUi+WdzyMeDJsQfVvZgEc2cTZ0BbhZZJORh2wKo
4z8z7Roi1foHef+lyJwyzt96AFLSoeJqEbpuPggCiKKgYSHyfW1TMvXAe8IpgAv6
8Je+Pp4AzkSlS07YN+ANzjjGQxOZuTy0Vvlm4HDZVDhDrXmJU6Yrk7z99kBzKe/c
Zvyqtb9wUe6niiPIDTmyqGXtkjVrb9/7GdGcBwtltEq3bpHjTXwdRASYNRe1lqF+
diUZuYEjOcpDP6ukt5D9kzHdO/L4UxUkDxLKGa3b/RhWl3zQcKlw3uuRYxQT7g2K
EmUCZHyBWqF7RfERjascnpr1JUqe9pcLJzwfTkw+N9gbupY/weQ=
=XJSM
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--
