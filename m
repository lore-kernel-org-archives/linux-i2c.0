From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH] I2C:SAMSUNG:Select I2C_S3C2410 if HAVE_S3C2410_I2C
Date: Thu, 24 Mar 2011 14:36:13 +0530
Message-ID: <1300957573-2622-1-git-send-email-tushar.behera@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: kgene.kim@samsung.com, ben-linux@fluff.org
List-Id: linux-i2c@vger.kernel.org

On Samsung Kconfig files, HAVE_S3C2410_I2C is selected if we want
to enable support for I2C. But the I2C controller is selected only
if I2C_S3C2410 is defined.

This patch selects I2C_S3C2410 when I2C and HAVE_S3C2410 are selected.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/i2c/busses/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 113505a..410846c 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -549,6 +549,7 @@ config HAVE_S3C2410_I2C
 config I2C_S3C2410
 	tristate "S3C2410 I2C Driver"
 	depends on HAVE_S3C2410_I2C
+	default y
 	help
 	  Say Y here to include support for I2C controller in the
 	  Samsung SoCs.
-- 
1.7.1
