From: <Eugen.Hristev@microchip.com>
Subject: [PATCH v3 4/9] i2c: at91: add new platform support for sam9x60
Date: Tue, 9 Jul 2019 13:19:39 +0000
Message-ID: <1562678049-17581-5-git-send-email-eugen.hristev@microchip.com>
References: <1562678049-17581-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562678049-17581-1-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, peda@axentia.se, mark.rutland@arm.com, Ludovic.Desroches@microchip.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, pierre-yves.mordret@st.com, alexandre.belloni@bootlin.com, robh+dt@kernel.org
Cc: Nicolas.Ferre@microchip.com, Eugen.Hristev@microchip.com
List-Id: linux-i2c@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Add new platform data support for the sam9x60 SoC

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/i2c/busses/i2c-at91-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at=
91-core.c
index 8d55cdd..a663a7a 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -148,6 +148,14 @@ static struct at91_twi_pdata sama5d2_config =3D {
 	.has_hold_field =3D true,
 };
=20
+static struct at91_twi_pdata sam9x60_config =3D {
+	.clk_max_div =3D 7,
+	.clk_offset =3D 4,
+	.has_unre_flag =3D true,
+	.has_alt_cmd =3D true,
+	.has_hold_field =3D true,
+};
+
 static const struct of_device_id atmel_twi_dt_ids[] =3D {
 	{
 		.compatible =3D "atmel,at91rm9200-i2c",
@@ -174,6 +182,9 @@ static const struct of_device_id atmel_twi_dt_ids[] =3D=
 {
 		.compatible =3D "atmel,sama5d2-i2c",
 		.data =3D &sama5d2_config,
 	}, {
+		.compatible =3D "microchip,sam9x60-i2c",
+		.data =3D &sam9x60_config,
+	}, {
 		/* sentinel */
 	}
 };
--=20
2.7.4
