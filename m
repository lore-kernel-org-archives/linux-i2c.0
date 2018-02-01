From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] i2c-tiny-usb: Delete an error message for a failed memory
 allocation in i2c_tiny_usb_probe()
Date: Thu, 1 Feb 2018 17:57:00 +0100
Message-ID: <39c40369-48ef-e245-4e19-4caf12e9f06b@users.sourceforge.net>
References: <5ab52458-e334-bb06-8d7d-66b48ac3f30b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5ab52458-e334-bb06-8d7d-66b48ac3f30b@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, Till Harbaum <till@harbaum.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Feb 2018 17:36:50 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-tiny-usb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index a2e3dd715380..e210e36df123 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -230,10 +230,8 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (dev == NULL) {
-		dev_err(&interface->dev, "Out of memory\n");
+	if (!dev)
 		goto error;
-	}
 
 	dev->usb_dev = usb_get_dev(interface_to_usbdev(interface));
 	dev->interface = interface;
-- 
2.16.1
