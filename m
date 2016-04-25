From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 04/15] i2c: octeon: Add flush writeq helper function
Date: Mon, 25 Apr 2016 23:33:56 +0200
Message-ID: <20160425213356.GD1550@katana>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-5-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47113 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964906AbcDYVeB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Apr 2016 17:34:01 -0400
Content-Disposition: inline
In-Reply-To: <1461594824-7215-5-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Peter Swain <pswain@cavium.com>


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2016 at 04:33:33PM +0200, Jan Glauber wrote:
> From: Peter Swain <pswain@cavium.com>
>=20
> Add helper function that reads back a value after writing to
> make sure the write is finished and use it in octeon_i2c_write_int().
>=20
> Signed-off-by: Peter Swain <pswain@cavium.com>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next, thanks!


--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHo1EAAoJEBQN5MwUoCm2aR0QAKihb/G1tHmDMwQhmCU6CgCF
CXOMzMWQ4/UKtDEgpjxOuJGx6b0xKTPwyyusIEuGT436DupPnndlq4pGfPm+N4Ji
R+Zf2k2VcWrzqKdB5p+Seos9RuAXlzYCOrxBDTue4ZnXpDGlUmRTdkDhjta124io
WJLk0E/ECPGzBIHP+aL3QcHj9XqYVUakF9kM3/Hkxt1qpKpRfHOJ9neK5+V87w1L
ud8ynw/vLfXLIXjkeHb5WWsXPggEZtMYRlBoHwdCCbLZzdbZTnbiq/oiVtK5F+xE
f2KXLJjbP5nw7XDP8e7B62o6Hv4Ce09M+cENGau9exC5eYYm4P8UDpGb+04S5kJp
8s45FFOW+BEwllB13mOPIvI0ZYPhTxhFgOHqQsOQ47k+GqiMzcjJ1wJiolMlliNR
MbY0milVeSp3kRo4Jo110lRchvxaOsQhj18e/FreC7htTXbsmergX1cjyp5gCkly
o0GeZxvuP38mjvWMLySjVTslh4ynhLllJBauO18dLgkMlx2YflBhag6J/zwIG0I2
S8Ok7zr3lMVxNCC23/gdgN7Aat7og2/HB14o13RpJRFxTSeqEucbAamjioUR1FQu
hAnk6bbP6qOcWtN1mVpxgY8T2+udZ3P+Ub1XYKhoWmOkiP42tTZRnLwyrwdddNJo
Fzbox12kgKFN4oWKfd5y
=QjhO
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--
