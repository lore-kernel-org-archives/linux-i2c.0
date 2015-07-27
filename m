From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH 5/8] i2c: img-scb: reset interrupts in img_i2c_soft_reset
Date: Mon, 27 Jul 2015 12:47:18 +0100
Message-ID: <1437997641-32575-6-git-send-email-sifan.naeem@imgtec.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, James Hogan <james.hogan@imgtec.com>, linux-i2c@vger.kernel.org
Cc: Sifan Naeem <sifan.naeem@imgtec.com>, "Stable kernel (v3.19+)" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Reset interrupt enable register and clear any generated interrupts
to make sure of a clean slate after a soft reset. Not doing so might
leave unhandle line status or generated interrupts which can cause
issues when handling new transfers.

Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB driver")
Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
Cc: Stable kernel (v3.19+) <stable@vger.kernel.org>
---
 drivers/i2c/busses/i2c-img-scb.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 51a5be8..653f9bd 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -507,8 +507,22 @@ static void img_i2c_soft_reset(struct img_i2c *i2c)
 {
 	i2c->t_halt = false;
 	img_i2c_writel(i2c, SCB_CONTROL_REG, 0);
+
+	/* Disable all interrupts */
+	img_i2c_writel(i2c, SCB_INT_MASK_REG, 0);
+
+	/* Clear all interrupts */
+	img_i2c_writel(i2c, SCB_INT_CLEAR_REG, ~0);
+
+	/* Clear the scb_line_status events */
+	img_i2c_writel(i2c, SCB_CLEAR_REG, ~0);
+
 	img_i2c_writel(i2c, SCB_CONTROL_REG,
 		       SCB_CONTROL_CLK_ENABLE | SCB_CONTROL_SOFT_RESET);
+
+	/* Enable interrupts */
+	img_i2c_switch_mode(i2c, MODE_INACTIVE);
+	img_i2c_writel(i2c, SCB_INT_MASK_REG, i2c->int_enable);
 }
 
 /* enable or release transaction halt for control of repeated starts */
@@ -1242,18 +1256,6 @@ static int img_i2c_init(struct img_i2c *i2c)
 	/* Take module out of soft reset and enable clocks */
 	img_i2c_soft_reset(i2c);
 
-	/* Disable all interrupts */
-	img_i2c_writel(i2c, SCB_INT_MASK_REG, 0);
-
-	/* Clear all interrupts */
-	img_i2c_writel(i2c, SCB_INT_CLEAR_REG, ~0);
-
-	/* Clear the scb_line_status events */
-	img_i2c_writel(i2c, SCB_CLEAR_REG, ~0);
-
-	/* Enable interrupts */
-	img_i2c_writel(i2c, SCB_INT_MASK_REG, i2c->int_enable);
-
 	/* Perform a synchronous sequence to reset the bus */
 	ret = img_i2c_reset_bus(i2c);
 
-- 
1.7.9.5
