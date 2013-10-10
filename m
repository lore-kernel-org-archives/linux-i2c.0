From: Ionut Nicu <ioan.nicu.ext@nsn.com>
Subject: [PATCH 2/2] i2c-mux-gpio: eliminate i2c channel order assumptions
Date: Thu, 10 Oct 2013 10:39:38 +0200
Message-ID: <525667CA.3030504@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter.korsgaard@barco.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Alexander Sverdlin <alexander.sverdlin@nsn.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The i2c-mux driver uses the chan_id parameter provided
in i2c_add_mux_adapter as a parameter to the select
and deselect callbacks while the i2c-mux-gpio driver
uses the chan_id as an index in the mux->data.values
array.

A simple example of where this doesn't work is when we
have a device tree like this:

i2cmux {
	i2c@1 {
		reg = <1>;
		...
	};

	i2c@0 {
		reg = <0>;
		...
	};
};

The mux->data.values array will be { 1, 0 }, but when
the i2-mux driver will try to select channel 0, the
i2c-mux-gpio driver will actually use values[0], hence 1
as the gpio selection value.

Signed-off-by: Ionut Nicu <ioan.nicu.ext@nsn.com>
---
 drivers/i2c/muxes/i2c-mux-gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index b5f17ef..3505d0e 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -43,7 +43,7 @@ static int i2c_mux_gpio_select(struct i2c_adapter *adap, void *data, u32 chan)
 {
 	struct gpiomux *mux = data;
 
-	i2c_mux_gpio_set(mux, mux->data.values[chan]);
+	i2c_mux_gpio_set(mux, chan);
 
 	return 0;
 }
@@ -233,7 +233,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		unsigned int class = mux->data.classes ? mux->data.classes[i] : 0;
 
 		mux->adap[i] = i2c_add_mux_adapter(parent, &pdev->dev, mux, nr,
-						   i, class,
+						   mux->data.values[i], class,
 						   i2c_mux_gpio_select, deselect);
 		if (!mux->adap[i]) {
 			ret = -ENODEV;
-- 
1.7.1
