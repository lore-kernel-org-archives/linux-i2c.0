From: <Eugen.Hristev@microchip.com>
Subject: [PATCH 2/3] i2c: at91: fix clk_offset for sama5d2
Date: Mon, 2 Dec 2019 08:56:38 +0000
Message-ID: <1575276957-5615-2-git-send-email-eugen.hristev@microchip.com>
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

In SAM9X60 datasheet, FLEX_TWI_CWGR register rescription mentions clock
offset of 3 cycles (compared to 4 in eg. SAMA5D3).
This is the same offset as in SAMA5D2.

Fixes: b00277923743 ("i2c: at91: add new platform support for sam9x60")
Suggested-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/i2c/busses/i2c-at91-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at=
91-core.c
index e13af48..5137e62 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -174,7 +174,7 @@ static struct at91_twi_pdata sama5d2_config =3D {
=20
 static struct at91_twi_pdata sam9x60_config =3D {
 	.clk_max_div =3D 7,
-	.clk_offset =3D 4,
+	.clk_offset =3D 3,
 	.has_unre_flag =3D true,
 	.has_alt_cmd =3D true,
 	.has_hold_field =3D true,
--=20
2.7.4
