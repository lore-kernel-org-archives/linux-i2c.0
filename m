From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 6/6] media: usb: pvrusb2: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:09:46 +0100
Message-ID: <20200326210947.12747-7-wsa+renesas@sang-engineering.com>
References: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54342 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgCZVJx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Mar 2020 17:09:53 -0400
In-Reply-To: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Mike Isely <isely@pobox.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org

Move away from the deprecated API.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c b/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
index 275394bafe7d..63db04fe12d3 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
@@ -564,7 +564,7 @@ static void pvr2_i2c_register_ir(struct pvr2_hdw *hdw)
 		strscpy(info.type, "ir_video", I2C_NAME_SIZE);
 		pvr2_trace(PVR2_TRACE_INFO, "Binding %s to i2c address 0x%02x.",
 			   info.type, info.addr);
-		i2c_new_device(&hdw->i2c_adap, &info);
+		i2c_new_client_device(&hdw->i2c_adap, &info);
 		break;
 	case PVR2_IR_SCHEME_ZILOG:     /* HVR-1950 style */
 	case PVR2_IR_SCHEME_24XXX_MCE: /* 24xxx MCE device */
@@ -579,7 +579,7 @@ static void pvr2_i2c_register_ir(struct pvr2_hdw *hdw)
 		strscpy(info.type, "ir_z8f0811_haup", I2C_NAME_SIZE);
 		pvr2_trace(PVR2_TRACE_INFO, "Binding %s to i2c address 0x%02x.",
 			   info.type, info.addr);
-		i2c_new_device(&hdw->i2c_adap, &info);
+		i2c_new_client_device(&hdw->i2c_adap, &info);
 		break;
 	default:
 		/* The device either doesn't support I2C-based IR or we
-- 
2.20.1
