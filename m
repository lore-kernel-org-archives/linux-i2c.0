From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: cadence: try reset when master receive arbitration
 lost
Date: Mon, 18 Feb 2019 18:06:06 +0100
Message-ID: <20190218170606.qt35ciis4zpqo7d2@katana>
References: <20190218094132.5226-1-sxauwsk@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="55tyi4ztso44igmw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190218094132.5226-1-sxauwsk@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shikai Wang <sxauwsk@163.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--55tyi4ztso44igmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 05:41:32PM +0800, Shikai Wang wrote:
> When the adapter receive arbitration lost error interrupts,
> cdns_i2c_master_xfer return to the caller directly instead of resetting
> the adapter which resulted in the adapter being out of control.
>=20
> So when driver detect err_status such as arbitration lost,
> then try to repair and fix it.

Thanks for working on this issue.

> Signed-off-by: Shikai Wang <sxauwsk@163.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Reading the previous thread, isn't this more of an acked-by or
reviewed-by than a Signed-off?

Also, is there a suitable Fixes tag?


--55tyi4ztso44igmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxq5fgACgkQFA3kzBSg
KbZszRAAljXV2RneaUpe4jL8KnONqVWgRXYtj/MG7rxBhl6B2jg5TH1HqH0MRZIO
hhTB21+VhdzjEyg9/Dai52L1BbndZKkTGTeL/jjIBI740iC4Nn6+3qerN3UmNkYR
tHKCw1LLmDj0gph9Gez9PXZwBYBJAdnCugvbE88iNiJ1E8TrVxGV4mGkdXjGJDqV
gYOV3cvlQoznHiq3iaoSrF05iCMJCvoPuHAWPoRGXNk2wuHkWr+H2RK7jBzZE4GQ
Q+JJQe0AgXIgE5ivAkTanKcmu/6vZpEnUKu2Q1jS2fESt1nd00tgT0zhi3Mr1oB2
EhjAxdq46q74gKAJGm0GgHnhzwjBTBi5rHuglxR/Z5yCdHc7WgM7bASsKKpVmcQt
vBO0geyHGL5rsyIgKIBzQXpJeB0fCdpUEO/CNmQqTRJEbHM2Ra8X/BRYWFwof1Ae
9G1LnECNAQOoXVV3bmq+CpzXCJZOQVh+LnMb1sBiltKLSdMVgIx35Q7fL5hiJF/I
FjEEH4MUjvjwocer9fLOArAUWggPdKKSbcQAOE9jKi1BBIzwIEdL39eM/Mq2Ih96
bR2C72CHEqSAsbCNcxNrYSCy54pL9tW/QZJb/DousDgbpJGwPbZJWXUr12bfml9G
+s+/LU37XtbG262QCd0CKbSb8Nz4gbzz0ZQWQ2Dh+jVUi7EJ1Ns=
=WSqx
-----END PGP SIGNATURE-----

--55tyi4ztso44igmw--
