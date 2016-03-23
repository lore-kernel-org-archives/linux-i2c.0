From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 02/14] i2c-octeon: Cleanup resource allocation code
Date: Wed, 23 Mar 2016 20:52:23 +0100
Message-ID: <20160323195223.GC19849@katana>
References: <cover.1458289385.git.jglauber@cavium.com>
 <600b5514b8456f507867633d27f4ade95cecbd35.1458289385.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48050 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756615AbcCWTw1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Mar 2016 15:52:27 -0400
Content-Disposition: inline
In-Reply-To: <600b5514b8456f507867633d27f4ade95cecbd35.1458289385.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2016 at 09:46:27AM +0100, Jan Glauber wrote:
> Remove resource values from struct i2c_octeon and use
> devm_ioremap_resource helper.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Like patch 1, this is already upstream.


--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW8vP3AAoJEBQN5MwUoCm2kqIP/3zs7YWw1d+N1CA2TOOkVWW7
aslFvExNnNzZO9Dmv57lnua38danFv23XTg6CNVvk4V3ZKkanPxdBWcm7AksDk0k
KV+DGKQ/RtssnoKA6skPfKrtja4+bppgQS+PTmNvYhYGwMjPyVi8yczEmXZxsOk2
TzLpMzJh4uGJQN6cLaS2Nbwu5kGpvWu/ay5dx7EyUqL02Q9XekEdhRLI5Kts5Mdv
WQPbWOr9kivH8OF48sEqit26YuTP1krQucCaPHSNTXE8a1SvW9Ms96u1dKwKs3ko
FyavfqGFAsLnWoKUMbHvfpeze2M0v+b2TLw17B0mZgvw6erSH4r/VM3LhfpUCnfh
WNUM/TmKTMLM50zxOIQUzdXWPXsNFJCE5SI3Ap4wDk44dA54Ayiyiq/a4nngbMfX
w89szKOkFbjeIx5D3kTEFh4HdKsPxWC4wQ95UT263mYyPGT9O3/FaNUgET1L7Kcb
4BvFY39AOxCxvTOxk17YNnvp3fSx0qjbI6feIQNk0JMPIeQbC8qTpXDPVn2+6h1r
v4iWctFcP035qsyoJ/1TMhLhpJwgx+e7WEiGyMrR2HlwciIDHQLFCNNQgMpp4m75
iYzcd8BVZK9nBG9mZrVrvyQVhK4fU8WpST4uulCqcybZdekTnvliRbyJHEGV5m+i
zN0ckH6DKyhlDpGU5k2O
=q74y
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
