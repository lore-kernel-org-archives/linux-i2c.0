From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH v2] i2c: imx: Remove unneeded comments
Date: Mon, 4 Jan 2016 09:15:37 -0200
Message-ID: <1451906137-5594-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0089.outbound.protection.outlook.com ([207.46.100.89]:8766
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751455AbcADMuj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Jan 2016 07:50:39 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

These multi-lines comments do not follow the standard kernel coding
style. In fact, they are not useful comments, so get rid of them.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Rebased against latest tree

 drivers/i2c/busses/i2c-imx.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index dcea8d2..8b68dbf 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -29,9 +29,6 @@
  *
  */
 
-/** Includes *******************************************************************
-*******************************************************************************/
-
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -57,9 +54,6 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 
-/** Defines ********************************************************************
-*******************************************************************************/
-
 /* This will be the driver name the kernel reports */
 #define DRIVER_NAME "imx-i2c"
 
@@ -123,9 +117,6 @@
 
 #define I2C_PM_TIMEOUT		10 /* ms */
 
-/** Variables ******************************************************************
-*******************************************************************************/
-
 /*
  * sorted list of clock divider, register value pairs
  * taken from table 26-5, p.26-9, Freescale i.MX
@@ -419,9 +410,6 @@ static void i2c_imx_dma_free(struct imx_i2c_struct *i2c_imx)
 	dma->chan_using = NULL;
 }
 
-/** Functions for IMX I2C adapter driver ***************************************
-*******************************************************************************/
-
 static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 {
 	unsigned long orig_jiffies = jiffies;
-- 
1.9.1
