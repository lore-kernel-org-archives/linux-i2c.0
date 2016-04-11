From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v6 12/19] i2c: octeon: Faster operation when IFLG signals late
Date: Mon, 11 Apr 2016 17:28:43 +0200
Message-ID: <b52c3909da71f89078b6cee233379d533911b9ae.1460387640.git.jglauber@cavium.com>
References: <cover.1460387640.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1460387640.git.jglauber@cavium.com>
In-Reply-To: <cover.1460387640.git.jglauber@cavium.com>
References: <cover.1460387640.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Jan Glauber <jglauber@cavium.com>
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
 drivers/i2c/busses/i2c-octeon.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 8d54fc9..bad49cf 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -345,6 +345,28 @@ static int octeon_i2c_test_iflg(struct octeon_i2c *i2c)
 	return (octeon_i2c_ctl_read(i2c) & TWSI_CTL_IFLG);
 }
 
+#define I2C_OCTEON_IFLG_WAIT 80	/* microseconds */
+
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
+		usleep_range(I2C_OCTEON_IFLG_WAIT, 2 * I2C_OCTEON_IFLG_WAIT);
+		iflg = octeon_i2c_test_iflg(i2c);
+	}
+	return iflg;
+}
+
 /**
  * octeon_i2c_wait - wait for the IFLG to be set
  * @i2c: The struct octeon_i2c
@@ -354,9 +376,10 @@ static int octeon_i2c_test_iflg(struct octeon_i2c *i2c)
 static int octeon_i2c_wait(struct octeon_i2c *i2c)
 {
 	long time_left;
+	int first = 1;
 
 	i2c->int_en(i2c);
-	time_left = wait_event_timeout(i2c->queue, octeon_i2c_test_iflg(i2c),
+	time_left = wait_event_timeout(i2c->queue, poll_iflg(i2c, &first),
 				       i2c->adap.timeout);
 	i2c->int_dis(i2c);
 	if (!time_left) {
-- 
1.9.1
