From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 2/3] i2c: octeon: Fix waiting for operation completion
Date: Mon, 14 Nov 2016 19:50:44 +0100
Message-ID: <1479149445-4663-3-git-send-email-jglauber@cavium.com>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34481 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932906AbcKNSv2 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Nov 2016 13:51:28 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so17943240wme.1
        for <linux-i2c@vger.kernel.org>; Mon, 14 Nov 2016 10:51:27 -0800 (PST)
In-Reply-To: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>, David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>, Peter Swain <pswain@cavium.com>

From: Paul Burton <paul.burton@imgtec.com>

Commit 1bb1ff3e7c74 ("i2c: octeon: Improve performance if interrupt is
early") modified octeon_i2c_wait() & octeon_i2c_hlc_wait() to attempt to
check for a valid bit being clear & if not to sleep for a while then try
again before waiting on a waitqueue which may time out. However it does
so by sleeping within a function called as the condition provided to
wait_event_timeout() which seems to cause strange behaviour, with the
system hanging during boot with the condition being checked constantly &
the timeout not seeming to have any effect.

Fix this by instead checking for the valid bit being clear in the
octeon_i2c(_hlc)_wait() functions & sleeping there if that condition is
not met, then calling the wait_event_timeout with a condition that does
not sleep.

Tested on a Rhino Labs UTM-8 with Octeon CN7130.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Jan Glauber <jglauber@cavium.com>
[jglauber@cavium.com: removed unused variable]
Cc: Peter Swain <pswain@cavium.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
---
 drivers/i2c/busses/i2c-octeon-core.c | 59 +++++++++---------------------------
 1 file changed, 15 insertions(+), 44 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 5e63b17..54a9c14 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -36,24 +36,6 @@ static bool octeon_i2c_test_iflg(struct octeon_i2c *i2c)
 	return (octeon_i2c_ctl_read(i2c) & TWSI_CTL_IFLG);
 }
 
-static bool octeon_i2c_test_ready(struct octeon_i2c *i2c, bool *first)
-{
-	if (octeon_i2c_test_iflg(i2c))
-		return true;
-
-	if (*first) {
-		*first = false;
-		return false;
-	}
-
-	/*
-	 * IRQ has signaled an event but IFLG hasn't changed.
-	 * Sleep and retry once.
-	 */
-	usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
-	return octeon_i2c_test_iflg(i2c);
-}
-
 /**
  * octeon_i2c_wait - wait for the IFLG to be set
  * @i2c: The struct octeon_i2c
@@ -63,7 +45,6 @@ static bool octeon_i2c_test_ready(struct octeon_i2c *i2c, bool *first)
 static int octeon_i2c_wait(struct octeon_i2c *i2c)
 {
 	long time_left;
-	bool first = true;
 
 	/*
 	 * Some chip revisions don't assert the irq in the interrupt
@@ -80,8 +61,13 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 	}
 
 	i2c->int_enable(i2c);
-	time_left = wait_event_timeout(i2c->queue, octeon_i2c_test_ready(i2c, &first),
-				       i2c->adap.timeout);
+	time_left = i2c->adap.timeout;
+	if (!octeon_i2c_test_iflg(i2c)) {
+		usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
+		time_left = wait_event_timeout(i2c->queue,
+					       octeon_i2c_test_iflg(i2c),
+					       time_left);
+	}
 	i2c->int_disable(i2c);
 
 	if (i2c->broken_irq_check && !time_left &&
@@ -99,26 +85,8 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 
 static bool octeon_i2c_hlc_test_valid(struct octeon_i2c *i2c)
 {
-	return (__raw_readq(i2c->twsi_base + SW_TWSI(i2c)) & SW_TWSI_V) == 0;
-}
-
-static bool octeon_i2c_hlc_test_ready(struct octeon_i2c *i2c, bool *first)
-{
 	/* check if valid bit is cleared */
-	if (octeon_i2c_hlc_test_valid(i2c))
-		return true;
-
-	if (*first) {
-		*first = false;
-		return false;
-	}
-
-	/*
-	 * IRQ has signaled an event but valid bit isn't cleared.
-	 * Sleep and retry once.
-	 */
-	usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
-	return octeon_i2c_hlc_test_valid(i2c);
+	return (__raw_readq(i2c->twsi_base + SW_TWSI(i2c)) & SW_TWSI_V) == 0;
 }
 
 static void octeon_i2c_hlc_int_clear(struct octeon_i2c *i2c)
@@ -176,7 +144,6 @@ static void octeon_i2c_hlc_disable(struct octeon_i2c *i2c)
  */
 static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 {
-	bool first = true;
 	int time_left;
 
 	/*
@@ -194,9 +161,13 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 	}
 
 	i2c->hlc_int_enable(i2c);
-	time_left = wait_event_timeout(i2c->queue,
-				       octeon_i2c_hlc_test_ready(i2c, &first),
-				       i2c->adap.timeout);
+	time_left = i2c->adap.timeout;
+	if (!octeon_i2c_hlc_test_valid(i2c)) {
+		usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
+		time_left = wait_event_timeout(i2c->queue,
+					       octeon_i2c_hlc_test_valid(i2c),
+					       time_left);
+	}
 	i2c->hlc_int_disable(i2c);
 	if (!time_left)
 		octeon_i2c_hlc_int_clear(i2c);
-- 
1.9.1
