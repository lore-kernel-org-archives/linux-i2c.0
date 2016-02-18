From: Jan Glauber <jglauber@cavium.com>
Subject: [RFC PATCH 8/8] i2c-octeon: Add workaround for chips with broken irqs
Date: Thu, 18 Feb 2016 09:22:30 +0100
Message-ID: <be4e3fc91e12bf2987999057404d36285933ad90.1455782324.git.jglauber@cavium.com>
References: <cover.1455782324.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455782324.git.jglauber@cavium.com>
In-Reply-To: <cover.1455782324.git.jglauber@cavium.com>
References: <cover.1455782324.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

From: David Daney <ddaney@caviumnetworks.com>

CN3860 does not interrupt the CPU when the i2c status changes.  If
we get a timeout, and see the status has in fact changed, we know we
have this problem, and drop back to polling.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index e3552e5..3c2f848 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -115,6 +115,7 @@ struct octeon_i2c {
 	int			sys_freq;
 	void __iomem		*twsi_base;
 	struct device		*dev;
+	int			broken_irq_mode;
 	bool			hlc_enabled;
 	void			(*int_en)	(struct octeon_i2c *);
 	void			(*int_dis)	(struct octeon_i2c *);
@@ -382,10 +383,33 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 	int first = 1;
 	long result;
 
+	if (i2c->broken_irq_mode) {
+		/*
+		 * Some chip revisions seem to not assert the irq in
+		 * the interrupt controller.  So we must poll for the
+		 * IFLG change.
+		 */
+		u64 end = get_jiffies_64() + i2c->adap.timeout;
+
+		while (!octeon_i2c_test_iflg(i2c) &&
+		       time_before64(get_jiffies_64(), end))
+			udelay(50);
+
+		return octeon_i2c_test_iflg(i2c) ? 0 : -ETIMEDOUT;
+	}
+
 	i2c->int_en(i2c);
 	result = wait_event_timeout(i2c->queue, poll_iflg(i2c, &first),
 				    i2c->adap.timeout);
 	i2c->int_dis(i2c);
+
+	if (result <= 0 && OCTEON_IS_MODEL(OCTEON_CN38XX) &&
+	    octeon_i2c_test_iflg(i2c)) {
+		dev_err(i2c->dev,
+			"broken irq connection detected, switching to polling mode.\n");
+		i2c->broken_irq_mode = 1;
+		return 0;
+	}
 	if (!result) {
 		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
 		return -ETIMEDOUT;
@@ -740,6 +764,21 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 {
 	int result;
 
+	if (i2c->broken_irq_mode) {
+		/*
+		 * Some cn38xx boards did not assert the irq in
+		 * the interrupt controller.  So we must poll for the
+		 * IFLG change.
+		 */
+		u64 end = get_jiffies_64() + i2c->adap.timeout;
+
+		while (!octeon_i2c_hlc_test_ready(i2c) &&
+		       time_before64(get_jiffies_64(), end))
+			udelay(50);
+
+		return octeon_i2c_hlc_test_ready(i2c) ? 0 : -ETIMEDOUT;
+	}
+
 	i2c->hlc_int_en(i2c);
 	result = wait_event_interruptible_timeout(i2c->queue,
 			octeon_i2c_hlc_test_ready(i2c), i2c->adap.timeout);
@@ -747,6 +786,13 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 	if (!result)
 		octeon_i2c_hlc_int_clear(i2c);
 
+	if (result <= 0 && OCTEON_IS_MODEL(OCTEON_CN38XX) &&
+	    octeon_i2c_hlc_test_ready(i2c)) {
+		dev_err(i2c->dev, "broken irq connection detected, switching to polling mode.\n");
+			i2c->broken_irq_mode = 1;
+			return 0;
+	}
+
 	if (result < 0) {
 		dev_dbg(i2c->dev, "%s: wait interrupted\n", __func__);
 		return result;
-- 
1.9.1
