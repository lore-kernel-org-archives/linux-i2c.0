From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 1/2] i2c: aspeed: added driver for Aspeed I2C
Date: Sun, 11 Dec 2016 23:26:22 +0100
Message-ID: <20161211222622.GK2552@katana>
References: <1480467618-7497-1-git-send-email-brendanhiggins@google.com>
 <1480467618-7497-2-git-send-email-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mZBmBd1ZkdwT1ny"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:39714 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753896AbcLKW0Z (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 11 Dec 2016 17:26:25 -0500
Content-Disposition: inline
In-Reply-To: <1480467618-7497-2-git-send-email-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: vz@mleia.com, clg@kaod.org, mouse@mayc.ru, robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, joel@jms.id.au, openbmc@lists.ozlabs.org


--5mZBmBd1ZkdwT1ny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2016 at 05:00:17PM -0800, Brendan Higgins wrote:
> Added initial master and slave support for Aspeed I2C controller.
> Supports fourteen busses present in ast24xx and ast25xx BMC SoCs by
> Aspeed.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

BTW first the bindings patch please, then the driver.

And one seperate question I just stumbled over:

> +	/* Switch from master mode to slave mode. */
> +	func_ctrl_reg_val =3D aspeed_i2c_read(bus, ASPEED_I2C_FUN_CTRL_REG);
> +	func_ctrl_reg_val &=3D ~ASPEED_I2CD_MASTER_EN;
> +	func_ctrl_reg_val |=3D ASPEED_I2CD_SLAVE_EN;
> +	aspeed_i2c_write(bus, func_ctrl_reg_val, ASPEED_I2C_FUN_CTRL_REG);

Can't the hardware work both as master and slave on the same bus?

Regards,

   Wolfram


--5mZBmBd1ZkdwT1ny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYTdKOAAoJEBQN5MwUoCm2vxgP/0Gnbf5Ja3LHi7pwd67PYfmA
nMxNGHtRwi/zdW6Mfk45fIhTXFV+7rz6UH36/XlNjE0C7vEBQxXVf1Wg6r66l8Yl
gz9n7sl0HThldTvkyZqmMFZiyG+jjOYU2/GHqgpon8D2i/zagKYiG+f3ygMtlVEI
6u1Wu0tvSzTmbSRNaJskR6bU+rKiJELopAzxsa05kceQPOqnSKjpcdcT1T8i896C
67felp6ALKf0oECZ2IXr9rKlqFB+qErmqHYlSwhQLgF0uGJvENNgDXI+FQ4+Sex2
WihGydD0epjJVeOq1/3YfawjOYIKTmiR93rOdSGWXElamhK3agW9XMMyDF3QiJqq
mzVNVKP2/4Vy0ITHaNVFDv5mMON2J/9j1qXu2IIMYHn1ALHhHsULS7l4WHoGB2AW
XZWflaZVh7K1ZaFyOLAV36ajOCNWO7mU8Ow8xFfLnGqPVkZA/RXqLyIO31Tbhh9Z
PliBgX0tHtI3vsx2/GcP17+3NuxFc1q5al5P72I8rxRXuElxa2wQ/Sznh4ZnLK60
l6XnqSAYvTZ42JJY8+mC7ycHvu3m3ys378dTB+uWoVUyi/V910HBY+K9viGPzd8c
jUGIbIFghdRUaA/NliXyZfpq9y4ke1u0BryZYPBth5GElM1Denw2DtZnSkLbDo3B
FyIkHK/1FWj2ZpFzk5Eb
=Vm0m
-----END PGP SIGNATURE-----

--5mZBmBd1ZkdwT1ny--
