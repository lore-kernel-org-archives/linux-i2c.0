From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 2/2] i2c: mv64xxx: Fix clock resource by adding an
 optional bus clock
Date: Fri, 12 Jan 2018 11:54:34 +0100
Message-ID: <20180112105434.juefp2apuber3zti@flea.lan>
References: <20180112103956.4875-1-gregory.clement@free-electrons.com>
 <20180112103956.4875-3-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3pnuxkix24o7mn5f"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:47828 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754845AbeALKyg (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 12 Jan 2018 05:54:36 -0500
Content-Disposition: inline
In-Reply-To: <20180112103956.4875-3-gregory.clement@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Antoine Tenart <antoine.tenart@free-electrons.com>, Omri Itach <omrii@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Igal Liberman <igall@marvell.com>, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, Hanna Hawa <hannah@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>


--3pnuxkix24o7mn5f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 12, 2018 at 11:39:56AM +0100, Gregory CLEMENT wrote:
> On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
> is optional because not all the SoCs need them but at least for Armada
> 7K/8K it is actually mandatory.
>=20
> The binding documentation is updating accordingly.
>=20
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/i2c/i2c-mv64xxx.txt          | 20 ++++++++++++++=
++++++
>  drivers/i2c/busses/i2c-mv64xxx.c                     | 12 +++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Docu=
mentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> index 5c30026921ae..3d76bb19492f 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -25,6 +25,15 @@ default frequency is 100kHz
>                       whenever you're using the "allwinner,sun6i-a31-i2c"
>                       compatible.
> =20
> + - clocks:	   : pointers to the reference clocks for this device, the
> +		     first one is the one used for the clock on the i2c bus,
> +		     the second one is the clock used for the functional part
> +		     of the controller

This documentation is confusing, as usually the functional clock is
the clock driving the bus, as opposed to the interface clock clocking
the bus interface.

> + - clock-names	   : names of used clocks, mandatory if the second clock =
is
> +		     used, the name must be "core", and "axi" (the latter is
> +		     only for Armada 7K/8K).
> +

Are you sure the i2c controller is on the AXI bus? It seems more
likely to be on an APB bus.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--3pnuxkix24o7mn5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpYk+kACgkQ0rTAlCFN
r3QjPg/9FUWznCDoUA7CV0ORMzyeloMqOduktthyi9YwUlubxfdA5lyylN1UzRIE
ESfzAM+4s03vpk7t6hNXnN0V26BqmO0yhE7EIJApks1NqKtKPWghCRj7sSXh7xog
Q7MqXGgoLQMzxG/yt26r09/6Lof5qUXFufBoYQCfJrjkSzVXWz4izEcHi31hU3yn
9UtE/6kNrHsT3z9U+9pPC+cUr7nf/9s/half7SaDDP9WXX0HgC0TQgppKJYm6MLi
a/7qbfLzgdwyNT43zj5hTIu8KeiOG8t4aiGLZprRMqOaf4ekXTRDGdj6IX8UO6C3
nejtqDgklqOIyVfOSpZMrAPTAT5g3tIfOoZhSBdmNc11lK7SeGcjc/QLLCeTLEAj
5+hV4dIvESBE3VFOoR1jJGk7CjMyYi9Gca3TiYuVEcqcfzCxPh4aJEMKD8MSTF+i
UIeMHlx4a1HjLfUgFm/uut6mUKtDyRve8/S1Rt2KQGC1Y3htzlS+qEMJAI3XcGvU
43YoupSM/r318thuilAuwKyHh4rkAifIFrYFLe6LEWAW4BqTtK44wLFYnGbaKdoY
hRBv91VyPbStghX/zGTxq089dF+UVwVvPMmFVRZ7dd2xh5x3MkiHAtDCgucjk7UU
ox+pahXAXVnM74cqKTKvrjiFcwudUASQbERYnhPRpm3ybLn8g+Y=
=UGIs
-----END PGP SIGNATURE-----

--3pnuxkix24o7mn5f--
