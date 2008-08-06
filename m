From: Carlos Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>
Subject: [PATCH 5/6] I2C: MENELAUS: Code clean-up for menelaus
Date: Wed, 06 Aug 2008 14:01:07 -0400
Message-ID: <4899E6E3.2000804@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>

This patch removes a few errors and warnings reported by checkpatch.pl.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>
---
 include/linux/i2c/menelaus.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/i2c/menelaus.h b/include/linux/i2c/menelaus.h
index 1660418..9587398 100644
--- a/include/linux/i2c/menelaus.h
+++ b/include/linux/i2c/menelaus.h
@@ -1,5 +1,5 @@
 /*
- * linux/include/asm-arm/arch-omap/menelaus.h
+ * include/linux/i2c/menelaus.h
  *
  * Functions to access Menelaus power management chip
  */
@@ -122,10 +122,11 @@
 struct device;
 
 struct menelaus_platform_data {
-	int (* late_init)(struct device *dev);
+	int (*late_init)(struct device *dev);
 };
 
-extern int menelaus_register_mmc_callback(void (*callback)(void *data, u8 card_mask),
+extern int menelaus_register_mmc_callback(void (*callback)(void *data,
+					  u8 card_mask),
 					  void *data);
 extern void menelaus_unregister_mmc_callback(void);
 extern int menelaus_set_mmc_opendrain(int slot, int enable);
-- 1.5.5.1


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
