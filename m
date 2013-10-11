From: Ionut Nicu <ioan.nicu.ext@nsn.com>
Subject: [PATCH 2/2] i2c-mux-gpio: use reg value for i2c_add_mux_adapter
Date: Fri, 11 Oct 2013 12:09:57 +0200
Message-ID: <5257CE75.5000607@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter.korsgaard@barco.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Alexander Sverdlin <alexander.sverdlin@nsn.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The i2c-mux driver requires that the chan_id parameter
passed to the i2c_add_mux_adapter() function is equal
to the reg value for that adapter:

for_each_child_of_node(mux_dev->of_node, child) {
	ret = of_property_read_u32(child, "reg", &reg);
	if (ret)
		continue;
	if (chan_id == reg) {
		priv->adap.dev.of_node = child;
		break;
	}
}

The i2c-mux-gpio driver uses an internal logical index
for chan_id when calling i2c_add_mux_adapter() instead
of using the reg value.

Because of this, there will problems in selecting the
right adapter when the i2c-mux-gpio's index into
mux->data.values doesn't match the reg value.

An example of such a case:

mux->data.values = { 1, 0 }

For chan_id = 0, i2c-mux will bind the adapter to the
of_node with reg = <0>, but when it will call the
select() callback with chan_id set to 0, the i2c-mux-gpio
will use it as an index into mux->data.values and it will
actually select the bus with reg = <1>.

Signed-off-by: Ionut Nicu <ioan.nicu.ext@nsn.com>
---
 drivers/i2c/muxes/i2c-mux-gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 550e094..ed3e849 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -38,7 +38,7 @@ static int i2c_mux_gpio_select(struct i2c_adapter *adap, void *data, u32 chan)
 {
 	struct gpiomux *mux = data;
 
-	i2c_mux_gpio_set(mux, mux->data.values[chan]);
+	i2c_mux_gpio_set(mux, chan);
 
 	return 0;
 }
@@ -228,7 +228,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		unsigned int class = mux->data.classes ? mux->data.classes[i] : 0;
 
 		mux->adap[i] = i2c_add_mux_adapter(parent, &pdev->dev, mux, nr,
-						   i, class,
+						   mux->data.values[i], class,
 						   i2c_mux_gpio_select, deselect);
 		if (!mux->adap[i]) {
 			ret = -ENODEV;
-- 
1.7.1
