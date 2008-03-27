From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 6/7] Blackfin I2C/TWI driver: Just let i2c-bfin-twi
	driver depends on BLACKFIN
Date: Wed, 26 Mar 2008 17:46:48 -0700
Message-ID: <1206578809-16038-7-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <>
References: <>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

simply use "depends on BLACKFIN" (which is technically correct) and just document
which machines have the device

Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/Kconfig |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 5fa9c3c..8891e22 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -100,10 +100,13 @@ config I2C_AU1550
 
 config I2C_BLACKFIN_TWI
 	tristate "Blackfin TWI I2C support"
-	depends on BF534 || BF536 || BF537
+	depends on BLACKFIN
 	help
-	  This is the TWI I2C device driver for Blackfin 534/536/537/54x.
-	  This driver can also be built as a module.  If so, the module
+	  This is the TWI I2C device driver for Blackfin BF522, BF525,
+	  BF527, BF534, BF536, BF537 and BF54x. For other Blackfin processors,
+	  please don't use this driver.
+
+	  This driver can also be built as a module. If so, the module
 	  will be called i2c-bfin-twi.
 
 config I2C_BLACKFIN_TWI_CLK_KHZ
-- 
1.5.4.3

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
