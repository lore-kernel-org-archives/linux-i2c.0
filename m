From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: [PATCH v2] i2c-isch: Add module parameter which actually set the clock divider
Date: Wed, 15 Feb 2012 15:36:49 +0100
Message-ID: <1329316609-14570-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

It was observed the Host Clock Divider was not written by the driver. It
was still set to (default) 0, if not already set by BIOS, which caused
garbage on SMBus.
This driver adds 2 parameters which are used to calculate the divider
appropriately. This new divider is only applied if the clock divider is
still default 0.

Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Tested-by: Adam Pribyl <pribyl-CRPBUER/Gz7twjQa/ONI9g@public.gmane.org>
---
Changes in v2:
* HSTCLK register is 16 Bit, not 8 Bit. Thanks to Adam for detecting

 drivers/i2c/busses/i2c-isch.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index 6561d27..bdfddf8 100644
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
@@ -58,6 +59,8 @@
 
 static unsigned short sch_smba;
 static struct i2c_adapter sch_adapter;
+static int smbus_speed = 100; /* SMBus bus speed in Kbps */
+static int backbone_speed = 33000; /* backbone speed in KHz */
 
 /*
  * Start the i2c transaction -- the i2c_access will prepare the transaction
@@ -156,6 +159,13 @@ static s32 sch_access(struct i2c_adapter *adap, u16 addr,
 		dev_dbg(&sch_adapter.dev, "SMBus busy (%02x)\n", temp);
 		return -EAGAIN;
 	}
+	temp = inw(SMBHSTCLK);
+	if (!temp) {
+		dev_notice(&sch_adapter.dev, "clock divider unitialized. Setting module defaults\n");
+		dev_dbg(&sch_adapter.dev, "access speed: %d KHz\n", smbus_speed);
+		outw((backbone_speed / 4) / smbus_speed, SMBHSTCLK);
+	}
+
 	dev_dbg(&sch_adapter.dev, "access size: %d %s\n", size,
 		(read_write)?"READ":"WRITE");
 	switch (size) {
@@ -312,3 +322,5 @@ MODULE_AUTHOR("Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
 MODULE_DESCRIPTION("Intel SCH SMBus driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:isch_smbus");
+module_param(smbus_speed, int, (S_IRUSR | S_IWUSR));
+module_param(backbone_speed, int, (S_IRUSR | S_IWUSR));
-- 
1.7.3.4
