From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 2/4] i2c: octeon: thunderx: Remove double-check after interrupt
Date: Fri,  9 Dec 2016 10:31:56 +0100
Message-ID: <20161209093158.3161-3-jglauber@cavium.com>
References: <20161209093158.3161-1-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33891 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933214AbcLIJc3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Dec 2016 04:32:29 -0500
Received: by mail-wm0-f65.google.com with SMTP id g23so2773963wme.1
        for <linux-i2c@vger.kernel.org>; Fri, 09 Dec 2016 01:32:28 -0800 (PST)
In-Reply-To: <20161209093158.3161-1-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: Paul Burton <paul.burton@imgtec.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>

Commit 1bb1ff3e7c74 ("i2c: octeon: Improve performance if interrupt is
early") added a double-check around the wait_event_timeout() condition.
The performance problem that this commit tried to work-around
could not be reproduced. It also makes the wait condition more
complicated then it should be. Therefore remove the double-check.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 43 ++----------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 2b8a7bf..3d10f1a 100644
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
@@ -80,7 +61,7 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 	}
 
 	i2c->int_enable(i2c);
-	time_left = wait_event_timeout(i2c->queue, octeon_i2c_test_ready(i2c, &first),
+	time_left = wait_event_timeout(i2c->queue, octeon_i2c_test_iflg(i2c),
 				       i2c->adap.timeout);
 	i2c->int_disable(i2c);
 
@@ -102,25 +83,6 @@ static bool octeon_i2c_hlc_test_valid(struct octeon_i2c *i2c)
 	return (__raw_readq(i2c->twsi_base + SW_TWSI(i2c)) & SW_TWSI_V) == 0;
 }
 
-static bool octeon_i2c_hlc_test_ready(struct octeon_i2c *i2c, bool *first)
-{
-	/* check if valid bit is cleared */
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
-}
-
 static void octeon_i2c_hlc_int_clear(struct octeon_i2c *i2c)
 {
 	/* clear ST/TS events, listen for neither */
@@ -176,7 +138,6 @@ static void octeon_i2c_hlc_disable(struct octeon_i2c *i2c)
  */
 static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 {
-	bool first = true;
 	int time_left;
 
 	/*
@@ -195,7 +156,7 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 
 	i2c->hlc_int_enable(i2c);
 	time_left = wait_event_timeout(i2c->queue,
-				       octeon_i2c_hlc_test_ready(i2c, &first),
+				       octeon_i2c_hlc_test_valid(i2c),
 				       i2c->adap.timeout);
 	i2c->hlc_int_disable(i2c);
 	if (!time_left)
-- 
2.9.0.rc0.21.g7777322
