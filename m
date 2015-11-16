From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] i2c: Revert "i2c: xiic: Do not reset controller before every transfer"
Date: Mon, 16 Nov 2015 14:42:03 +0100
Message-ID: <1447681325-30914-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0096.outbound.protection.outlook.com ([207.46.100.96]:37051
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752728AbbKPOON (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 16 Nov 2015 09:14:13 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Shubhrajyoti Datta <shubhraj@xilinx.com>, linux-i2c@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

Commit d701667bb331 ("i2c: xiic: Do not reset controller before every
transfer") removed the reinitialization of the controller before the start
of each transfer. Apparently this change is not safe to make and the commit
results in random I2C bus failures.

An easy way to trigger the issue is to run i2cdetect.

Without the patch applied:
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
	 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
	 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	 30: -- -- -- -- -- -- -- -- UU UU -- UU 3c -- -- UU
	 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	 70: -- -- -- -- -- -- -- --

With the patch applied every other or so invocation:
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
	 00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
	 10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
	 20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
	 30: -- -- -- -- -- -- -- -- UU UU -- UU 3c -- -- UU
	 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	 70: -- -- -- -- -- -- -- --

So revert the commit for now.

Fixes: d701667bb331 ("i2c: xiic: Do not reset controller before every transfer")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/i2c/busses/i2c-xiic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index e23a7b0..705cf69 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -662,6 +662,9 @@ static void __xiic_start_xfer(struct xiic_i2c *i2c)
 
 static void xiic_start_xfer(struct xiic_i2c *i2c)
 {
+	spin_lock(&i2c->lock);
+	xiic_reinit(i2c);
+	spin_unlock(&i2c->lock);
 
 	__xiic_start_xfer(i2c);
 }
-- 
2.1.4
