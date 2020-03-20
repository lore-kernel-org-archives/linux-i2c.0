From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 5/6] i2c: algo: Use generic definitions for bus frequencies
Date: Fri, 20 Mar 2020 21:12:48 +0200
Message-ID: <20200320191249.28835-5-andriy.shevchenko@linux.intel.com>
References: <20200320191249.28835-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24520 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgCTTMw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 20 Mar 2020 15:12:52 -0400
In-Reply-To: <20200320191249.28835-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since we have generic definitions for bus frequencies, let's use them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: no changes
 drivers/i2c/algos/i2c-algo-pca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index 5ac93f41bfec..dff4e178c732 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -459,17 +459,17 @@ static int pca_init(struct i2c_adapter *adap)
 		/* To avoid integer overflow, use clock/100 for calculations */
 		clock = pca_clock(pca_data) / 100;
 
-		if (pca_data->i2c_clock > 1000000) {
+		if (pca_data->i2c_clock > I2C_MAX_FAST_MODE_PLUS_FREQ) {
 			mode = I2C_PCA_MODE_TURBO;
 			min_tlow = 14;
 			min_thi  = 5;
 			raise_fall_time = 22; /* Raise 11e-8s, Fall 11e-8s */
-		} else if (pca_data->i2c_clock > 400000) {
+		} else if (pca_data->i2c_clock > I2C_MAX_FAST_MODE_FREQ) {
 			mode = I2C_PCA_MODE_FASTP;
 			min_tlow = 17;
 			min_thi  = 9;
 			raise_fall_time = 22; /* Raise 11e-8s, Fall 11e-8s */
-		} else if (pca_data->i2c_clock > 100000) {
+		} else if (pca_data->i2c_clock > I2C_MAX_STANDARD_MODE_FREQ) {
 			mode = I2C_PCA_MODE_FAST;
 			min_tlow = 44;
 			min_thi  = 20;
-- 
2.25.1
