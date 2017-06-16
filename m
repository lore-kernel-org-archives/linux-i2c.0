From: Stefan Roese <sr@denx.de>
Subject: [PATCH] i2c: ocores: Add missing wake_up() call upon state change to STATE_DONE
Date: Fri, 16 Jun 2017 11:23:17 +0200
Message-ID: <20170616092317.584-1-sr@denx.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:55458 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753272AbdFPJX3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 16 Jun 2017 05:23:29 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

I've noticed that this driver adds a timeout pause of 1 second after
each xfer. This is due to the wait_event_timeout() call in ocores_xfer()
using a "HZ" timeout value and a missing call to wake_up() in
ocores_process() called by the interrupt handler when the state changes
to STATE_DONE at the end of the frame.

This patch adds the missing call resulting in the removal of this 1
second timeout delay after each xfer.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-ocores.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 34f1889a4073..5f8395ea0106 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -191,6 +191,7 @@ static void ocores_process(struct ocores_i2c *i2c)
 		} else {
 			i2c->state = STATE_DONE;
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
+			wake_up(&i2c->wait);
 			return;
 		}
 	}
-- 
2.13.1
