From: Martin Vogt <mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/1] i2c: i2c-diolan-u2c: different usb endpoints for DLN-2-U2C
Date: Sun, 24 Nov 2013 15:57:23 +0100
Message-ID: <1385305043-23626-1-git-send-email-mvogt1@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Vogt <mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The previous diolan adapter uses other out/in endpoints than
the current DLN-2-U2C in compatibility mode.
They changed from 0x2/0x84 to 0x3/0x83.
This patch gets the endpoints from the usb interface, instead
of hardcode them in the driver.

This was tested on a current DLN-2-U2C board.

Signed-off-by: Martin Vogt <mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-diolan-u2c.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
index dae3ddf..721f7eb 100644
--- a/drivers/i2c/busses/i2c-diolan-u2c.c
+++ b/drivers/i2c/busses/i2c-diolan-u2c.c
@@ -25,8 +25,6 @@
 #define USB_VENDOR_ID_DIOLAN		0x0abf
 #define USB_DEVICE_ID_DIOLAN_U2C	0x3370
 
-#define DIOLAN_OUT_EP		0x02
-#define DIOLAN_IN_EP		0x84
 
 /* commands via USB, must match command ids in the firmware */
 #define CMD_I2C_READ		0x01
@@ -84,6 +82,7 @@
 struct i2c_diolan_u2c {
 	u8 obuffer[DIOLAN_OUTBUF_LEN];	/* output buffer */
 	u8 ibuffer[DIOLAN_INBUF_LEN];	/* input buffer */
+	int ep_in, ep_out;              /* Endpoints    */
 	struct usb_device *usb_dev;	/* the usb device for this device */
 	struct usb_interface *interface;/* the interface for this device */
 	struct i2c_adapter adapter;	/* i2c related things */
@@ -109,7 +108,7 @@ static int diolan_usb_transfer(struct i2c_diolan_u2c *dev)
 		return -EINVAL;
 
 	ret = usb_bulk_msg(dev->usb_dev,
-			   usb_sndbulkpipe(dev->usb_dev, DIOLAN_OUT_EP),
+			   usb_sndbulkpipe(dev->usb_dev, dev->ep_out),
 			   dev->obuffer, dev->olen, &actual,
 			   DIOLAN_USB_TIMEOUT);
 	if (!ret) {
@@ -118,7 +117,7 @@ static int diolan_usb_transfer(struct i2c_diolan_u2c *dev)
 
 			tmpret = usb_bulk_msg(dev->usb_dev,
 					      usb_rcvbulkpipe(dev->usb_dev,
-							      DIOLAN_IN_EP),
+							      dev->ep_in),
 					      dev->ibuffer,
 					      sizeof(dev->ibuffer), &actual,
 					      DIOLAN_USB_TIMEOUT);
@@ -210,7 +209,7 @@ static void diolan_flush_input(struct i2c_diolan_u2c *dev)
 		int ret;
 
 		ret = usb_bulk_msg(dev->usb_dev,
-				   usb_rcvbulkpipe(dev->usb_dev, DIOLAN_IN_EP),
+				   usb_rcvbulkpipe(dev->usb_dev, dev->ep_in),
 				   dev->ibuffer, sizeof(dev->ibuffer), &actual,
 				   DIOLAN_USB_TIMEOUT);
 		if (ret < 0 || actual == 0)
@@ -445,9 +444,14 @@ static void diolan_u2c_free(struct i2c_diolan_u2c *dev)
 static int diolan_u2c_probe(struct usb_interface *interface,
 			    const struct usb_device_id *id)
 {
+	struct usb_host_interface *hostif = interface->cur_altsetting;
 	struct i2c_diolan_u2c *dev;
 	int ret;
 
+	if (hostif->desc.bInterfaceNumber != 0
+	    || hostif->desc.bNumEndpoints < 2)
+		return -ENODEV;
+
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (dev == NULL) {
@@ -455,6 +459,8 @@ static int diolan_u2c_probe(struct usb_interface *interface,
 		ret = -ENOMEM;
 		goto error;
 	}
+	dev->ep_out = hostif->endpoint[0].desc.bEndpointAddress;
+	dev->ep_in = hostif->endpoint[1].desc.bEndpointAddress;
 
 	dev->usb_dev = usb_get_dev(interface_to_usbdev(interface));
 	dev->interface = interface;
-- 
1.8.1.4
