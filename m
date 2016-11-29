From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH 1/1] i2c: designware: Consolidate default functionality
 bits
Date: Tue, 29 Nov 2016 20:20:54 +0100
Message-ID: <20161129192053.GA10914@katana>
References: <1479725000-22513-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:58272 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752196AbcK2TU4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Nov 2016 14:20:56 -0500
Content-Disposition: inline
In-Reply-To: <1479725000-22513-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 21, 2016 at 11:43:20AM +0100, Alexander Stein wrote:
> Use a common place for default functionality bits for both platform
> and pci driver.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Applied to for-next, thanks! For the other change discussed, an
incremental patch needs to be send now.


--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPdUVAAoJEBQN5MwUoCm26gwQAKOuIGo+JBjoZG0pfSmxZNFp
QC8KWBXJt4Ygct3kg1w1iLTJkHrS1QzJcT1ZZH/ITwfJmRAdAaRN0ecrB/DnhHFc
CXbXnjt9QDE1NzoUHfL2JYLGSdkTbENmN9dAxTLu1wQM9/6A0XmFENN8y52Ley0u
fbXj7gi1d4td7Rm2zc7M5bSc6ZHWT+IbRqwzgGjNGJcWxOPBez4x7nqUj194AMx3
nISgj7TZWnPO6G5J9ZKZwgPXRIfyZTpSvJUzh7gjlzeeTLb6jZ5IrmuLxhv2cC6p
Pgecb2CjEUkG/scsI3J61+q/HEuf1Gevxt190vHbybXCaDWNkAfHbX8Oi1ynSppt
TqG/p0ZZ7yupOTigfqyLFlKzrVELGHUnuAmtCrxWAudMTqkRZ5hOdqSyEPpfSLDg
W42vMtply2YkN7qw0R2QoCqTlhGKeGzED3mAeFHKOn2YQwxbZ76Sb2gPROIPR0pk
+043dgo3wPMk74ugfzDikOx9dUR1h37uwae8fAq8mJLO/SDml+sBubhgMIIyAbLX
jN7maF8nbEiyGFTB5fiyB8kzEgnJr4pbLOl5rLTo/xw/WPcwqkpx93GGL+heU+x6
Yordwi79hnLt54UJu1C4PAYAFffxQSU/9DUjDx38cJrQlh4yduuJOhc1CeBoZm7/
W/FcQjFErQlYIJI13xyZ
=Dup9
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
