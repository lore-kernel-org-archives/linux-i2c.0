From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 137/237] i2c: uniphier-f: make driver robust against concurrency
Date: Sat, 16 Nov 2019 10:39:32 -0500
Message-ID: <20191116154113.7417-137-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit f1fdcbbdf45d9609f3d4063b67e9ea941ba3a58f ]

This is unlikely to happen, but it is possible for a CPU to enter
the interrupt handler just after wait_for_completion_timeout() has
expired. If this happens, the hardware is accessed from multiple
contexts concurrently.

Disable the IRQ after wait_for_completion_timeout(), and do nothing
from the handler when the IRQ is disabled.

Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-uniphier-f.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index bc26ec822e268..b9a0690b4fd73 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -98,6 +98,7 @@ struct uniphier_fi2c_priv {
 	unsigned int flags;
 	unsigned int busy_cnt;
 	unsigned int clk_cycle;
+	spinlock_t lock;	/* IRQ synchronization */
 };
 
 static void uniphier_fi2c_fill_txfifo(struct uniphier_fi2c_priv *priv,
@@ -162,7 +163,10 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 	struct uniphier_fi2c_priv *priv = dev_id;
 	u32 irq_status;
 
+	spin_lock(&priv->lock);
+
 	irq_status = readl(priv->membase + UNIPHIER_FI2C_INT);
+	irq_status &= priv->enabled_irqs;
 
 	dev_dbg(&priv->adap.dev,
 		"interrupt: enabled_irqs=%04x, irq_status=%04x\n",
@@ -230,6 +234,8 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 		goto handled;
 	}
 
+	spin_unlock(&priv->lock);
+
 	return IRQ_NONE;
 
 data_done:
@@ -246,6 +252,8 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 handled:
 	uniphier_fi2c_clear_irqs(priv);
 
+	spin_unlock(&priv->lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -311,7 +319,7 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
 {
 	struct uniphier_fi2c_priv *priv = i2c_get_adapdata(adap);
 	bool is_read = msg->flags & I2C_M_RD;
-	unsigned long time_left;
+	unsigned long time_left, flags;
 
 	dev_dbg(&adap->dev, "%s: addr=0x%02x, len=%d, stop=%d\n",
 		is_read ? "receive" : "transmit", msg->addr, msg->len, stop);
@@ -342,6 +350,12 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
 	       priv->membase + UNIPHIER_FI2C_CR);
 
 	time_left = wait_for_completion_timeout(&priv->comp, adap->timeout);
+
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->enabled_irqs = 0;
+	uniphier_fi2c_set_irqs(priv);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	if (!time_left) {
 		dev_err(&adap->dev, "transaction timeout.\n");
 		uniphier_fi2c_recover(priv);
@@ -546,6 +560,7 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
 
 	priv->clk_cycle = clk_rate / bus_speed;
 	init_completion(&priv->comp);
+	spin_lock_init(&priv->lock);
 	priv->adap.owner = THIS_MODULE;
 	priv->adap.algo = &uniphier_fi2c_algo;
 	priv->adap.dev.parent = dev;
-- 
2.20.1
