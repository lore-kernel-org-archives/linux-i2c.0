From: =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>
Subject: [patch 3/5] xtensa: add at24hc02b to s6105 platform
Date: Mon, 23 Mar 2009 16:05:16 +0100
Message-ID: <1237820718-30607-3-git-send-email-dg@emlix.com>
References: <1237820718-30607-1-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758033AbZCWPEg@vger.kernel.org>
In-Reply-To: <1237820718-30607-1-git-send-email-dg@emlix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Zankel <chris@zankel.net>, Ben Dooks <ben-linux@fluff.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>
List-Id: linux-i2c@vger.kernel.org

This is particularly used to read the MAC address of the ethernet
controller from an EEPROM.

Signed-off-by: Daniel Gl=C3=B6ckner <dg@emlix.com>
---
 arch/xtensa/platforms/s6105/device.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/xtensa/platforms/s6105/device.c b/arch/xtensa/platfor=
ms/s6105/device.c
index 00f52ee..9394e6f 100644
--- a/arch/xtensa/platforms/s6105/device.c
+++ b/arch/xtensa/platforms/s6105/device.c
@@ -168,6 +168,9 @@ static struct resource s6_i2c_resource[] =3D {
 #define S6I2C_ADDR_PCA9543	0x73
=20
 static struct i2c_board_info __initdata s6_i2c_devices[] =3D {
+	{
+		I2C_BOARD_INFO("24c02", S6I2C_ADDR_AT24HC02B),
+	},
 };
=20
 static struct platform_device platform_devices[] =3D {
--=20
1.6.2.107.ge47ee
