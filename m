From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC] drivers/clk/Kconfig: Change COMMON_CLK to tristate
Date: Wed, 17 Jun 2015 21:05:35 +0200
Message-ID: <20150617190534.GB28251@katana>
References: <1434567707-9352-1-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434567707-9352-1-git-send-email-yorksun@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: York Sun <yorksun@freescale.com>
Cc: mturquette@baylibre.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Paul Bolle <pebolle@tiscali.nl>
List-Id: linux-i2c@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2015 at 12:01:47PM -0700, York Sun wrote:
> COMMON_CLK has been a bool value, selected by the platforms who need
> common clock framework. If a CCF driver is needed on an add-on device
> such as PCIe card, COMMON_CLK can be selected individually as a
> tristate value.
>=20
> Signed-off-by: York Sun <yorksun@freescale.com>
> CC: Paul Bolle <pebolle@tiscali.nl>
> CC: Mike Turquette <mturquette@baylibre.com>

Why do you CC the I2C list for clk patches??


--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgcT+AAoJEBQN5MwUoCm2K90QAJrkz3ObET2e3JBFNx4cDWyn
F84imuQUqCPtqBxpPGWtZDU0Y2hpcdIgOFl72OVJkmMbOdYuh7gP0QrDn7dHhd7a
ZLU5VSeURK8Kt1tPwkEMH3hAfVg9pMZjhBU4D9mSh43GAkSQgLb2zyTJ9r+XX03z
tLfqo16jU8gI+pNvtjqH/uAv8DBrBHaQqYiDcIUoOLIMzxKJujEdVItDlIsS4cT1
Hy8ys4RwUQZZ3o8z50pHZBDzOrRn/UJLcbTjRWeo+LIZat/C/jTagWL3ShqAekS9
6/1cwBQT16Cqorog/qpipVW4ldB8ygMEHBqJJoa5pMNfTXX9jBKU0sVmS8hi2c+c
vo+SVfz6kAo9xzp0ZS7K22HwB4pGfKFwRZsrKjPKfvJg5S/5KH2TDzomcFyyAdDQ
/yl6qANW8rlKMkxl1u87y6ftnY/1aWnM7t6zFq4zkaGC7qGlidYgkD0AuSXS+JvW
cyPZeawcH9b7HdthZcILOWKqDzT8aAjZi4gi7jpgb/yJ4iCNTJB98jHqHDpqOBqv
HBjBn0CxmFVtv3wLo1Raq7g6w/lgARvuQp26F9QvVQ3xeNFNQD2dNlJQY7d1ee38
egXONUS3RLXLn4Y5r4jmdL49UYnG2sPbElBMGZ43RuzaEsVGoD4mGu6ev2U90SHT
Zc//ZrvIZe1e7llieBnL
=VaBf
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
