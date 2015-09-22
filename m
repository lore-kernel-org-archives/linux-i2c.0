From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] i2c-ocores: support big-endian register layout
Date: Tue, 22 Sep 2015 14:29:22 +0300
Message-ID: <1442921362-1146-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:35490 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbbIVL3p (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 22 Sep 2015 07:29:45 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Korsgaard <jacmet@sunsite.dk>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 drivers/i2c/busses/i2c-ocores.c | 31 +++++++++++++++++++++++++++----
 include/linux/i2c-ocores.h      |  1 +
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index abf5db7..11b7b87 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -92,6 +92,16 @@ static void oc_setreg_32(struct ocores_i2c *i2c, int reg, u8 value)
 	iowrite32(value, i2c->base + (reg << i2c->reg_shift));
 }
 
+static void oc_setreg_16be(struct ocores_i2c *i2c, int reg, u8 value)
+{
+	iowrite16be(value, i2c->base + (reg << i2c->reg_shift));
+}
+
+static void oc_setreg_32be(struct ocores_i2c *i2c, int reg, u8 value)
+{
+	iowrite32be(value, i2c->base + (reg << i2c->reg_shift));
+}
+
 static inline u8 oc_getreg_8(struct ocores_i2c *i2c, int reg)
 {
 	return ioread8(i2c->base + (reg << i2c->reg_shift));
@@ -107,6 +117,16 @@ static inline u8 oc_getreg_32(struct ocores_i2c *i2c, int reg)
 	return ioread32(i2c->base + (reg << i2c->reg_shift));
 }
 
+static inline u8 oc_getreg_16be(struct ocores_i2c *i2c, int reg)
+{
+	return ioread16be(i2c->base + (reg << i2c->reg_shift));
+}
+
+static inline u8 oc_getreg_32be(struct ocores_i2c *i2c, int reg)
+{
+	return ioread32be(i2c->base + (reg << i2c->reg_shift));
+}
+
 static inline void oc_setreg(struct ocores_i2c *i2c, int reg, u8 value)
 {
 	i2c->setreg(i2c, reg, value);
@@ -428,6 +448,9 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 		i2c->reg_io_width = 1; /* Set to default value */
 
 	if (!i2c->setreg || !i2c->getreg) {
+		bool be = pdata ? pdata->big_endian :
+			of_device_is_big_endian(pdev->dev.of_node);
+
 		switch (i2c->reg_io_width) {
 		case 1:
 			i2c->setreg = oc_setreg_8;
@@ -435,13 +458,13 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 			break;
 
 		case 2:
-			i2c->setreg = oc_setreg_16;
-			i2c->getreg = oc_getreg_16;
+			i2c->setreg = be ? oc_setreg_16be : oc_setreg_16;
+			i2c->getreg = be ? oc_getreg_16be : oc_getreg_16;
 			break;
 
 		case 4:
-			i2c->setreg = oc_setreg_32;
-			i2c->getreg = oc_getreg_32;
+			i2c->setreg = be ? oc_setreg_32be : oc_setreg_32;
+			i2c->getreg = be ? oc_getreg_32be : oc_getreg_32;
 			break;
 
 		default:
diff --git a/include/linux/i2c-ocores.h b/include/linux/i2c-ocores.h
index 1c06b5c..01edd96 100644
--- a/include/linux/i2c-ocores.h
+++ b/include/linux/i2c-ocores.h
@@ -15,6 +15,7 @@ struct ocores_i2c_platform_data {
 	u32 reg_shift; /* register offset shift value */
 	u32 reg_io_width; /* register io read/write width */
 	u32 clock_khz; /* input clock in kHz */
+	bool big_endian; /* registers are big endian */
 	u8 num_devices; /* number of devices in the devices list */
 	struct i2c_board_info const *devices; /* devices connected to the bus */
 };
-- 
1.8.1.4
