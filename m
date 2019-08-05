From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH] i2c: avoid sleep in IRQ context
Date: Mon,  5 Aug 2019 20:31:34 +0800
Message-ID: <20190805123134.23199-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>
List-Id: linux-i2c@vger.kernel.org

i2c_pxa_handler -> i2c_pxa_irq_txempty ->
i2c_pxa_reset -> i2c_pxa_set_slave -> i2c_pxa_wait_slave

As i2c_pxa_handler is an interrupt handler, it will finally
calls i2c_pxa_wait_slave which calls msleep.

Add in_interrupt check before msleep to avoid sleep
in IRQ context.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/i2c/busses/i2c-pxa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 2c3c3d6935c0..b35a0e8efcb2 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -443,6 +443,8 @@ static int i2c_pxa_wait_slave(struct pxa_i2c *i2c)
 
 	show_state(i2c);
 
+	if (in_interrupt())
+		return 0;
 	while (time_before(jiffies, timeout)) {
 		if (i2c_debug > 1)
 			dev_dbg(&i2c->adap.dev, "%s: %ld: ISR=%08x, ICR=%08x, IBMR=%02x\n",
-- 
2.11.0
