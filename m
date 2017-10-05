From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] dt-bindings: i2c: Update documentation for
 "mv78230-a0-i2c"
Date: Thu, 5 Oct 2017 13:08:20 +0200
Message-ID: <20171005110820.phcjh7dmygi43dhq@ninjato>
References: <20170928213605.22874-1-kalyan.kinthada@alliedtelesis.co.nz>
 <20170928213605.22874-3-kalyan.kinthada@alliedtelesis.co.nz>
 <87k20dmxw0.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c3k3g3hmxn2uyaya"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87k20dmxw0.fsf@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>, jason@lakedaemon.net, andrew@lunn.ch, sebastian.hesselbarth@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>
List-Id: linux-i2c@vger.kernel.org


--c3k3g3hmxn2uyaya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2017 at 04:23:43PM +0200, Gregory CLEMENT wrote:
> Hi Wolfram,
> =20
>  On ven., sept. 29 2017, Kalyan Kinthada <kalyan.kinthada@alliedtelesis.c=
o.nz> wrote:
>=20
> > This commit modifies the documentation for
> > "marvell,mv78230-a0-i2c" compatible string.
> >
> > The "marvell,mv78230-a0-i2c" compatible string enables the workaround
> > for an i2c repeated start timing violation, but unlike
> > "marvell,mv78230-i2c" it disables the i2c offload support. This is
> > applicable to a number of SoCs such as early revisions of the Armada XP
> > and the Armada 38x.
> >
> > Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
>=20
>=20
> I applied the dt fix on my mvebu/fixes branch. Do you want to apply this
> one on your branch, or do you prefer I take it. In this case an acked-by
> would be nice.

I'd prefer to take it. What I'd really like to see here is an ack from
Rob because of the previous discussion of an earlier revision of this
patch.


--c3k3g3hmxn2uyaya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnWEqQACgkQFA3kzBSg
KbZX+w//YXKFM19HnM6m7d5reL8L5ZKnl3jrgkHNGiriSVgvNyVMg2k+urkC+IgS
btqzZ0SA7kAQ/rDXC4A5hbvANB44SWMwo5fFAAwhN1UCILbKBsnTzjl273HrCR6s
KoxPnyz2EbGnGVqDKK3lUY+6Uxgo9u30LFcnjIlvlJL+vnhdfI+SnSvruG6OghhK
gGFPBU/xQyLZ+JNo1UQ8ccKkkGEg/1zb+XPbaeKzH9Jjk1OoaWX/tElv2GdsvAiK
lgbgDYHzXKUcd/6ukxQGR6ItShjAUfZNNIBKoMgmMlYbWoBBkVJX3qnbaR5L9MDH
r9Lzgn9gNCMlrGNV4xV6DIfPw+L27SN3hoCIH17oCpqAG/lPCu/UL+eqAnKzTm2v
yvd2UlfgCmPL19zdx0a7Rpg6LVynkCymApZalb/WpvlCjCj/HGYyzknClYrydwZK
tA1AIPo0dujg2l4IJgMRFaNXoAAUYRMhjkUZSy9cyCd6uM5OfXEj3UMWevyARed9
kU8d05rqQDkWDAXX/MKcbCwAhDEJMzR5QhyvzXYkxSNH4EwohQpMlboVnxX0S6Xh
b3Rz3R2lsCTsTyvOwLqwnx7tOV0IdOiHLoP/e4Q2+/UorC7AmX/N9UNhkeqYuDJl
YuK0t7c7o5FykvUYTax/ebCGzMRPegvFR5Ox4FOX+zY7RaaDE1w=
=DKpW
-----END PGP SIGNATURE-----

--c3k3g3hmxn2uyaya--
