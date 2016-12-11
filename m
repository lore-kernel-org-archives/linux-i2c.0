From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/4] i2c: octeon: thunderx: Add I2C_CLASS_HWMON
Date: Sun, 11 Dec 2016 23:04:35 +0100
Message-ID: <20161211220434.GH2552@katana>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-5-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EemXnrF2ob+xzFeB"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:56062 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753870AbcLKWEh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 11 Dec 2016 17:04:37 -0500
Content-Disposition: inline
In-Reply-To: <20161209093158.3161-5-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, Paul Burton <paul.burton@imgtec.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>


--EemXnrF2ob+xzFeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 10:31:58AM +0100, Jan Glauber wrote:
> It was reported that ipmi_ssif fails to create the
> ipmi device on some systems if the adapter class is not containing
> I2C_CLASS_HWMON. Fix it by setting the class.
>=20
> Reported-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

The intention of adapter classes is to *limit* probing to a certain
class of devices. If a class is needed to *enable* probing, then
something there looks wrong. From the details given, this must be solved
elsewhere I'd say.


--EemXnrF2ob+xzFeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYTc1yAAoJEBQN5MwUoCm2LSIQAIX20yDldMz9lm8bFH5uEDYL
TOWe5rLt8ZZJqhpn63Vjvd1u3p75Q8IrAiU7cf6SWbxWxeo3Q2obvl1JKrSNLvh2
CoySL5Pjn91UWYOgRsdt+jPpoD2zXfzVywMnhjkNDEUD4P6DYZ0xUxegsd83jJUX
h+s4pCwhSTGUVoCSjaRHAsy4cDHfaFJGprTR4/6pP6CAS0+GGtH+K4F6f5uXu/Sb
jVXQo5CkOIvfFixZP41IL8mOz2rr2aKPHpCtCQm968BEi2ZaVUDuAkC7Qzu83q8N
bXDJyh90cjB5KGwwi2MMLXGjYyFdSU8YliFjbFcF0We/1gTcEE++V+hcpB+O08gW
tW8rv3R3TCMryphua7B30KRCLmiNvlTe9anwhDuVmGtzlC5g6IMNgGw1xUE83IX4
pQe7JMwDqFl6eRPGyG6FxXn9Kyhm+aA3JV1iieteheWtbIoTu4pYj/iJVaP+1VDE
InP8NS0+w+EQrSCxqXzSj8KfyyweB/ShEAh6ViStqYTtmjO0XN6drMmmjx3V1MOb
eHykjmqlpGu2Lz2bAjnMMTjFFF7OLhuAXzN1G4x9bYCR3XgtXl9oWnozIif+sNCM
3cfYV7RKskXZ6P7951zo5mnupwuNmUYWFAb3HPAgLb7a8JKKzyBYLvVmRlVMzO3c
JtiAo7vQ6jreCGG7QO7q
=1tXB
-----END PGP SIGNATURE-----

--EemXnrF2ob+xzFeB--
