From: Kieran Bingham <kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RESEND PATCH v4 4/8] i2c: Make I2C ID tables non-mandatory for DT'ed devices
Date: Fri, 11 Sep 2015 12:56:00 +0100
Message-ID: <1441972564-9621-5-git-send-email-kieranbingham@gmail.com>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441972564-9621-1-git-send-email-kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, Kieran Bingham <kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Currently the I2C framework insists on devices supplying an I2C ID
table.  Many of the devices which do so unnecessarily adding quite a
few wasted lines to kernel code.  This patch allows drivers a means
to 'not' supply the aforementioned table and match on DT match tables
instead.

Acked-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Kieran Bingham <kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 94ca76e..2ebc64d 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -468,7 +468,7 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
 
 
 	/* Attempt an OF style match */
-	if (of_driver_match_device(dev, drv))
+	if (i2c_of_match_device(drv->of_match_table, client))
 		return 1;
 
 	/* Then ACPI style match */
@@ -657,7 +657,15 @@ static int i2c_device_probe(struct device *dev)
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
 
 	if (!device_can_wakeup(&client->dev))
-- 
2.1.4
