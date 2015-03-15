From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: axxia: fixup return type of
 wait_for_completion_timeout
Date: Sun, 15 Mar 2015 11:02:04 +0100
Message-ID: <20150315100204.GC6770@katana>
References: <1423409808-9937-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423409808-9937-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Anders Berg <anders.berg@avagotech.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 08, 2015 at 10:36:48AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. The
> return variable is renamed to reflect its use and the type adjusted to
> unsigned long.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Fixed variable name to 'time_left' and applied to for-next, thanks!


--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBVicAAoJEBQN5MwUoCm2jM4QAKOtXj0F+faaeQ9TZfxSAWyr
TOXWBAQ8AZsTdI8lQp/Q+s/DDJjSEUDPf2NVjKx10Q4Yh31jojkZVcPUnBsJszs2
j6nu6xmaW2jgF9/f4gK1SgQWPLQXrcDTiA5MbzXtZEtTnLOmwNwiTZ32Gh7OsteJ
gls3DsEAHBTJ34E8i36xGJLjFWGeP6x6npcfp3aQpYDANAEqDn86pNLOM/qgPhwc
FR0N2tWpBLShhbgA0HqLCJETubFq7Ml7QtUzjmql5XqGv8gLcHhJ7ey0fKajwDQz
fSZIV3Rk8zUUiwX4NOnhtM5asxFgVwbGRPx21M4Zf0ZfSfNr29kZTP02f58HDJGe
yo2bCBs3g1AC6xC5zbwZs40M0J8kcLcZ1kHSFFZ610mXPvd9di1u1w9VUrGEPBU4
4lRGmmg4FVNErt7HGCvwIOHtnfwd5QHXzVm6bHdGWwe0fdx0t3OQJSdnq8aKi8ow
rw2UXSfaiA0n+Lm/Fj+btYqfUaeat7yo1WL7/mqsOGOmhsR0FeqgLf/cxpe79kEG
nd70jEvvG3ajCv6oEQ2XeZDHmZA3GyKnplds+lQQClDJXWBsmpBVTwgTeguSNyx2
n4E6N549fuqTArjt+0ahIMOiPO9hBnw9JS91BAkkus8nEor9ZtXTgZqcLVHcFwbC
j1OgkH1GrXi8/FNGiaLP
=rYpZ
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
