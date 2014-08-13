From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 2/2] i2c: i2c-xiic: Remove .owner field for driver
Date: Wed, 13 Aug 2014 13:56:52 +0200
Message-ID: <4d4f18e78a5231681494e8caadc06a94246a0201.1407931005.git.michal.simek@xilinx.com>
References: <c076984af7e65c433fdfd3a3b0f8d20da2c18013.1407931005.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-19941-1407931015-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c076984af7e65c433fdfd3a3b0f8d20da2c18013.1407931005.git.michal.simek@xilinx.com>
In-Reply-To: <c076984af7e65c433fdfd3a3b0f8d20da2c18013.1407931005.git.michal.simek@xilinx.com>
References: <c076984af7e65c433fdfd3a3b0f8d20da2c18013.1407931005.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Wolfram Sang <wsa@the-dreams.de>, Jingoo Han <jg1.han@samsung.com>, Kedareswara rao Appana <appana.durga.rao@xilinx.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-19941-1407931015-0001

There is no need to init .owner field.

Based on the patch from Peter Griffin <peter.griffin@linaro.org>
"mmc: remove .owner field for drivers using module_platform_driver"

This patch removes the superflous .owner field for drivers which
use the module_platform_driver API, as this is overriden in
platform_driver_register anyway."

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/i2c/busses/i2c-xiic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index ade9223912d3..e60e67a5fac6 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -771,7 +771,6 @@ static struct platform_driver xiic_i2c_driver = {
 	.probe   = xiic_i2c_probe,
 	.remove  = xiic_i2c_remove,
 	.driver  = {
-		.owner = THIS_MODULE,
 		.name = DRIVER_NAME,
 		.of_match_table = of_match_ptr(xiic_of_match),
 	},
--
1.8.2.3


--=_mimegpg-monstr-desktop-19941-1407931015-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlPrUocACgkQykllyylKDCEYvwCfUTnEInHkQ3xFITUYgwhfAJSB
lL4AnRXDd25e8t8D2wjhkfssrgI/63Uk
=Bd2e
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-19941-1407931015-0001--
