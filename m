From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] i2c: core: make it possible to match a pure device tree driver
Date: Mon, 13 May 2013 00:26:23 +0200
Message-ID: <1368397583-22769-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This tries to address an issue found when writing an MFD driver
for the Nomadik STw481x PMICs: as the platform is using device
tree exclusively I want to specify the driver matching like
this:

static const struct of_device_id stw481x_match[] = {
	{ .compatible = "st,stw4810", },
	{ .compatible = "st,stw4811", },
	{},
};

static struct i2c_driver stw481x_driver = {
	.driver = {
		.name	= "stw481x",
		.of_match_table = stw481x_match,
	},
	.probe		= stw481x_probe,
	.remove		= stw481x_remove,
};

However that turns out not to be possible: the I2C probe code
is written so that the probe() call is always passed a match
from i2c_match_id() using non-devicetree matches.

This is probably why most devices using device tree for I2C
clients currently will pass no .of_match_table *at all* but
instead just use .id_table from struct i2c_driver to match
the device. As you realize that means that the whole idea with
compatible strings is discarded, and that is why we find strange
device tree I2C device compatible strings like "product" instead
of "vendor,product" as you could expect.

Let's figure out how to fix this before the mess spreads. This
patch will allow probeing devices with only an of_match_table
as per above, and will pass NULL as the second argument to the
probe() function. If the driver wants to deduce secondary info
from the struct of_device_id .data field, it has to call
of_match_device() on its own match table in the probe function
device tree probe path.

If drivers define both an .of_match_table *AND* a i2c_driver
.id_table, the .of_match_table will take precedence, just
as is done in the i2c_device_match() function in i2c-core.c.

I2C devices probed from device tree should subsequently be
fixed to handle the case where of_match_table() is
used (I think none of them do that today), and platforms should
fix their device trees to use compatible strings for I2C devices
instead of setting the name to Linux device driver names as is
done in multiple cases today.

Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
I would need some device tree core people to confirm that I am
on the right track with this. I was soooo confused when I found
that .of_match_table could not be used with I2C devices...
---
 drivers/i2c/i2c-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 6b63cc7..30b5bb2 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -240,7 +240,7 @@ static int i2c_device_probe(struct device *dev)
 		return 0;
 
 	driver = to_i2c_driver(dev->driver);
-	if (!driver->probe || !driver->id_table)
+	if (!driver->probe || (!driver->id_table && !dev->driver->of_match_table))
 		return -ENODEV;
 	client->driver = driver;
 	if (!device_can_wakeup(&client->dev))
@@ -248,7 +248,12 @@ static int i2c_device_probe(struct device *dev)
 					client->flags & I2C_CLIENT_WAKE);
 	dev_dbg(dev, "probe\n");
 
-	status = driver->probe(client, i2c_match_id(driver->id_table, client));
+	if (dev->driver->of_match_table)
+		/* Device tree matching */
+		status = driver->probe(client, NULL);
+	else
+		/* Fall back to matching the id_table */
+		status = driver->probe(client, i2c_match_id(driver->id_table, client));
 	if (status) {
 		client->driver = NULL;
 		i2c_set_clientdata(client, NULL);
-- 
1.8.1.4
