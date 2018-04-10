From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] MAINTAINERS: I'll maintain Renesas R-Car I2C host drivers
Date: Tue, 10 Apr 2018 16:13:47 +0200
Message-ID: <20180410141347.5014-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f7ccdcf76f7..3bb87e65889c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11897,6 +11897,12 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	drivers/iio/adc/rcar_gyro_adc.c
 
+RENESAS R-CAR I2C DRIVERS
+M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
+S:	Supported
+F:	drivers/i2c/busses/i2c-rcar.c
+F:	drivers/i2c/busses/i2c-sh_mobile.c
+
 RENESAS USB PHY DRIVER
 M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 L:	linux-renesas-soc@vger.kernel.org
-- 
2.11.0
