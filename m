From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/3] i2c: mediatek: Register i2c adapter driver earlier
Date: Wed, 8 Aug 2018 22:40:17 +0200
Message-ID: <20180808204017.yfne5q26lmeegyrr@ninjato>
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
 <1530955795-17714-2-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="edtn3rcstugf43bt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530955795-17714-2-git-send-email-jun.gao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Gao <jun.gao@mediatek.com>
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--edtn3rcstugf43bt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 07, 2018 at 05:29:53PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
>=20
> As i2c adapter, i2c slave devices will depend on it. In order not to
> block the initializations of i2c slave devices, register i2c adapter
> driver at appropriate time.
>=20
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

We don't do this anymore. Check these threads:

http://patchwork.ozlabs.org/project/linux-i2c/list/?series=3D&submitter=3D&=
state=3D*&q=3Dinitcall&archive=3D&delegate=3D

(/me just realized that patchwork makes it super easy to point people to
various discussions. Awesome!)


--edtn3rcstugf43bt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltrVTEACgkQFA3kzBSg
KbYICxAAo/n3OTlafeyeRr//nATBT9Z4QGjhugCIw5j1dZeXcVCbHuC6+m5jW2su
Q+JcZSwx3AG3VbgqG6ugJ0QUi94NXv459IbBRuhQQ6FukpKLFV1AwZFasDh3Rmqb
HfcxoTg5zCGEJLwc3nLSne/q7wiMzaImqREHanQUXY/iHIbWDF0g32yL4BSbx+6F
XLIbhAvRE0Xx52QBBQkYpB8FB82H6kgKXu5Kq/PRFs4XAhKtMTb+nMxQExCB8SWQ
yzFmb/6Img+vwY+180qSWlT4NjAYZ9kV5tNjA3qRCg7G1lOJiihjm5l30dZEkZOJ
hCgBh4FN1UMIWn90pgWDZXRNv9ByCvzaUk/NoeRJA8imyjjC7w5+5WVTqIP1oy4u
BRfEbQ3hjBpvm7kV699l78uv+Z6xayEvjHQrbMcTVh7sCODLerMk7Dfrp9GfgUG+
Z1Irc5DcHWDnfD3SyKR5s4XlF3ldND+b+bQEuISXfCgCypF0VVQArT8KSx/V45ga
lgwexvHIakklxVVnEWQhqnkYn5S79SlbHxfPW4hfPzs2EAf0e6PTN3iHMh/WLfKO
wg2NI8z0HkA2G928NvBBkSPZgrvDT26SlAytDreNRGK5Gr0IkKD0ed744ziGKeiV
msiRreTdwi0nKpoxbs1zsGRjsDwk1uaBH3OEpBHynKxSpnrUrU4=
=0m2X
-----END PGP SIGNATURE-----

--edtn3rcstugf43bt--
