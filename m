From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 26/40] i2c: riic: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:16 +0200
Message-ID: <20200224151530.31713-26-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62976 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbgBXPPq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:46 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Chris Brandt <chris.brandt@renesas.com>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Chris Brandt <chris.brandt@renesas.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-riic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 800414886f6b..051649e2afe5 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -287,10 +287,10 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 
 	pm_runtime_get_sync(riic->adapter.dev.parent);
 
-	if (t->bus_freq_hz > 400000) {
+	if (t->bus_freq_hz > I2C_FAST_MODE_FREQ) {
 		dev_err(&riic->adapter.dev,
-			"unsupported bus speed (%dHz). 400000 max\n",
-			t->bus_freq_hz);
+			"unsupported bus speed (%dHz). %d max\n",
+			t->bus_freq_hz, I2C_FAST_MODE_FREQ);
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.25.0
