From: Matt Weber <matthew.weber@rockwellcollins.com>
Subject: [PATCH v2 1/1] i2c: cadance: (bugfix) ctrl/addr reg write order
Date: Thu, 22 Jun 2017 15:00:33 -0500
Message-ID: <1498161633-12736-1-git-send-email-matthew.weber@rockwellcollins.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtpimr.rockwellcollins.com ([205.175.227.27]:33246 "EHLO
        da1vs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753362AbdFVUKJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 22 Jun 2017 16:10:09 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, soren.brinkmann@xilinx.com, Matt Weber <matthew.weber@rockwellcollins.com>, John Linn <john.linn@xilinx.com>, Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>

The driver was clearing the hold bit in the control register before
writing to the address register which resulted in a stop condition
being generated rather than a repeated start.

This issue was only observed when a system was running much
slower than a normal processor would execute.  The IP data sheet
mentions a ordering of writing to the address register before
clearing the hold.

Fixes: df8eb5691c4 ("i2c: Add driver for Cadence I2C controller")

Signed-off-by: John Linn <john.linn@xilinx.com>
Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Signed-off-by: Matthew Weber <matthew.weber@rockwellcollins.com>
---

Changes
v1 -> v2
 - Added fixes tag (Suggested by W. Sang)
---
 drivers/i2c/busses/i2c-cadence.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 45d6771..75d8016 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -405,14 +405,14 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
 		cdns_i2c_writereg(id->recv_count, CDNS_I2C_XFER_SIZE_OFFSET);
 	}
 
+	/* Set the slave address in address register - triggers operation */
+	cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
+						CDNS_I2C_ADDR_OFFSET);
 	/* Clear the bus hold flag if bytes to receive is less than FIFO size */
 	if (!id->bus_hold_flag &&
 		((id->p_msg->flags & I2C_M_RECV_LEN) != I2C_M_RECV_LEN) &&
 		(id->recv_count <= CDNS_I2C_FIFO_DEPTH))
 			cdns_i2c_clear_bus_hold(id);
-	/* Set the slave address in address register - triggers operation */
-	cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
-						CDNS_I2C_ADDR_OFFSET);
 	cdns_i2c_writereg(CDNS_I2C_ENABLED_INTR_MASK, CDNS_I2C_IER_OFFSET);
 }
 
-- 
1.9.1
