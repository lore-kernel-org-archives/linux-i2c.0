From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 6/8] i2c: mux: inform the i2c mux core about how it is used
Date: Mon, 15 Aug 2016 15:40:29 +0200
Message-ID: <1471268431-5148-7-git-send-email-peda@axentia.se>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471268431-5148-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>
List-Id: linux-i2c@vger.kernel.org

The i2c mux core can then take appropriate action depending on if it is
used for an actual i2c mux, for a gate or for an arbitrator (the last
is the case for these drivers). This adds support for the new clearer
and more compact devicetree bindings that was added recently.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 2 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c        | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
index a90bbc4037dd..86fc2d4c081b 100644
--- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
+++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
@@ -130,7 +130,7 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	muxc = i2c_mux_alloc(NULL, dev, 1, sizeof(*arb), 0,
+	muxc = i2c_mux_alloc(NULL, dev, 1, sizeof(*arb), I2C_MUX_ARBITRATOR,
 			     i2c_arbitrator_select, i2c_arbitrator_deselect);
 	if (!muxc)
 		return -ENOMEM;
diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 3cb8af635db5..f052c3067791 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -349,7 +349,8 @@ static int pca9541_probe(struct i2c_client *client,
 	force = 0;
 	if (pdata)
 		force = pdata->modes[0].adap_id;
-	muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data), 0,
+	muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
+			     I2C_MUX_ARBITRATOR,
 			     pca9541_select_chan, pca9541_release_chan);
 	if (!muxc)
 		return -ENOMEM;
-- 
2.1.4
