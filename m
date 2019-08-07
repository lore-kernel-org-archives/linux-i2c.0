From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2] i2c: avoid sleep in IRQ context
Date: Wed,  7 Aug 2019 15:18:07 +0800
Message-ID: <20190807071807.17488-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>
List-Id: linux-i2c@vger.kernel.org

i2c_pxa_handler -> i2c_pxa_irq_txempty ->
i2c_pxa_reset -> i2c_pxa_set_slave -> i2c_pxa_wait_slave

As i2c_pxa_handler is an interrupt handler, it will finally
calls i2c_pxa_wait_slave which calls msleep.

Add in_interrupt check before msleep to avoid sleep
in IRQ context.
When in interrupt context, use mdelay instead of msleep.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/i2c/busses/i2c-pxa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 2c3c3d6935c0..876e693bafd9 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -456,7 +456,10 @@ static int i2c_pxa_wait_slave(struct pxa_i2c *i2c)
 			return 1;
 		}
 
-		msleep(1);
+		if (in_interrupt())
+			mdelay(1);
+		else
+			msleep(1);
 	}
 
 	if (i2c_debug > 0)
-- 
2.11.0
