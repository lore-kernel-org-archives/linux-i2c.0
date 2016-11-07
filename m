From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv7 04/11] i2c: Make I2C ID tables non-mandatory for DT'ed devices
Date: Mon,  7 Nov 2016 12:47:39 +0000
Message-ID: <1478522866-29620-5-git-send-email-kieran@bingham.xyz>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieran@ksquared.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

Currently the I2C framework insists on devices supplying an I2C ID
table.  Many of the devices which do so unnecessarily adding quite a
few wasted lines to kernel code.  This patch allows drivers a means
to 'not' supply the aforementioned table and match on DT match tables
instead.

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Tested-by: Kieran Bingham <kieran@bingham.xyz>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
---
 drivers/i2c/i2c-core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 2adf4a1ed7ca..6439174c0ff5 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -697,7 +697,7 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
 
 
 	/* Attempt an OF style match */
-	if (of_driver_match_device(dev, drv))
+	if (i2c_of_match_device(drv->of_match_table, client))
 		return 1;
 
 	/* Then ACPI style match */
@@ -923,7 +923,15 @@ static int i2c_device_probe(struct device *dev)
 	}
 
 	driver = to_i2c_driver(dev->driver);
-	if (!driver->probe || !driver->id_table)
+	if (!driver->probe)
+		return -EINVAL;
+
+	/*
+	 * An I2C ID table is not mandatory, if and only if, a suitable Device
+	 * Tree match table entry is supplied for the probing device.
+	 */
+	if (!driver->id_table &&
+	    !i2c_of_match_device(dev->driver->of_match_table, client))
 		return -ENODEV;
 
 	if (client->flags & I2C_CLIENT_WAKE) {
-- 
2.7.4
