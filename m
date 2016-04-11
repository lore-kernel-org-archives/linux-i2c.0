From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v6 04/19] i2c: octeon: Introduce helper functions for register access
Date: Mon, 11 Apr 2016 17:28:35 +0200
Message-ID: <5667768441feb526fbf1c3cd8768827393f9bfce.1460387640.git.jglauber@cavium.com>
References: <cover.1460387640.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36796 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002AbcDKP3F (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Apr 2016 11:29:05 -0400
In-Reply-To: <cover.1460387640.git.jglauber@cavium.com>
In-Reply-To: <cover.1460387640.git.jglauber@cavium.com>
References: <cover.1460387640.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

Add helper functions for control, data and status register access.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 56 +++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 43498a4..b25c491 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -97,6 +97,11 @@ static void octeon_i2c_reg_write(struct octeon_i2c *i2c, u64 eop_reg, u8 data)
 	} while ((tmp & SW_TWSI_V) != 0);
 }
 
+#define octeon_i2c_ctl_write(i2c, val)					\
+	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_CTL, val)
+#define octeon_i2c_data_write(i2c, val)					\
+	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_DATA, val)
+
 /**
  * octeon_i2c_reg_read - read lower bits of an I2C core register
  * @i2c: The struct octeon_i2c
@@ -118,6 +123,13 @@ static u8 octeon_i2c_reg_read(struct octeon_i2c *i2c, u64 eop_reg)
 	return tmp & 0xFF;
 }
 
+#define octeon_i2c_ctl_read(i2c)					\
+	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_CTL)
+#define octeon_i2c_data_read(i2c)					\
+	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_DATA)
+#define octeon_i2c_stat_read(i2c)					\
+	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_STAT)
+
 /**
  * octeon_i2c_write_int - write the TWSI_INT register
  * @i2c: The struct octeon_i2c
@@ -189,7 +201,7 @@ static irqreturn_t octeon_i2c_isr(int irq, void *dev_id)
 
 static int octeon_i2c_test_iflg(struct octeon_i2c *i2c)
 {
-	return (octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_CTL) & TWSI_CTL_IFLG) != 0;
+	return (octeon_i2c_ctl_read(i2c) & TWSI_CTL_IFLG) != 0;
 }
 
 /**
@@ -262,14 +274,14 @@ static int octeon_i2c_init_lowlevel(struct octeon_i2c *i2c)
 	int tries;
 
 	/* disable high level controller, enable bus access */
-	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
+	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
 
 	/* reset controller */
 	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_RST, 0);
 
 	for (tries = 10; tries; tries--) {
 		udelay(1);
-		status = octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_STAT);
+		status = octeon_i2c_stat_read(i2c);
 		if (status == STAT_IDLE)
 			return 0;
 	}
@@ -288,27 +300,25 @@ static int octeon_i2c_start(struct octeon_i2c *i2c)
 	int result;
 	u8 data;
 
-	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_CTL,
-			    TWSI_CTL_ENAB | TWSI_CTL_STA);
+	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB | TWSI_CTL_STA);
 
 	result = octeon_i2c_wait(i2c);
 	if (result) {
-		if (octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_STAT) == STAT_IDLE) {
+		if (octeon_i2c_stat_read(i2c) == STAT_IDLE) {
 			/*
 			 * Controller refused to send start flag May
 			 * be a client is holding SDA low - let's try
 			 * to free it.
 			 */
 			octeon_i2c_unblock(i2c);
-			octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_CTL,
-					    TWSI_CTL_ENAB | TWSI_CTL_STA);
+			octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB | TWSI_CTL_STA);
 			result = octeon_i2c_wait(i2c);
 		}
 		if (result)
 			return result;
 	}
 
-	data = octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_STAT);
+	data = octeon_i2c_stat_read(i2c);
 	if ((data != STAT_START) && (data != STAT_RSTART)) {
 		dev_err(i2c->dev, "%s: bad status (0x%x)\n", __func__, data);
 		return -EIO;
@@ -320,8 +330,7 @@ static int octeon_i2c_start(struct octeon_i2c *i2c)
 /* send STOP to the bus */
 static void octeon_i2c_stop(struct octeon_i2c *i2c)
 {
-	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_CTL,
-			    TWSI_CTL_ENAB | TWSI_CTL_STP);
+	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB | TWSI_CTL_STP);
 }
 
 /**
@@ -345,15 +354,15 @@ static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
 	if (result)
 		return result;
 
-	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_DATA, target << 1);
-	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
+	octeon_i2c_data_write(i2c, target << 1);
+	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
 
 	result = octeon_i2c_wait(i2c);
 	if (result)
 		return result;
 
 	for (i = 0; i < length; i++) {
-		tmp = octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_STAT);
+		tmp = octeon_i2c_stat_read(i2c);
 
 		if ((tmp != STAT_TXADDR_ACK) && (tmp != STAT_TXDATA_ACK)) {
 			dev_err(i2c->dev,
@@ -362,8 +371,8 @@ static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
 			return -EIO;
 		}
 
-		octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_DATA, data[i]);
-		octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
+		octeon_i2c_data_write(i2c, data[i]);
+		octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
 
 		result = octeon_i2c_wait(i2c);
 		if (result)
@@ -398,16 +407,15 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 	if (result)
 		return result;
 
-	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_DATA, (target << 1) | 1);
-	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
+	octeon_i2c_data_write(i2c, (target << 1) | 1);
+	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
 
 	result = octeon_i2c_wait(i2c);
 	if (result)
 		return result;
 
 	for (i = 0; i < length; i++) {
-		tmp = octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_STAT);
-
+		tmp = octeon_i2c_stat_read(i2c);
 		if ((tmp != STAT_RXDATA_ACK) && (tmp != STAT_RXADDR_ACK)) {
 			dev_err(i2c->dev,
 				"%s: bad status before read (0x%x)\n",
@@ -416,17 +424,15 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 		}
 
 		if (i + 1 < length)
-			octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_CTL,
-					    TWSI_CTL_ENAB | TWSI_CTL_AAK);
+			octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB | TWSI_CTL_AAK);
 		else
-			octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_CTL,
-					    TWSI_CTL_ENAB);
+			octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
 
 		result = octeon_i2c_wait(i2c);
 		if (result)
 			return result;
 
-		data[i] = octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_DATA);
+		data[i] = octeon_i2c_data_read(i2c);
 		if (recv_len && i == 0) {
 			if (data[i] > I2C_SMBUS_BLOCK_MAX + 1) {
 				dev_err(i2c->dev,
-- 
1.9.1
