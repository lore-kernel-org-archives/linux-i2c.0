From: Matt Weber <matthew.weber@rockwellcollins.com>
Subject: [PATCH 1/1] i2c: cadance: (bugfix) ctrl/addr reg write order
Date: Wed, 21 Jun 2017 20:45:26 -0500
Message-ID: <1498095926-51264-1-git-send-email-matthew.weber@rockwellcollins.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from secvs01.rockwellcollins.com ([205.175.225.240]:44605 "EHLO
        secvs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751113AbdFVBz6 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Jun 2017 21:55:58 -0400
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

Signed-off-by: John Linn <john.linn@xilinx.com>
Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Signed-off-by: Matthew Weber <matthew.weber@rockwellcollins.com>
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
