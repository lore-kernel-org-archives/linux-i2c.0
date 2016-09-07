From: <jim_baxter@mentor.com>
Subject: [PATCH v1 2/2] i2c-mux-gpio: call i2c_add_reparented_mux_adapter
Date: Wed, 7 Sep 2016 21:05:29 +0100
Message-ID: <1473278729-16329-3-git-send-email-jim_baxter@mentor.com>
References: <1473278729-16329-1-git-send-email-jim_baxter@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473278729-16329-1-git-send-email-jim_baxter@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Joshua Frkuska <joshua_frkuska@mentor.com>

This reparents the adapter created in i2c-mux to this module for
module unloading and chaining purposes.

Signed-off-by: Joshua Frkuska <joshua_frkuska@mentor.com>
Signed-off-by: Jim Baxter <jim_baxter@mentor.com>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index e5cf26e..9f92535 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -234,7 +234,11 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		u32 nr = mux->data.base_nr ? (mux->data.base_nr + i) : 0;
 		unsigned int class = mux->data.classes ? mux->data.classes[i] : 0;
 
-		ret = i2c_mux_add_adapter(muxc, nr, mux->data.values[i], class);
+		ret = i2c_mux_add_reparented_adapter(THIS_MODULE,
+						     muxc,
+						     nr,
+						     mux->data.values[i],
+						     class);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
 			goto add_adapter_failed;
-- 
1.9.1
