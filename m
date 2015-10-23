From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-dev: Fix I2C_SLAVE ioctl comment
Date: Fri, 23 Oct 2015 23:26:11 +0200
Message-ID: <20151023212611.GL1520@katana>
References: <20150911112718.7f9effb2@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sCNd3Ivk/oijKKf1"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36989 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbbJWV0N (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 17:26:13 -0400
Content-Disposition: inline
In-Reply-To: <20150911112718.7f9effb2@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>


--sCNd3Ivk/oijKKf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2015 at 11:27:18AM +0200, Jean Delvare wrote:
> The first part of the comment is wrong since November 2007, delete it.
>=20
> The second part of the comment is related to I2C_PEC, not I2C_SLAVE, so
> move it where it belongs.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--sCNd3Ivk/oijKKf1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKqXzAAoJEBQN5MwUoCm2LNAP/2BZ96W6CbTs6r5jwI6Zw53L
wmS1KxcrOagf/r+QxeizQ7IQG8nGJ+k7RIVTd2Wv4uaZtfAnXP5bn7MPDCtWIyyQ
xy1YqMGyqqyUlTpgJ94j4AHFQcH4mVImmBNgXYNtZL8RgZjOPxIcl0d9ryxAltG3
+RaRxb+nLvjwz0jwUM2KOH5585v6DWQPW+e2MRn6qMC4MUQ9W2hLSnpLI+zbrPAs
eqQ9xrUQRJuCCDRPiQAL26LuPCZFPd+hKG04GgotYQhqsaXhTRzwfKlIgnnv/iiD
ND4GtbpKJ0BUp1qv7xTz42wT2f02xOx1lvf29qIQp2KY219EmeX76IyRS1+XqeIn
/BoAPh2Hzs21o4llDel9fif1MPNAtNzHDrWeDisl9C0/HLC8o4lrJFUctmLXLDum
Q1O2uxq7HbIw12+0XCU+WqtUN/0OrDbt6xrZos6eWsJm1bZNpgtsku0A1kEFxj91
Cff6Aoj2EJbTrWgaKegGjIkQWP519iRobN4fiz4n6c1LRkIwpvRvKOd08wHmGQs6
lNG2rLxpdrXlzd9i2Thm3JmBJS5OIxPFQpaX/GUWo1kbI5F5iQPMD3jUFcmWgraB
f5EQJ0Bc6x3aKilyaGJKTqQUGRJQIcK66oJf2U8dP+91NMDwlnAriqvghZucoNIH
LzA1bvwrpGnRaNs2o8nL
=TLjT
-----END PGP SIGNATURE-----

--sCNd3Ivk/oijKKf1--
