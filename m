From: Jan Glauber <jglauber@cavium.com>
Subject: [RFC PATCH 7/8] i2c-octeon: Faster operation when IFLG signals late
Date: Thu, 18 Feb 2016 09:22:29 +0100
Message-ID: <9a33135d05d6b084754fb1953e2351a9c69c537f.1455782324.git.jglauber@cavium.com>
References: <cover.1455782324.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455782324.git.jglauber@cavium.com>
In-Reply-To: <cover.1455782324.git.jglauber@cavium.com>
References: <cover.1455782324.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Swain <pswain@cavium.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

From: Peter Swain <pswain@cavium.com>

Some versions can deliver low-level twsi irq before twsi_ctl.iflg
is set, leading to timeout-driven i/o.
When an irq signals event, but woken task does not see the expected
twsi_ctl.iflg, re-check about 80uS later.

EEPROM reads on 100kHz i2c now measure ~5.2kB/s, about 1/2 what's
achievable, and much better than the worst-case 100 bytes/sec before.

Signed-off-by: Peter Swain <pswain@cavium.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
Acked-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/i2c/busses/i2c-octeon.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index bb15a9c..e3552e5 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -130,6 +130,14 @@ static int timeout = 2;
 module_param(timeout, int, 0444);
 MODULE_PARM_DESC(timeout, "Low-level device timeout (ms)");
 
+/*
+ * On some hardware IFLG is not visible in TWSI_CTL until after low-level IRQ,
+ * so re-sample CTL a short time later to avoid stalls.
+ */
+static int irq_early_us = 80;
+module_param(irq_early_us, int, 0644);
+MODULE_PARM_DESC(irq_early_us, "Re-poll for IFLG after IRQ (us)");
+
 static void writeqflush(u64 val, void __iomem *addr)
 {
 	__raw_writeq(val, addr);
@@ -343,6 +351,26 @@ static int octeon_i2c_test_iflg(struct octeon_i2c *i2c)
 	return (octeon_i2c_read_ctl(i2c) & TWSI_CTL_IFLG) != 0;
 }
 
+/*
+ * Wait-helper which addresses the delayed-IFLAG problem by re-polling for
+ * missing TWSI_CTL[IFLG] a few us later, when irq has signalled an event,
+ * but none found. Skip this re-poll on the first (non-wakeup) call.
+ */
+static int poll_iflg(struct octeon_i2c *i2c, int *first_p)
+{
+	int iflg = octeon_i2c_test_iflg(i2c);
+
+	if (iflg)
+		return 1;
+	if (*first_p)
+		*first_p = 0;
+	else {
+		usleep_range(irq_early_us, 2 * irq_early_us);
+		iflg = octeon_i2c_test_iflg(i2c);
+	}
+	return iflg;
+}
+
 /**
  * octeon_i2c_wait - wait for the IFLG to be set
  * @i2c: The struct octeon_i2c
@@ -351,10 +379,11 @@ static int octeon_i2c_test_iflg(struct octeon_i2c *i2c)
  */
 static int octeon_i2c_wait(struct octeon_i2c *i2c)
 {
+	int first = 1;
 	long result;
 
 	i2c->int_en(i2c);
-	result = wait_event_timeout(i2c->queue, octeon_i2c_test_iflg(i2c),
+	result = wait_event_timeout(i2c->queue, poll_iflg(i2c, &first),
 				    i2c->adap.timeout);
 	i2c->int_dis(i2c);
 	if (!result) {
-- 
1.9.1
