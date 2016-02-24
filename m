From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] i2c-piix4: Always use the same type for port
Date: Wed, 24 Feb 2016 11:40:33 +0100
Message-ID: <20160224104033.GH1391@katana>
References: <20160129104146.50f06562@endymion.delvare>
 <20160129104530.1ba78e8b@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46504 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbcBXKkl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 24 Feb 2016 05:40:41 -0500
Content-Disposition: inline
In-Reply-To: <20160129104530.1ba78e8b@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Christian Fetzer <fetzer.ch@gmail.com>


--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 29, 2016 at 10:45:30AM +0100, Jean Delvare wrote:
> Sometimes u8 is used to store the port number, sometimes unsigned
> short is used. Consistently stick to a single type, for consistency
> and to avoid implicit casts.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Christian Fetzer <fetzer.ch@gmail.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWzYihAAoJEBQN5MwUoCm2jIsQAIOjNw6+FQV5aomfDPVMHd8Z
cHVGAWwvDxDkOkqYXyx2JkAuJRZNnRVzIb/7F57MKtCmv4jao6mJIBuer0bPhaOu
Jyx617hO4lmY/pAZSgFXOIOAC5KByyl9sjpkspAYFj6ZkCa049u3wlnRDcYyBpuy
yxTAJFfOgPKXWYs8CpYWb8qOsfIrCWElLv0d9fPBSb9GKp2S/4x5BOG6GsGuVzv0
Q3Hylmu/h0JTvIktEnEflQ1GNn1j2PNPJOLAYSrRNrwt4wsxU1IzsdWFWLgo3Uk3
i1F0544W8vQnD3XRvT6K4Q7hI45NF2hQrsWcauBEZOdKB3ueHNoJtlCyLnjp3JfX
mzhoheKnR47JMZJJX0QmGbyycYhl1G0Qu5XI841Sg7r2tBMx+6GVb1uZaD8kT6sz
KgE7fSlS8GfSDEtu/8Brue5lNeNpSc5gRMQcJL40a2BMUXIEodoOfOTCHtCBTnLb
k0UwitdvHgEMJHvS0XAo2wMD6gGF5HiyziocY6KM0NuLwV3C4Sas0FPkxV2DgzVk
b0hlTRlDa0NceZIsk3uucBgn5ZzMzilHntl1gC7zVwpY4gKhSVgeuTUcunEfx1nP
PEPvt4xkXoW/rYH/wGe3nfTAmxqDIjPWjGOfIg6uClu4FSsJKLIB/eaiymc2M1QN
NYYJTdDYUOUCW8Xb/GJb
=25NT
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--
