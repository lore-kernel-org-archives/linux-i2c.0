From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] i2c-tiny-usb: Return an error code only as a constant in
 i2c_tiny_usb_probe()
Date: Thu, 1 Feb 2018 17:58:27 +0100
Message-ID: <b6a54fdf-eb83-cf33-b3f9-d26d9be14d03@users.sourceforge.net>
References: <5ab52458-e334-bb06-8d7d-66b48ac3f30b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:53175 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752693AbeBAQ6a (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 1 Feb 2018 11:58:30 -0500
In-Reply-To: <5ab52458-e334-bb06-8d7d-66b48ac3f30b@users.sourceforge.net>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Till Harbaum <till@harbaum.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Feb 2018 17:45:21 +0100

* Return an error code without storing it in an intermediate variable.

* Delete the label "error" and local variable "retval"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-tiny-usb.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index e210e36df123..2416bb0d8a88 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -223,7 +223,6 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 			      const struct usb_device_id *id)
 {
 	struct i2c_tiny_usb *dev;
-	int retval = -ENOMEM;
 	u16 version;
 
 	dev_dbg(&interface->dev, "probing usb device\n");
@@ -231,7 +230,7 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
-		goto error;
+		return -ENOMEM;
 
 	dev->usb_dev = usb_get_dev(interface_to_usbdev(interface));
 	dev->interface = interface;
@@ -257,8 +256,8 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	if (usb_write(&dev->adapter, CMD_SET_DELAY, delay, 0, NULL, 0) != 0) {
 		dev_err(&dev->adapter.dev,
 			"failure setting delay to %dus\n", delay);
-		retval = -EIO;
-		goto error;
+		i2c_tiny_usb_free(dev);
+		return -EIO;
 	}
 
 	dev->adapter.dev.parent = &dev->interface->dev;
@@ -270,12 +269,6 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	dev_info(&dev->adapter.dev, "connected i2c-tiny-usb device\n");
 
 	return 0;
-
- error:
-	if (dev)
-		i2c_tiny_usb_free(dev);
-
-	return retval;
 }
 
 static void i2c_tiny_usb_disconnect(struct usb_interface *interface)
-- 
2.16.1
