From: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] NFC: PN544: Add missing regulator.
Date: Thu, 17 Feb 2011 14:09:52 +0200
Message-ID: <1297944592-21784-1-git-send-email-matti.j.aaltonen@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add regulator VSim to the regulator array.

Signed-off-by: Matti J. Aaltonen <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/nfc/pn544.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/nfc/pn544.c b/drivers/nfc/pn544.c
index bae6472..724f65d 100644
--- a/drivers/nfc/pn544.c
+++ b/drivers/nfc/pn544.c
@@ -60,7 +60,7 @@ enum pn544_irq {
 struct pn544_info {
 	struct miscdevice miscdev;
 	struct i2c_client *i2c_dev;
-	struct regulator_bulk_data regs[2];
+	struct regulator_bulk_data regs[3];
 
 	enum pn544_state state;
 	wait_queue_head_t read_wait;
@@ -74,6 +74,7 @@ struct pn544_info {
 
 static const char reg_vdd_io[]	= "Vdd_IO";
 static const char reg_vbat[]	= "VBat";
+static const char reg_vsim[]	= "VSim";
 
 /* sysfs interface */
 static ssize_t pn544_test(struct device *dev,
@@ -740,6 +741,7 @@ static int __devinit pn544_probe(struct i2c_client *client,
 
 	info->regs[0].supply = reg_vdd_io;
 	info->regs[1].supply = reg_vbat;
+	info->regs[2].supply = reg_vsim;
 	r = regulator_bulk_get(&client->dev, ARRAY_SIZE(info->regs),
 				 info->regs);
 	if (r < 0)
-- 
1.6.1.3
