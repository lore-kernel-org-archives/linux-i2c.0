From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] i2c: mux: pca954x: Drop useless validation for optional GPIO descriptor
Date: Thu,  5 Mar 2020 17:53:50 +0200
Message-ID: <20200305155352.39095-3-andriy.shevchenko@linux.intel.com>
References: <20200305155352.39095-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:36688 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgCEPyS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 5 Mar 2020 10:54:18 -0500
In-Reply-To: <20200305155352.39095-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is no need to perform a check for optional GPIO descriptor.
If it's NULL, the API can handle it correctly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 2e42a113ef1f..fe4320fc0b91 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -444,12 +444,12 @@ static int pca954x_probe(struct i2c_client *client,
 	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
-	if (gpio) {
-		udelay(1);
-		gpiod_set_value_cansleep(gpio, 0);
-		/* Give the chip some time to recover. */
-		udelay(1);
-	}
+
+	/* Reset the multiplexer */
+	udelay(1);
+	gpiod_set_value_cansleep(gpio, 0);
+	/* Give the chip some time to recover. */
+	udelay(1);
 
 	data->chip = device_get_match_data(dev);
 	if (!data->chip)
-- 
2.25.1
