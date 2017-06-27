From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 3/5] i2c: pca-platform: add devicetree awareness
Date: Tue, 27 Jun 2017 21:55:12 +0200
Message-ID: <20170627195512.v6fypt2djammkym3@ninjato>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-4-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4x5nb73gh3sdys3i"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54146 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753132AbdF0TzO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 27 Jun 2017 15:55:14 -0400
Content-Disposition: inline
In-Reply-To: <20170626004434.2757-4-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: robh+dt@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--4x5nb73gh3sdys3i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 12:44:32PM +1200, Chris Packham wrote:
> Allow devices that use this driver to be registered via a
> devicetree.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

=2E..

> +		if (IS_ERR(i2c->gpio))
> +			return PTR_ERR(i2c->gpio);

coccicheck reported:

drivers/i2c/busses/i2c-pca-platform.c:209:3-9: ERROR: missing iounmap; iore=
map on line 170 and execution via conditional on line 208

I fixed it like this (incremental diff):

-		if (IS_ERR(i2c->gpio))
-			return PTR_ERR(i2c->gpio);
+		if (IS_ERR(i2c->gpio)) {
+			ret =3D PTR_ERR(i2c->gpio);
+			goto e_reqirq;
+		}

and applied to for-next, thanks!


--4x5nb73gh3sdys3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllSuCAACgkQFA3kzBSg
KbalLw/+PDZb40JemZ84LaF/NIewQqWL0aeNoqJohJcTzDczDKUwofzh6sgM33Rs
cjjogzkKVWsXlk8fVhaRh80ixqIJz+6v+eINsB7DljB5PJCZX530ok1Kgnd8Ecne
NZqjaw44dyUjDIfHwWEgUTS4UhqkpdgFmQs2dW/y19OaFB6BClncbAWh1ioliQ+a
udNlR7z4B2fABAsQ9u7lrpnTUyzTI77McSXaF4BIab9znn3q6TIVrvVRCfnYI65o
2Y1ujIV7bZwJKR0eIWdg1LQ7KAg9uj3PAiN9U0RJcGsXceKfd5F4tNc4OQHDZ2o3
E4gL0zeAfv45xYM76EyJPv0TWYit9UkfQV1UlYmjwe7a94B2kUhlqhGeMsiSPtwl
QDbrPB1ygIEmYyhrNyRhnpxRJQJhw6Q/unwWjxzEkpw28VIWaIMwGX+jQl5TCcGw
1qGSDubwl770BcRjUtbLz9cxKdA450C+DdWwdM3doNiWgvFPhqaSN2zDO5MmsgWI
1wNq3goIMhFKUPXsaYa6jgXMa26SVVFvG/bPDYYGeAqbWTtcOFWBmezO4YE3SUUz
YmYSxj0+aGCUU5FayTnmrANfeAZ+54BvlmGNhcRoB9wwreuWhln+imaXXItcFppx
A0r/7con/Ps6zIe2GXvt4cWHR2uQa8M+9roOltoELTWtn+6pAoY=
=slZv
-----END PGP SIGNATURE-----

--4x5nb73gh3sdys3i--
