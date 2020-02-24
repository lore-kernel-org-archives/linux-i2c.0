From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 16/40] i2c: img-scb: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:06 +0200
Message-ID: <20200224151530.31713-16-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:50806 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgBXPPi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:38 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since we have generic definitions for bus frequencies, let's use them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-img-scb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 20a4fbc53007..e5fed1814c8f 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -304,7 +304,7 @@ static struct img_i2c_timings timings[] = {
 	/* Standard mode */
 	{
 		.name = "standard",
-		.max_bitrate = 100000,
+		.max_bitrate = I2C_STANDARD_MODE_FREQ,
 		.tckh = 4000,
 		.tckl = 4700,
 		.tsdh = 4700,
@@ -316,7 +316,7 @@ static struct img_i2c_timings timings[] = {
 	/* Fast mode */
 	{
 		.name = "fast",
-		.max_bitrate = 400000,
+		.max_bitrate = I2C_FAST_MODE_FREQ,
 		.tckh = 600,
 		.tckl = 1300,
 		.tsdh = 600,
-- 
2.25.0
