From: Ionut Nicu <ioan.nicu.ext@nsn.com>
Subject: [PATCH 1/2] i2c-mux-gpio: use deferred probing
Date: Wed, 09 Oct 2013 11:50:45 +0200
Message-ID: <525526F5.5030107@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter.korsgaard@barco.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Alexander Sverdlin <alexander.sverdlin@nsn.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

If the i2c-parent bus driver is not loaded, returning
-ENODEV will force people to unload and then reload the
module again to get it working.

Signed-off-by: Ionut Nicu <ioan.nicu.ext@nsn.com>
---
 drivers/i2c/muxes/i2c-mux-gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 5d4a99b..ff184eb 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -79,7 +79,7 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 	adapter = of_find_i2c_adapter_by_node(adapter_np);
 	if (!adapter) {
 		dev_err(&pdev->dev, "Cannot find parent bus\n");
-		return -ENODEV;
+		return -EPROBE_DEFER;
 	}
 	mux->data.parent = i2c_adapter_id(adapter);
 	put_device(&adapter->dev);
@@ -177,7 +177,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	if (!parent) {
 		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
 			mux->data.parent);
-		return -ENODEV;
+		return -EPROBE_DEFER;
 	}
 
 	mux->parent = parent;
-- 
1.7.1
