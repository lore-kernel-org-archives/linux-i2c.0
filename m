From: =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Subject: [patch 2/5] xtensa: s6105 specific configuration for the s6000 i2c host
Date: Mon, 23 Mar 2009 16:05:15 +0100
Message-ID: <1237820718-30607-2-git-send-email-dg@emlix.com>
References: <1237820718-30607-1-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1237820718-30607-1-git-send-email-dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>, Oskar Schirmer <os-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Daniel Gl=C3=B6ckner <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Oskar Schirmer <os-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
---
 arch/xtensa/platforms/s6105/device.c |   51 ++++++++++++++++++++++++++=
++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/xtensa/platforms/s6105/device.c b/arch/xtensa/platfor=
ms/s6105/device.c
index 963634a..00f52ee 100644
--- a/arch/xtensa/platforms/s6105/device.c
+++ b/arch/xtensa/platforms/s6105/device.c
@@ -6,6 +6,8 @@
=20
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/i2c/s6000.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/phy.h>
@@ -21,6 +23,7 @@
 #define GPIO3_INTNUM		3
 #define UART_INTNUM		4
 #define GMAC_INTNUM		5
+#define I2C_INTNUM		6
=20
 static const signed char gpio3_irq_mappings[] =3D {
 	S6_INTC_GPIO(3),
@@ -41,10 +44,16 @@ static const signed char gmac_irq_mappings[] =3D {
 	-1
 };
=20
+static const signed char i2c_irq_mappings[] =3D {
+	S6_INTC_I2C,
+	-1
+};
+
 const signed char *platform_irq_mappings[NR_IRQS] =3D {
 	[GPIO3_INTNUM] =3D gpio3_irq_mappings,
 	[UART_INTNUM] =3D uart_irq_mappings,
 	[GMAC_INTNUM] =3D gmac_irq_mappings,
+	[I2C_INTNUM] =3D i2c_irq_mappings,
 };
=20
 static struct plat_serial8250_port serial_platform_data[] =3D {
@@ -129,6 +138,38 @@ fail:
 	return PHY_POLL;
 }
=20
+#define S6_I2C_BUS_NUM 0
+
+static __devinitdata struct s6_i2c_platform_data s6_i2c_pdata =3D {
+	.bus_num =3D S6_I2C_BUS_NUM,
+	.clock =3D "PCLK",
+};
+
+static struct resource s6_i2c_resource[] =3D {
+	{
+		.name   =3D "mem",
+		.start  =3D (resource_size_t)S6_REG_I2C,
+		.end    =3D (resource_size_t)S6_REG_I2C + 0x1000 - 1,
+		.flags  =3D IORESOURCE_MEM,
+	},
+	{
+		.name   =3D "irq",
+		.start  =3D (resource_size_t)I2C_INTNUM,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+};
+
+#define S6I2C_ADDR_TLV320AIC31	0x18
+#define S6I2C_ADDR_SAA7121	0x44
+#define S6I2C_ADDR_MT9D131	0x48
+#define S6I2C_ADDR_AT24HC02B	0x57
+#define S6I2C_ADDR_M41T62	0x68
+#define S6I2C_ADDR_CDCE906	0x69
+#define S6I2C_ADDR_PCA9543	0x73
+
+static struct i2c_board_info __initdata s6_i2c_devices[] =3D {
+};
+
 static struct platform_device platform_devices[] =3D {
 	{
 		.name =3D "serial8250",
@@ -143,12 +184,22 @@ static struct platform_device platform_devices[] =
=3D {
 		.resource =3D s6_gmac_resource,
 		.num_resources =3D ARRAY_SIZE(s6_gmac_resource),
 	},
+	{
+		.name =3D "i2c-s6000",
+		.resource =3D s6_i2c_resource,
+		.num_resources =3D ARRAY_SIZE(s6_i2c_resource),
+		.dev =3D {
+			.platform_data =3D &s6_i2c_pdata,
+		},
+	},
 };
=20
 static int __init device_init(void)
 {
 	int i;
=20
+	i2c_register_board_info(S6_I2C_BUS_NUM, s6_i2c_devices,
+				ARRAY_SIZE(s6_i2c_devices));
 	s6_gmac_resource[5].start =3D prepare_phy_irq(GPIO_PHY_IRQ);
=20
 	for (i =3D 0; i < ARRAY_SIZE(platform_devices); i++)
--=20
1.6.2.107.ge47ee
