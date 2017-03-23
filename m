From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: thunderx: ACPI support for clock settings
Date: Thu, 23 Mar 2017 21:50:07 +0100
Message-ID: <20170323205006.pqlaw62gfvh4orti@ninjato>
References: <20170302103407.24264-1-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5lnsudtuild7nubv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41053 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932359AbdCWUuL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Mar 2017 16:50:11 -0400
Content-Disposition: inline
In-Reply-To: <20170302103407.24264-1-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--5lnsudtuild7nubv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2017 at 11:34:07AM +0100, Jan Glauber wrote:
> Add support for reading the system clock and the TWSI clock
> frequency from ACPI DSDT.
>=20
> TWSI clock was already covered by using device_property_read().
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next, thanks!


--5lnsudtuild7nubv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljUNP4ACgkQFA3kzBSg
KbZ+9hAAgaipon9bNNet11L6dx5wMqasEspNfgd7+zzEvxUzCxJuPMOT1UMerhCX
vYr7cBXlS76EHVZU7cTCKj5X1QeQ1pMsxX2jA/GvkPis06xGU+tCFEidBOxOdaqF
hYhhhi1EZfhQi5KhW6+ioOJdstPEIzPzybnUe1Zi8biL2qsRe0ksbMlIy+VaZlbc
rypvp70rtLWtR0I4GkQGeHhh2GjIWoFcKXsZ/LDOzcvuVEzpDRkujYERyE7np88P
2GqE9/tGNQ5ExQfhIys9fIuQU5/nCDcj7pGvFyxp8KpwOelxrumwfg6pE1qfnIdr
5ViVkX4ih7kczizH41GIKmwfbFRFAdmNUu8WbQCliIcQBx5vVGWSAJeR/fwHVip7
wC8PHBUagjElhK+Q8nlqBiuu7Uqog93sFRXRTLn6jSxMzMEDTE23qOOsilzZ7Ytd
ghIOLnREFjLo9NNUj6m2pM20JZfvxOHeqcAbtgtfdXBQvukcO+mAdC/5SpXfMzOx
OsrZSUBcS47FXK3WznXTiqE/ZyyY0417CipP61+/kXf5Jvp6fGwB91SQAio2WoBz
rM+c+jVexND60kB9F9R9zXegl6EdSn9RClI9jISLyROl9jx4yzKc6ZONZTKxPAku
efeSvDZklse+2pldPgnQq1fp1p9Ds1b9U6nE3feuc/i3/3sgXqw=
=498Z
-----END PGP SIGNATURE-----

--5lnsudtuild7nubv--
