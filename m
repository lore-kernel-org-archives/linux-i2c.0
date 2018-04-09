From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/2] i2c: sprd: Fix the i2c count issue
Date: Mon,  9 Apr 2018 14:40:55 +0800
Message-ID: <e42cc3e001d612e811166b8d21f44802ff20069e.1523255712.git.baolin.wang@linaro.org>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
In-Reply-To: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: broonie@kernel.org, baolin.wang@linaro.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We found the I2C controller count register is unreliable sometimes,
that will cause I2C to lose data. Thus we can read the data count
from 'i2c_dev->count' instead of the I2C controller count register.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/i2c/busses/i2c-sprd.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 2fdad63..4053259 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -368,13 +368,12 @@ static irqreturn_t sprd_i2c_isr_thread(int irq, void *dev_id)
 	struct sprd_i2c *i2c_dev = dev_id;
 	struct i2c_msg *msg = i2c_dev->msg;
 	bool ack = !(readl(i2c_dev->base + I2C_STATUS) & I2C_RX_ACK);
-	u32 i2c_count = readl(i2c_dev->base + I2C_COUNT);
 	u32 i2c_tran;
 
 	if (msg->flags & I2C_M_RD)
 		i2c_tran = i2c_dev->count >= I2C_FIFO_FULL_THLD;
 	else
-		i2c_tran = i2c_count;
+		i2c_tran = i2c_dev->count;
 
 	/*
 	 * If we got one ACK from slave when writing data, and we did not
@@ -412,14 +411,13 @@ static irqreturn_t sprd_i2c_isr(int irq, void *dev_id)
 {
 	struct sprd_i2c *i2c_dev = dev_id;
 	struct i2c_msg *msg = i2c_dev->msg;
-	u32 i2c_count = readl(i2c_dev->base + I2C_COUNT);
 	bool ack = !(readl(i2c_dev->base + I2C_STATUS) & I2C_RX_ACK);
 	u32 i2c_tran;
 
 	if (msg->flags & I2C_M_RD)
 		i2c_tran = i2c_dev->count >= I2C_FIFO_FULL_THLD;
 	else
-		i2c_tran = i2c_count;
+		i2c_tran = i2c_dev->count;
 
 	/*
 	 * If we did not get one ACK from slave when writing data, then we
-- 
1.7.9.5
