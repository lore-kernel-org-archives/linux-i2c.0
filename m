From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mv64xxx: add suspend/resume support
Date: Wed, 25 Jan 2017 21:50:44 +0100
Message-ID: <20170125205043.ze3m3wrjovajbps4@ninjato>
References: <1482422042-30201-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zaga3iclg3zwx6rj"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38912 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1752257AbdAYUup (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 25 Jan 2017 15:50:45 -0500
Content-Disposition: inline
In-Reply-To: <1482422042-30201-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Grzegorz Jaszczyk <jaz@semihalf.com>


--zaga3iclg3zwx6rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 22, 2016 at 04:54:02PM +0100, Thomas Petazzoni wrote:
> From: Grzegorz Jaszczyk <jaz@semihalf.com>
>=20
> This commit implements suspend/resume support in the mv64xxx I2C
> controller driver. There is no need to implement a ->suspend() hook, as
> calling mv64xxx_i2c_hw_init() at ->resume() time is enough.
>=20
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> Reviewed-by: Lior Amsalem <alior@marvell.com>
> Tested-by: Lior Amsalem <alior@marvell.com>
> [Thomas: switch to dev_pm_ops, fix build warning when !PM.]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to for-next, thanks!


--zaga3iclg3zwx6rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliJD6MACgkQFA3kzBSg
KbYHsA/+LS8m9YxUb/j4Eu2WfCd6rbKiAcGuu8wcBg1mtTrxL5bYFCfTjBDpt3AG
8jprVVc8s4YAeHP/fnU4gYjYoMFKdooVRp7tfunsgl5mAlG55utetSIqdXrW7jbC
nhcUMtTnRNc4REeqJxlPBuqgPWWTRB5d2qa1JUNIbK8A/bsALM/Z5a2lZTPc5KJm
welzosVWc6D9Ezw630y+uyWroEzyZRtEIuU0wd4IjjBQ7SkmYhhGfFXPZLoM5T7A
U3BLAIuBz8FiN40Nm2Xn4EC7GzFKQlcbN9zhAeH+Y81+we2s/v4zSxYrmkJZsFNi
P5TZ4Lz/3IsGTIQli2qH4xqYGcbfAGXlwedbqj/ibw2hI50DbXDIyYpQLPwGoB8F
nP5X9qYYP7VudcIWT2z5+VnnR/lxlY6+JADxN8n7TBKKqXlnZxL8iwBMLeuZ1lmA
H86oa9MzNKppMXZGyO6k6V6DTWgFVd6fxGbxW784qPPZrh15UmmgYUSRAlyaonlE
Tgg/O1TRVE+aNmVn7cR0U6Oyu18sk5lmzFKhO1J+sSnEKzzzUKhucu+HjEe+UVEK
rkkkh3LTgImM9P0zXgO/KiRqhUeUyAahi6d+ehb4LownNdkTa8qOMvApK01nxQuz
CXqxY3Zy6eG9bzESxRDDrp3Xz5FkF9IoBaUMLyNADh4MdDiqNro=
=GEZf
-----END PGP SIGNATURE-----

--zaga3iclg3zwx6rj--
