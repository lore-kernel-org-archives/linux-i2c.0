From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] i2c: robotfuzz-osif: Constify osif_table
Date: Thu, 02 Jun 2016 13:28:48 +0800
Message-ID: <1464845328.6532.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32923 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbcFBF2x (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 2 Jun 2016 01:28:53 -0400
Received: by mail-pf0-f194.google.com with SMTP id b124so6628064pfb.0
        for <linux-i2c@vger.kernel.org>; Wed, 01 Jun 2016 22:28:53 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-i2c@vger.kernel.org

osif_table is never modified, so declare it as const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/i2c/busses/i2c-robotfuzz-osif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
index ced9c6a..89d8b41 100644
--- a/drivers/i2c/busses/i2c-robotfuzz-osif.c
+++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
@@ -125,7 +125,7 @@ static struct i2c_algorithm osif_algorithm = {
 #define USB_OSIF_VENDOR_ID	0x1964
 #define USB_OSIF_PRODUCT_ID	0x0001
 
-static struct usb_device_id osif_table[] = {
+static const struct usb_device_id osif_table[] = {
 	{ USB_DEVICE(USB_OSIF_VENDOR_ID, USB_OSIF_PRODUCT_ID) },
 	{ }
 };
-- 
2.5.0
