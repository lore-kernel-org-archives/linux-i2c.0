From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH 6/8] i2c: img-scb: remove start bit detected status after handling
Date: Mon, 27 Jul 2015 12:47:19 +0100
Message-ID: <1437997641-32575-7-git-send-email-sifan.naeem@imgtec.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, James Hogan <james.hogan@imgtec.com>, linux-i2c@vger.kernel.org
Cc: Sifan Naeem <sifan.naeem@imgtec.com>, "Stable kernel (v3.19+)" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Remove start bit detected status after it is handled,
doing so will prevent this condition being hit for
every interrupt on a particular transfer.

Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB driver")
Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
Cc: Stable kernel (v3.19+) <stable@vger.kernel.org>
---
 drivers/i2c/busses/i2c-img-scb.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 653f9bd..341130e 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -871,10 +871,18 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 	}
 
 	/* Enable transaction halt on start bit */
-	if (!i2c->last_msg && i2c->line_status & LINESTAT_START_BIT_DET) {
-		img_i2c_transaction_halt(i2c, true);
-		/* we're no longer interested in the slave event */
-		i2c->int_enable &= ~INT_SLAVE_EVENT;
+	if (i2c->line_status & LINESTAT_START_BIT_DET) {
+		if (!i2c->last_msg) {
+			img_i2c_transaction_halt(i2c, true);
+			/* we're no longer interested in the slave event */
+			i2c->int_enable &= ~INT_SLAVE_EVENT;
+		}
+		/*
+		 * Remove start bit detected status after it is handled,
+		 * doing so will prevent this condition being hit for
+		 * every interrupt on a particular transfer.
+		 */
+		i2c->line_status &= ~LINESTAT_START_BIT_DET;
 	}
 
 	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
-- 
1.7.9.5
