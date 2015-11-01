From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] i2c: imx: Remove unneeded comments
Date: Sun,  1 Nov 2015 14:22:52 -0200
Message-ID: <1446394972-19463-2-git-send-email-festevam@gmail.com>
References: <1446394972-19463-1-git-send-email-festevam@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33335 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbbKAQXK (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 1 Nov 2015 11:23:10 -0500
Received: by qgeo38 with SMTP id o38so100115162qge.0
        for <linux-i2c@vger.kernel.org>; Sun, 01 Nov 2015 08:23:09 -0800 (PST)
In-Reply-To: <1446394972-19463-1-git-send-email-festevam@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

These multi-lines comments do not follow the standard kernel coding
style. In fact, they are not useful comments, so get rid of them.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/i2c/busses/i2c-imx.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 1e522c3..696c920 100644
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
@@ -54,9 +51,6 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 
-/** Defines ********************************************************************
-*******************************************************************************/
-
 /* This will be the driver name the kernel reports */
 #define DRIVER_NAME "imx-i2c"
 
@@ -118,9 +112,6 @@
 #define I2CR_IEN_OPCODE_0	0x0
 #define I2CR_IEN_OPCODE_1	I2CR_IEN
 
-/** Variables ******************************************************************
-*******************************************************************************/
-
 /*
  * sorted list of clock divider, register value pairs
  * taken from table 26-5, p.26-9, Freescale i.MX
@@ -409,9 +400,6 @@ static void i2c_imx_dma_free(struct imx_i2c_struct *i2c_imx)
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
