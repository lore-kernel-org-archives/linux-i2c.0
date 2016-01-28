From: Ray Jui <rjui@broadcom.com>
Subject: [PATCH 1/3] i2c: iproc: Add recovery mechanism in error case
Date: Wed, 27 Jan 2016 16:27:20 -0800
Message-ID: <1453940842-9658-2-git-send-email-rjui@broadcom.com>
References: <1453940842-9658-1-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:15196 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934437AbcA1A1a (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 27 Jan 2016 19:27:30 -0500
In-Reply-To: <1453940842-9658-1-git-send-email-rjui@broadcom.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Icarus Chau <ichau@broadcom.com>, Ray Jui <rjui@broadcom.com>

Add proper recovery mechanism to the iProc I2C driver in error cases

Signed-off-by: Icarus Chau <ichau@broadcom.com>
Signed-off-by: Ray Jui <rjui@broadcom.com>
Tested-by: Icarus Chau <ichau@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 0419f52..99261cc 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -102,6 +102,10 @@ struct bcm_iproc_i2c_dev {
  */
 #define ISR_MASK (1 << IS_M_START_BUSY_SHIFT)
 
+static int bcm_iproc_i2c_init(struct bcm_iproc_i2c_dev *iproc_i2c);
+static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
+					 bool enable);
+
 static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
 {
 	struct bcm_iproc_i2c_dev *iproc_i2c = data;
@@ -149,6 +153,12 @@ static int bcm_iproc_i2c_check_status(struct bcm_iproc_i2c_dev *iproc_i2c,
 
 	default:
 		dev_dbg(iproc_i2c->device, "unknown error code=%d\n", val);
+
+		/* re-initialize i2c for recovery */
+		bcm_iproc_i2c_enable_disable(iproc_i2c, false);
+		bcm_iproc_i2c_init(iproc_i2c);
+		bcm_iproc_i2c_enable_disable(iproc_i2c, true);
+
 		return -EIO;
 	}
 }
-- 
1.9.1
