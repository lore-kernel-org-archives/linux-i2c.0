From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH i2c-tools] CHANGES: add i2ctransfer
Date: Fri, 19 Jan 2018 10:19:29 +0100
Message-ID: <20180119091929.unxyczdyrwle2psa@katana>
References: <20180115173644.12342-1-wsa+renesas@sang-engineering.com>
 <20180119092252.6eaa32c6@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pdmjyivbae3y7sox"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:35036 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeASJTb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 19 Jan 2018 04:19:31 -0500
Content-Disposition: inline
In-Reply-To: <20180119092252.6eaa32c6@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org


--pdmjyivbae3y7sox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +  i2ctransfer: new tool to send user-defined I2C messages in one trans=
fer
>=20
> Good idea. A leading capital would be appreciated for consistency.

Ack. Shall I resend or could you fix locally?

> Speaking of i2ctransfer, would you agree to remove it from the
> i2c-tools-3.1 branch? As I recall, the only reason why it was added

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--pdmjyivbae3y7sox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlphuCEACgkQFA3kzBSg
KbZGbBAArHmas2YwU+8FWenKZHoGQrDjWg+G/wxT5chEDbXnOk/dHf1WxnpXwjzC
RDFXgbnRmAYCjpsyiCCLnTgu4iSQnXjIHpIs5cdvADcGiKBOT4rRqil0wSqM/GHx
1XB5ctvo+0sB6DsJ15I4977vUFnVixxRRN2aHfZFmmoUKdZf+yPJeK0GhaipszgA
6Pbs/cT6Hav3GO2iHvu+50U4GfJQC2KVfJi0dm8VnUKEBQ6/xtFPsm0brZy6GWLb
jQG6qpKsUDGRvYejbvy4BD9n8mJG+FfUKCw4giR2B1Y6mSspPTaoFtDQXTwNCbal
4CRQF/dAckOgKkHWGHrThIGtGsSxqSVMRYzmi5QO/rw6cLZelnyHP4gX4boDlo4D
q1DBT5GGxuctg5PZ5lrol0UhbdzxCZJdx7QYo0tnuhO4U8a6clu2aGitOBsuviC1
y3uuWb5eiuoGGONg8EVT6oKNnvGd/8DivL2kj+AK4l2PKbCaQntjqAAHAWanh27D
PEbop3F9QLEhUbqi1SY2JAe/ADl9JUYgPdeV6QJmWdVSoowHZ3ROwfKGRtEvkh/B
MW7dObAxvX+cdUjWIm+6l6RXUt2OXmmnwZ9c0lPwAyABe+hsV1n7KLkjuhJmNyxu
If87C7LNyRcPsyzcF9R0YABVs2Kd5DNS2DmqJ2Uk8AJwJTMRE+A=
=wqkD
-----END PGP SIGNATURE-----

--pdmjyivbae3y7sox--
