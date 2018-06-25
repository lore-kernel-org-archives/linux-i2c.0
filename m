From: Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH 2/3] i2c:ocores: do not handle IRQ if IF is not set
Date: Mon, 25 Jun 2018 18:13:02 +0200
Message-ID: <20180625161303.7991-3-federico.vaga@cern.ch>
References: <20180625161303.7991-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625161303.7991-1-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>
Cc: federico.vaga@cern.ch
List-Id: linux-i2c@vger.kernel.org

If the Interrupt Flag (IF) is not set, we should not handle the IRQ:
- the line can be shared with other devices
- it can be a spurious interrupt

To avoid reading twice the status register, the ocores_process() function
expects it to be read by the caller.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 98c0ef74882b..274d6eb22a2c 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -139,10 +139,9 @@ static inline u8 oc_getreg(struct ocores_i2c *i2c, int reg)
 	return i2c->getreg(i2c, reg);
 }
 
-static void ocores_process(struct ocores_i2c *i2c)
+static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 {
 	struct i2c_msg *msg = i2c->msg;
-	u8 stat = oc_getreg(i2c, OCI2C_STATUS);
 
 	if ((i2c->state == STATE_DONE) || (i2c->state == STATE_ERROR)) {
 		/* stop has been sent */
@@ -209,9 +208,13 @@ static void ocores_process(struct ocores_i2c *i2c)
 static irqreturn_t ocores_isr(int irq, void *dev_id)
 {
 	struct ocores_i2c *i2c = dev_id;
+	u8 stat = oc_getreg(i2c, OCI2C_STATUS);
 	unsigned long flags;
 	int ret;
 
+	if (!(stat & OCI2C_STAT_IF))
+		return IRQ_NONE;
+
 	/*
 	 * We need to protect i2c against a timeout event (see ocores_xfer())
 	 * If we cannot take this lock, it means that we are already in
@@ -222,7 +225,7 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
 	if (!ret)
 		return IRQ_HANDLED;
 
-	ocores_process(i2c);
+	ocores_process(i2c, stat);
 
 	spin_unlock_irqrestore(&i2c->xfer_lock, flags);
 
-- 
2.15.0
