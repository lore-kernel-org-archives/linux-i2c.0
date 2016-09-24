From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] i2c: octeon: thunderx: Limit register access
 retries
Date: Sat, 24 Sep 2016 11:24:36 +0200
Message-ID: <20160924092436.GH1434@katana>
References: <cover.1474565039.git.jglauber@cavium.com>
 <1140690b8b727cd09afb9c5867983815f33a08c7.1474565039.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dx9iWuMxHO1cCoFc"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58936 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761916AbcIXJYk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 24 Sep 2016 05:24:40 -0400
Content-Disposition: inline
In-Reply-To: <1140690b8b727cd09afb9c5867983815f33a08c7.1474565039.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Dmitry Bazhenov <dmitry.bazhenov@auriga.com>


--Dx9iWuMxHO1cCoFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 11:40:39AM +0200, Jan Glauber wrote:
> Do not infinitely retry register readq and writeq operations
> in order to not lock up the CPU in case the TWSI gets stuck.
>=20
> Return -ETIMEDOUT in case of a failed data read. For all other
> cases just return so subsequent operations will fail
> and trigger the recovery.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Deleted the last 4 words from commit message (previous recovery patch
needs more discussion) and applied to for-next, thanks!


--Dx9iWuMxHO1cCoFc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5kZUAAoJEBQN5MwUoCm2S8gP+wSjTr/EooW9Rh9XY20XT8+a
J9NgBQH8RTxy737gPq68w3xzGOHPzdgKobc5YsGhjBn30gK1Boismth1M8q4brlT
odHRodJpYWo47a5/26cuCFRt09eWKLGN2eofRxiB/dAoqzxrx1ZWB9yUJYUxkFFY
K4cpbCakub43DzeCFdkqgeLIOAB2ZH4n/07SGojPY6EoaA8MMaoc4eQHrwgikVD/
GD7CKa5EuEtP8pbnDdNDm5ne5TDvHI+huSy4Bh2ru4IFmyKKexQTaH4DfJWKEd4z
c5yg3epbm5qVf3+9EPyAnroXzx6Iml6fentckPJo4CWo4zLS+XPo/N8TCrBkqeUz
UQkWu7IXZQfYcRw7sLbYT4d1+mvPzLpBr5hrPe0k9jrH0g3E9u8WGP17dPZv5B8A
ZCIyKKTdAh/ZwrtJTaLOiluWiOK1precKDdSLqE5c1OXqAuS4ay7qGYa75679CLn
JGpe1EJy7KoapilDRPj1r4i8QQUL7IlQ4tnDiAz1F1RaGDcoHjjIvZ2jHJDm6uyM
WfbRB1ikl4aDMsTV2o22gaMTvo7aiOrqoOqOhXaDG/kPSGdSNT5YmiT5IABQQxIJ
JaVD0jat0RMIpfOcR4fOY3n8WgFSXXPrQzFcXPU//WVDJB5Uv64Uj2xLkGQv9WAa
f9o0JCGTGOBxz89bt7QC
=JYZR
-----END PGP SIGNATURE-----

--Dx9iWuMxHO1cCoFc--
