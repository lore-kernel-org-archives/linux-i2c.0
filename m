From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: piix4: Disable completely the IMC during
 SMBUS_BLOCK_DATA
Date: Fri, 13 Oct 2017 21:03:26 +0200
Message-ID: <20171013190326.gozfjhmv2pbmnrgt@ninjato>
References: <20171010161115.2259-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yiv6g6hbr5ij4nzg"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41646 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751057AbdJMTD1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 13 Oct 2017 15:03:27 -0400
Content-Disposition: inline
In-Reply-To: <20171010161115.2259-1-ricardo.ribalda@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


--yiv6g6hbr5ij4nzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2017 at 06:11:15PM +0200, Ricardo Ribalda Delgado wrote:
> SMBUS_BLOCK_DATA transactions might fail due to a race condition with
> the IMC (Integrated Micro Controller), even when the IMC semaphore
> is used.
>=20
> This bug has been reported and confirmed by AMD, who suggested as a
> solution an IMC firmware upgrade (obtained via BIOS update) and
> disabling the IMC during SMBUS_BLOCK_DATA transactions.
>=20
> Even without the IMC upgrade, the SMBUS is much more stable with this
> patch.
>=20
> Tested on a Bettong-alike board.
>=20
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Applied to for-current, thanks!


--yiv6g6hbr5ij4nzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnhDf4ACgkQFA3kzBSg
KbY12xAAl/mbAEkd1HtOlW28e481xNixN/dYnj2vRPgfbnB13CgkXmhxjfW92SlM
Ckj6wUP+BCegjpWr1YkV+uQp02rYcnHqji2qO99W0vb5p0kLXKBJny/MdeFUReIX
XTNhf+ea8xcemx7ClQr4F+01xe+kXpOBL6IvyXdfgshuDVZCaEzLJc0hdlIjPuA6
dLk8biI8oAxQ9Z7SF7QIubnOwvCVX6aC7H+bCZIL8MraCQcq1jDhdn/gi1R5OlJP
TqRDnK3Va1mVINEKm9OhYxcCTu64wZq358/Ymf0PZ0LESFd8MkwrUjucfVqlLGOg
MwaAkhwQTu8DhvERj2LJEp4zg1UqX+pyK5pfZVV7K652HEB6AJF7tLzDPOMkyk9t
i91bF++1EgKGTkRpFRvuPwZzPDhI+lyVpyBgiuewMNuXZCHzIwsHNkh/zfuIW8Yz
1ukgFqWjy4dEVS+dcO1Mj0f6y5DqeuK7bxkh1ujgLgzg1Exr3UhJTam8mL9cMrXE
2gXQSHdDR3LO5eqQQVVsbtYacvvsqinnHP29e/UAZpkf5cpWa6XiGevm2Yf+snpl
bwEDXTkRgX9QBqQlj1ahLWawR09zdpJWBrCrlnIamxOCz78+qRD2jI4LNCID3XIY
GW8zgERlSIh37bgZM3BXsIVL9H6/+gL2HyLlHxCwUcEOpSUOtw0=
=bipU
-----END PGP SIGNATURE-----

--yiv6g6hbr5ij4nzg--
