From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: add driver for Sigma Designs SMP8642 I2C master
Date: Sun, 1 Nov 2015 07:42:29 +0100
Message-ID: <20151101064228.GA2010@katana>
References: <1446312957-18744-1-git-send-email-mans@mansr.com>
 <1446312957-18744-2-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43919 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbbKAGml (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 1 Nov 2015 01:42:41 -0500
Content-Disposition: inline
In-Reply-To: <1446312957-18744-2-git-send-email-mans@mansr.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2015 at 05:35:57PM +0000, Mans Rullgard wrote:
> This adds a driver for the Sigma Designs SMP8642 built-in I2C master
> controller.  The hardware is very similar to the I2C controller in the
> Ralink RT3050 chip with the addition of interrupt generation and an
> inverted busy/idle status bit.  There are typically two controllers with
> a shared IRQ.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Thanks for the driver. Same answer as here, though:

http://www.spinics.net/lists/linux-i2c/msg17001.html

> +#define TANGOX_I2C_CONFIG		0x00
> +#define TANGOX_I2C_CLKDIV		0x04
> +#define TANGOX_I2C_DEVADDR		0x08
> +#define TANGOX_I2C_ADDR			0x0c
> +#define TANGOX_I2C_DATAOUT		0x10
> +#define TANGOX_I2C_DATAIN		0x14
> +#define TANGOX_I2C_STATUS		0x18
> +#define TANGOX_I2C_STARTXFER		0x1c
> +#define TANGOX_I2C_BYTECNT		0x20
> +#define TANGOX_I2C_INT_EN		0x24
> +#define TANGOX_I2C_INT_STAT		0x28

The register set looks like the one from i2c-xlr.c, only that they are
32 bit apart instead of 8. Can you check if you can reuse that driver?

Thanks,

   Wolfram


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWNbRUAAoJEBQN5MwUoCm22LQP/0G8c9gE5D9qLRFm0bukiUBu
j59p3o1vsUFE8f1toRp7xIDTeBPHKdRKf19bYC5WglH5tpooumZF9SWxTToHKDZ8
d4d5tq0n7nls7v4UXIklsHjjd7nLjvq/cvpHWcAY/4Xnqo8ZMwOebALxC46VSl3R
NTZB3lqFh6pvg5ryP/3Gwv+xJXZ3nMyxP/5aMr9EVfoeLJ62ye5YjVKMwVr86g2u
tGzjw6bvJg1h3qegO/Ak/8/j2Tf6Jw8nP3gCSBL9tESRqcsMTApsLhJ4YUApvIzz
nWHHySuph4LuQ7miAG5ByQlARlJVDkDhAh6eMbthWnXgw3lV6UPQKsvB915n6c5+
p6wWbSSV07B9DTJQEyFjdLx6NyGtL33xaBBfBGKp+02kcTO78oIOlQyK5jR69xO7
aG9eNi616IfIMN6ltmOdIcV2i79JOfx3X6r5FGA+IQCUmu7/HEyCRVjXqf4bgd/M
Zea45JQwvk1Ykgq3BI6wsopkDuHyTTC3cGlyXww84bpSJfqgPzx7lYnh3Vpirf9t
VVfJ3C464xZe1YX81gqDrOtnIBai0BlIzgk933+YdYxWGZCfUR5U1YsQWmzlpxjy
UE+fGBQK6/MWbXoPKwr56dcXZM31rbS5SU48VLOMnBpYqa8i1doJ4IRFZ/U0xj+2
FabQZyG/MWO7rJKcr1qd
=P5KV
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
