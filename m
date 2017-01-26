From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH i2c/for-next] i2c: sh_mobile: document support for
 r8a7796 (R-Car M3-W)
Date: Thu, 26 Jan 2017 11:17:06 +0100
Message-ID: <20170126101706.GD1435@katana>
References: <1485420451-11752-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:39848 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753420AbdAZKRN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Jan 2017 05:17:13 -0500
Content-Disposition: inline
In-Reply-To: <1485420451-11752-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 09:47:31AM +0100, Simon Horman wrote:
> Explicitly list per-SoC binding for r8a7796. No driver change
> is required as the initialisation sequence is currently the same
> as for the R-Car Gen3 fallback binding.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYicyiAAoJEBQN5MwUoCm2ZqYP/AlhSXe8Na8LZ6/H54DyDAws
/iQjiCD85M0BEZ7BC+fdPKN9N/VYI3eQt9RkdVNvfYSMRuPIPzMKkFCws1SrqQCV
TlSlsZtlz32zzeCW4PDSdbDv2Bvz8tXoD5O2a55UHHDBWi7AXp7QB6EMF7XwEAtk
hMdTh34E+8l26m4eJUTBGCbYRIQaIHDxG5Ib8yYlDnzQe8PLCRdi1NjtMzmD3Yad
CbBMKQeVqUmEOK2V8GwxZb8+lL4uX1KwrMX9Akbvih0P1RJXDAwsL6NyNZhs3dIk
j7gsGVLWhdQ8Db4q+0SpjBwYXySzPFFuZDedkv0pN8qf6SUXrbOgnp7rcwP4pW3g
jSCYdzkH1pJ3zgPlKpE45xbgKgAGiihwW2gJdw/BkeByXqmRYb7Mam6Wo/sogMw5
uoKzyIzrccQJB0g8wyCOypbXaV54ZwH9pGuCnSGC0z2e/IHZ2aiOa+qm5/zz1SjF
+vlvx8WFHYcV8waWxL/vNaHa42C77n+qb/J2HIhvmrf/tvxQSX1QyGRdaeWtO7V+
JGl7C5xsCspLpNGuCuImblrVAo6EhmCVIHwg3ybmo57MWrpD/jatiWTfUE8QdR86
R1dvx6eRM26KwhgkumFe1spMuF0Ylee26whYZeLVnfHol6TPCUNqt+3xryOT+pJB
R94F4epNET68gz6mVJSV
=Fbuj
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
