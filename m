From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: [PATCH v2] i2c-isch: Add module parameter for backbone clock rate if divider is unset
Date: Mon, 28 Jan 2013 10:44:12 +0100
Message-ID: <1359366252-22250-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

It was observed the Host Clock Divider was not written by the driver. It
was still set to (default) 0, if not already set by BIOS, which caused
garbage on SMBus.
This driver adds a parameters which is used to calculate the divider
appropriately for a default bitrate of 100 KHz. This new divider is only
applied if the clock divider is still default 0.

Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
---
Changes in v2:
* Removed useless debug output
* Added description comment about calculation into code
* Some code organization changes

 drivers/i2c/busses/i2c-isch.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index 4099f79..8c38aaa 100644
--- a/drivers/i2c/busses/i2c-isch.c
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -40,6 +40,7 @@
 /* SCH SMBus address offsets */
 #define SMBHSTCNT	(0 + sch_smba)
 #define SMBHSTSTS	(1 + sch_smba)
+#define SMBHSTCLK	(2 + sch_smba)
 #define SMBHSTADD	(4 + sch_smba) /* TSA */
 #define SMBHSTCMD	(5 + sch_smba)
 #define SMBHSTDAT0	(6 + sch_smba)
@@ -58,6 +59,9 @@
 
 static unsigned short sch_smba;
 static struct i2c_adapter sch_adapter;
+static int backbone_speed = 33000; /* backbone speed in kHz */
+module_param(backbone_speed, int, S_IRUSR | S_IWUSR);
+MODULE_PARM_DESC(backbone_speed, "Backbone speed in kHz, (default = 33000)");
 
 /*
  * Start the i2c transaction -- the i2c_access will prepare the transaction
@@ -156,6 +160,19 @@ static s32 sch_access(struct i2c_adapter *adap, u16 addr,
 		dev_dbg(&sch_adapter.dev, "SMBus busy (%02x)\n", temp);
 		return -EAGAIN;
 	}
+	temp = inw(SMBHSTCLK);
+	if (!temp) {
+		/*
+		 * We can't determine if we have 33 or 25 MHz clock for
+		 * SMBus, so expect 33 MHz and calculate a bus clock of
+		 * 100 kHz. If we actually run at 25 MHz the bus will be
+		 * run ~75 kHz instead which should do no harm.
+		 */
+		dev_notice(&sch_adapter.dev,
+			"Clock divider unitialized. Setting defaults\n");
+		outw(backbone_speed / (4 * 100), SMBHSTCLK);
+	}
+
 	dev_dbg(&sch_adapter.dev, "access size: %d %s\n", size,
 		(read_write)?"READ":"WRITE");
 	switch (size) {
-- 
1.8.1.1
