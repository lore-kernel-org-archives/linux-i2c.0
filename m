From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/3] i2c: mv64xxx: Fix clock resource by adding an
 optional bus clock
Date: Fri, 26 Jan 2018 18:53:54 +0100
Message-ID: <20180126175354.nlgn43co7klyz4b5@ninjato>
References: <20180116163540.1092-1-gregory.clement@free-electrons.com>
 <20180116163540.1092-3-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="urhbhffyjpf7ozal"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35707 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751398AbeAZRx4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 26 Jan 2018 12:53:56 -0500
Content-Disposition: inline
In-Reply-To: <20180116163540.1092-3-gregory.clement@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>


--urhbhffyjpf7ozal
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 05:35:39PM +0100, Gregory CLEMENT wrote:
> On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
> is optional because not all the SoCs need them but at least for Armada
> 7K/8K it is actually mandatory.
>=20
> The binding documentation is updating accordingly.
>=20
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied to for-next, thanks!


--urhbhffyjpf7ozal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlprazIACgkQFA3kzBSg
KbZ/tA//V2zoQ73ugp6rQKOs0GRdgm5jmcjW8kYFFEprHUs2yRdaXyRtrNd5j6Db
ttzAc5QMCpOBVqk+cIsJeZ1YmDwbv+QU97xd0fu06slofr/T/6JxeqYycMm2Px9/
PuhGefW3CCq4ErB0afkQugTAUzNA4+aU9NZMoykQvtEM4MFg3Q7n2rgeWC9EQb8K
160md2Fg9gjD9jO3oL/i4nfl0ZK9YdsLrU+aQa5wszjGDOe8mzpCFjRjoPIoxSps
Cw2nHRjqEvPj83AtzjYTqfZsu822/q5ET7II+ZSJKff4cq+9hpT/36MzqpGsOD3I
MQ/BlyGFHlq8GIibeb61/+X/Mq5ShI6yms6t3tlO6CTP0XHnZ45by7edGwSEyqAw
/c38nALKjsjwLcV1SknSmkvgVhE4L/sshBJqtD9XVVvA6R4odibYT2PAYDSygdDa
l6GsRhhAaCVNriey4mCs14RzZAHG7I8KZk5OdZ5QxwrJtsU7AbtxOGqUwt4juH/Z
Za4V3iapQiKlCkwUbX1blxWRjAJuLhM0bX+q7DnB2gbdq+2iWiDdcAJhQ6Y6DpjI
MMYBccj0CIfrkedt8XIa3VkVXZSsEyzIPqa9+AttPn+1ckdj0m62l/ZIlzE5pIce
3EHWu+8bb7BeA2h/TLztbWGV9EYDXauq9ze49fv7bcQ8h/hMIlM=
=jiX0
-----END PGP SIGNATURE-----

--urhbhffyjpf7ozal--
