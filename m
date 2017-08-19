From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 3/4] [media] radio-usb-si4713: make i2c_adapter const
Date: Sat, 19 Aug 2017 16:04:14 +0530
Message-ID: <1503138855-585-4-git-send-email-bhumirks@gmail.com>
References: <1503138855-585-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503138855-585-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, wsa@the-dreams.de, jacmet@sunsite.dk, jglauber@cavium.com, david.daney@cavium.com, hans.verkuil@cisco.com, mchehab@kernel.org, awalls@md.metrocast.net, serjk@netup.ru, aospan@netup.ru, isely@pobox.com, ezequiel@vanguardiasur.com.ar, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Make this const as it is only used in a copy operation.
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/media/radio/si4713/radio-usb-si4713.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/radio/si4713/radio-usb-si4713.c b/drivers/media/radio/si4713/radio-usb-si4713.c
index e5e5a16..f20aac2 100644
--- a/drivers/media/radio/si4713/radio-usb-si4713.c
+++ b/drivers/media/radio/si4713/radio-usb-si4713.c
@@ -409,7 +409,7 @@ static u32 si4713_functionality(struct i2c_adapter *adapter)
 
 /* This name value shows up in the sysfs filename associated
 		with this I2C adapter */
-static struct i2c_adapter si4713_i2c_adapter_template = {
+static const struct i2c_adapter si4713_i2c_adapter_template = {
 	.name   = "si4713-i2c",
 	.owner  = THIS_MODULE,
 	.algo   = &si4713_algo,
-- 
1.9.1
