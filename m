From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] i2c: fix linux/i2c.h kernel-doc warnings
Date: Thu, 29 Jul 2010 15:54:33 -0700
Message-ID: <20100729155433.d000005f.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Fix kernel-doc warnings in linux/i2c.h:

Warning(include/linux/i2c.h:176): No description found for parameter 'alert'
Warning(include/linux/i2c.h:259): No description found for parameter 'of_node'

Signed-off-by: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
 include/linux/i2c.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.35-rc5-git1.orig/include/linux/i2c.h
+++ linux-2.6.35-rc5-git1/include/linux/i2c.h
@@ -108,6 +108,7 @@ extern s32 i2c_smbus_write_i2c_block_dat
  * @shutdown: Callback for device shutdown
  * @suspend: Callback for device suspend
  * @resume: Callback for device resume
+ * @alert: Alert callback, for example for the SMBus alert protocol
  * @command: Callback for bus-wide signaling (optional)
  * @driver: Device driver model driver
  * @id_table: List of I2C devices supported by this driver
@@ -233,6 +234,7 @@ static inline void i2c_set_clientdata(st
  * @addr: stored in i2c_client.addr
  * @platform_data: stored in i2c_client.dev.platform_data
  * @archdata: copied into i2c_client.dev.archdata
+ * @of_node: pointer to OpenFirmware device node
  * @irq: stored in i2c_client.irq
  *
  * I2C doesn't actually support hardware probing, although controllers and
