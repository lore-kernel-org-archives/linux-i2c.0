From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] i2c-piix4: Pre-shift the port number
Date: Wed, 24 Feb 2016 11:42:01 +0100
Message-ID: <20160224104200.GI1391@katana>
References: <20160129104146.50f06562@endymion.delvare>
 <20160129104637.582b95ea@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gJNQRAHI5jiYqw2y"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46516 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755367AbcBXKmE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 24 Feb 2016 05:42:04 -0500
Content-Disposition: inline
In-Reply-To: <20160129104637.582b95ea@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Christian Fetzer <fetzer.ch@gmail.com>


--gJNQRAHI5jiYqw2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 29, 2016 at 10:46:37AM +0100, Jean Delvare wrote:
> Shift the port number at initialization time, so that it is ready to
> use at run time. That way we don't have to do it again for every SMBus
> transaction.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Christian Fetzer <fetzer.ch@gmail.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--gJNQRAHI5jiYqw2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWzYj4AAoJEBQN5MwUoCm28KwP/RBRb4ipFffd/fTY/UDG+Pdz
RkRrLBrsNcsJRh3dRHLwtQwTXTSq4+pDMSgdZpxJhLlfZ0ofMuNRQUUJzik50dZP
FliTz7j5ZI0UImg0DRb3OIxob3kpTuPBnXYTX4XjE5uIQxfA1/MJPnWQTRfrd91q
dC9djAfa1iitui1nA9ThauEQNoSeq+PJA177pmSlX9MaXkRGb2IX/68im5wnwLuj
lBjmUPJudA9B6ctzM0EYtuml2dZoPiFCrleJS+ts8BXC+pCkaQkoYtHeLYea+Doc
HXe+RJo5c3/+Tc/7LTwu9iCnyxVZh9YnhqHaWHaFpGEOtLVQZpYC8g1sU4n3GiOk
3PdXcEeli+m4JzT9mx63vKAjE5QN0URAkXhveR4KnUBzSvT21pOCIyhK8oHSLv0L
YNHuzConVb4JeUDvtlTVw9Hyuaqy6RlduwuFedVkFPTlT0JAzaJHn3QiUXBhJC4y
0oL24zyS/SwBxFrcY5xtaQOGDiHvXw3OFg1oYsI3Z5jsYE8WWG06pR7sW6KLJfpr
QtOahhWpkHKkl4ghw0hCS20R+cU9/sw1dBDrPgTTcRpGOlxww3d20cp7Rw0Dqr6H
uISP8m3htu+97iuc3Ux61xMywvlGrw3jGmUnZtHoMzTEC5XJNFA139+FKHDP2Cv6
fd4sumlpB1+dHAZ3I5r3
=lqS4
-----END PGP SIGNATURE-----

--gJNQRAHI5jiYqw2y--
