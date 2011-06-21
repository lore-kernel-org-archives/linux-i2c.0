From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: [PATCH v2] i2c-isch: Add module parameter which actually set the clock divider
Date: Tue, 21 Jun 2011 11:21:22 +0200
Message-ID: <1308648082-32306-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1308230678-28861-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1308230678-28861-1-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Lucas De Marchi <lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

It was observed the Host Clock Divider was not written by the driver. It
was still set to (default) 0, if not already set by BIOS, which caused
garbage on SMBus.
This driver adds 2 parameters which are used to calculate the divider
appropriately. This new divider is only applied if the clock divider is
still default 0.

Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
---
Changes in v2:
* Only set new divider if not already set by BIOS/bootloader

 drivers/i2c/busses/i2c-isch.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index 0682f8f..46aaac3 100644
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
+	temp = inb(SMBHSTCLK);
+	if (!temp) {
+		dev_notice(&sch_adapter.dev, "clock divider unitialized. Setting module defaults\n");
+		dev_dbg(&sch_adapter.dev, "access speed: %d KHz\n", smbus_speed);
+		outb((backbone_speed / 4) / smbus_speed, SMBHSTCLK);
+	}
+
 	dev_dbg(&sch_adapter.dev, "access size: %d %s\n", size,
 		(read_write)?"READ":"WRITE");
 	switch (size) {
@@ -323,3 +333,5 @@ MODULE_LICENSE("GPL");
 module_init(i2c_sch_init);
 module_exit(i2c_sch_exit);
 MODULE_ALIAS("platform:isch_smbus");
+module_param(smbus_speed, int, (S_IRUSR | S_IWUSR));
+module_param(backbone_speed, int, (S_IRUSR | S_IWUSR));
-- 
1.7.3.4
