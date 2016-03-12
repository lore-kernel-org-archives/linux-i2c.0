From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 04/14] i2c-octeon: Support I2C_M_RECV_LEN
Date: Sat, 12 Mar 2016 16:44:22 +0100
Message-ID: <20160312154422.GG1661@katana>
References: <cover.1457362545.git.jglauber@cavium.com>
 <aa1595b6fd6b16fbc0339115b2169acb6458dd38.1457362545.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5L6AZ1aJH5mDrqCQ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50400 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694AbcCLPo0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 12 Mar 2016 10:44:26 -0500
Content-Disposition: inline
In-Reply-To: <aa1595b6fd6b16fbc0339115b2169acb6458dd38.1457362545.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, David Daney <david.daney@cavium.com>


--5L6AZ1aJH5mDrqCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 04:10:47PM +0100, Jan Glauber wrote:
> From: David Daney <david.daney@cavium.com>
>=20
> If I2C_M_RECV_LEN is set consider the length byte.
>=20
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

You also might want to set "| I2C_FUNC_SMBUS_READ_BLOCK_DATA |
I2C_FUNC_SMBUS_BLOCK_PROC_CALL" in your functionality?

> +		if (recv_len && i =3D=3D 0) {
> +			if (data[i] > I2C_SMBUS_BLOCK_MAX + 1) {
> +				dev_err(i2c->dev,
> +					"%s: read len > I2C_SMBUS_BLOCK_MAX %d\n",
> +					__func__, data[i]);
> +				return -EIO;

According to Documentation/i2c/fault-codes this should be -EPROTO.


--5L6AZ1aJH5mDrqCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW5DlWAAoJEBQN5MwUoCm2mgMP+gI4Z1QBaCFapkZNn0E+5WrI
Pi1jEwWLTjUmzbokUNwlrat0E7J8M15BDWHnyxrcpRj9LSX/5Mm/05M33uEAhYIn
1x5JzlTFtvUhKeQb6O9VDzdmxEA36Fd9p/XB1gQw0Gv3ZMXDnwUil1LyBeaFCeMX
FcFRZRS3T3VTndOTz5SaD5xPNvB40otl9rggZS5cq1EmeHwhXAcjfeDNxbuJPdyV
OQ+lMHlvEkI98ubbKIARbAbXfmN3PyAsYE8w1L0fEt2GdF7RnA2UoluUV8b0RfYp
t5Expq658Dq3eOgFX6QNGLebgCPwwnYsM4oR7Rgoq5Ib5F+gIVdW/NAStJ4MHoQv
j30jMQ8gPAjG8eudswoU5+A8qCWZEdbrngYZEvxHNMwSoVqv4Fo0BcgY7s5sRDAQ
sEyK1QMc+rtWAGqN4Hn5Ie/GHQx6Di633bVQKanrzj35RkpfHD4tRxDdsmuor0sS
hHYetNcXZ1b/8XWAkFCnq3QxOq/whGAPN2XmRIGU+ymEsEpEzQn2CvAwhffvTJdF
YdAHE6AgCQvdLlPjf6zSn2TXk656C+dih71Wz/yF0+37QpVXtaim5wQCTKSEStdx
JxlL673AGRq+a6iFcuOo7owjvmMdHuw9ql1ABaKFHoiVenKG+iEV5u1wGBpocUkT
D5H9q9wXn8M3LCxkimel
=uB+4
-----END PGP SIGNATURE-----

--5L6AZ1aJH5mDrqCQ--
