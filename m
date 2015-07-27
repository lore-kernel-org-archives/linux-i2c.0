From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH 7/8] i2c: img-scb: improve transaction complete handle
Date: Mon, 27 Jul 2015 12:47:20 +0100
Message-ID: <1437997641-32575-8-git-send-email-sifan.naeem@imgtec.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, James Hogan <james.hogan@imgtec.com>, linux-i2c@vger.kernel.org
Cc: Sifan Naeem <sifan.naeem@imgtec.com>, "Stable kernel (v3.19+)" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Clear line status and all interrupts when transaction is complete,
as not doing so might leave unserviced interrupts that might be
handled in the context of a new transfer. Soft reset if the the
transfer failed to bring back the i2c block to a reset state.

Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB driver")
Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
Cc: Stable kernel (v3.19+) <stable@vger.kernel.org>
---
 drivers/i2c/busses/i2c-img-scb.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 341130e..bbfee33 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -626,7 +626,10 @@ static void img_i2c_complete_transaction(struct img_i2c *i2c, int status)
 	img_i2c_switch_mode(i2c, MODE_INACTIVE);
 	if (status) {
 		i2c->msg_status = status;
-		img_i2c_transaction_halt(i2c, false);
+		img_i2c_soft_reset(i2c);
+	} else {
+		img_i2c_writel(i2c, SCB_INT_CLEAR_REG, ~0);
+		img_i2c_writel(i2c, SCB_CLEAR_REG, ~0);
 	}
 	complete(&i2c->msg_complete);
 }
-- 
1.7.9.5
