From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] i2c-ibm_iic: Enable driver for all PPC4xx variants in
	arch/powerpc
Date: Thu,  5 Jun 2008 10:10:53 +0200
Message-ID: <1212653453-26093-1-git-send-email-sr@denx.de>
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
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch enables the IBM I2C driver for all PPC4xx variants by adding
"ibm,iic" to the compatible list. This way all currently available
arch/powerpc 4xx ports can make use of this driver without any changes.
Additionally all "other" compatible entries are removed since they are
not needed anymore.

Currently all 4xx PPC's have the same compatible I2C macro. If at some
time an incompatibility is detected we can take care of this with an
additional property.

Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
---
 drivers/i2c/busses/i2c-ibm_iic.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 3a364a7..ed73801 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -807,11 +807,7 @@ static int __devexit iic_remove(struct of_device *ofdev)
 }
 
 static const struct of_device_id ibm_iic_match[] = {
-	{ .compatible = "ibm,iic-405ex", },
-	{ .compatible = "ibm,iic-405gp", },
-	{ .compatible = "ibm,iic-440gp", },
-	{ .compatible = "ibm,iic-440gpx", },
-	{ .compatible = "ibm,iic-440grx", },
+	{ .compatible = "ibm,iic", },
 	{}
 };
 
-- 
1.5.5.3


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
