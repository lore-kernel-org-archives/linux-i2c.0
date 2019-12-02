From: <Eugen.Hristev@microchip.com>
Subject: [PATCH 3/3] i2c: at91: remote default value initialization
Date: Mon, 2 Dec 2019 08:56:41 +0000
Message-ID: <1575276957-5615-3-git-send-email-eugen.hristev@microchip.com>
References: <1575276957-5615-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1575276957-5615-1-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, Ludovic.Desroches@microchip.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, peda@axentia.se
Cc: Codrin.Ciubotariu@microchip.com, Nicolas.Ferre@microchip.com, Eugen.Hristev@microchip.com
List-Id: linux-i2c@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Platform data structs are initialized by default with zero values.
Thus it becomes redundant to initialize them manually to zero (false).
Remove extra false initialization for field members in structs.

Suggested-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/i2c/busses/i2c-at91-core.c | 39 ----------------------------------=
----
 1 file changed, 39 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at=
91-core.c
index 5137e62..3da1a8a 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -66,55 +66,26 @@ static struct at91_twi_pdata at91rm9200_config =3D {
 	.clk_max_div =3D 5,
 	.clk_offset =3D 3,
 	.has_unre_flag =3D true,
-	.has_alt_cmd =3D false,
-	.has_hold_field =3D false,
-	.has_dig_filtr =3D false,
-	.has_adv_dig_filtr =3D false,
-	.has_ana_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9261_config =3D {
 	.clk_max_div =3D 5,
 	.clk_offset =3D 4,
-	.has_unre_flag =3D false,
-	.has_alt_cmd =3D false,
-	.has_hold_field =3D false,
-	.has_dig_filtr =3D false,
-	.has_adv_dig_filtr =3D false,
-	.has_ana_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9260_config =3D {
 	.clk_max_div =3D 7,
 	.clk_offset =3D 4,
-	.has_unre_flag =3D false,
-	.has_alt_cmd =3D false,
-	.has_hold_field =3D false,
-	.has_dig_filtr =3D false,
-	.has_adv_dig_filtr =3D false,
-	.has_ana_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9g20_config =3D {
 	.clk_max_div =3D 7,
 	.clk_offset =3D 4,
-	.has_unre_flag =3D false,
-	.has_alt_cmd =3D false,
-	.has_hold_field =3D false,
-	.has_dig_filtr =3D false,
-	.has_adv_dig_filtr =3D false,
-	.has_ana_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9g10_config =3D {
 	.clk_max_div =3D 7,
 	.clk_offset =3D 4,
-	.has_unre_flag =3D false,
-	.has_alt_cmd =3D false,
-	.has_hold_field =3D false,
-	.has_dig_filtr =3D false,
-	.has_adv_dig_filtr =3D false,
-	.has_ana_filtr =3D false,
 };
=20
 static const struct platform_device_id at91_twi_devtypes[] =3D {
@@ -142,23 +113,13 @@ static const struct platform_device_id at91_twi_devty=
pes[] =3D {
 static struct at91_twi_pdata at91sam9x5_config =3D {
 	.clk_max_div =3D 7,
 	.clk_offset =3D 4,
-	.has_unre_flag =3D false,
-	.has_alt_cmd =3D false,
-	.has_hold_field =3D false,
-	.has_dig_filtr =3D false,
-	.has_adv_dig_filtr =3D false,
-	.has_ana_filtr =3D false,
 };
=20
 static struct at91_twi_pdata sama5d4_config =3D {
 	.clk_max_div =3D 7,
 	.clk_offset =3D 4,
-	.has_unre_flag =3D false,
-	.has_alt_cmd =3D false,
 	.has_hold_field =3D true,
 	.has_dig_filtr =3D true,
-	.has_adv_dig_filtr =3D false,
-	.has_ana_filtr =3D false,
 };
=20
 static struct at91_twi_pdata sama5d2_config =3D {
--=20
2.7.4
