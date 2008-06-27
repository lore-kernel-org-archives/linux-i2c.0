From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] Fix bad hint about irqs in i2c.h
Date: Fri, 27 Jun 2008 15:23:32 +0200
Message-ID: <20080627130922.8265.12081.stgit@octopus.labnet.pengutronix.de>
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

i2c.h mentions -1 as a not-issued irq. This false hint was taken by of_i2c and
caused crashes. Don't give any advice as 'no irq' is not consistent across all
architectures yet and it is not needed internally by the i2c-core.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---

The crash was caused because of_i2c set .irq to -1 and later used that value
for dispose_mapping. Using 0xffffffff here instead of the original NO_IRQ
caused the crash. Patch for of_i2c will go via linux-ppcdev later, if it is
accepted here that the -1 is not required by the i2c-core and NO_IRQ is
equally sufficent.

 include/linux/i2c.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index fb9af6a..8dc7301 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -171,7 +171,7 @@ struct i2c_client {
 	struct i2c_adapter *adapter;	/* the adapter we sit on	*/
 	struct i2c_driver *driver;	/* and our access routines	*/
 	struct device dev;		/* the device structure		*/
-	int irq;			/* irq issued by device (or -1) */
+	int irq;			/* irq issued by device		*/
 	struct list_head list;		/* DEPRECATED */
 	struct completion released;
 };


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
