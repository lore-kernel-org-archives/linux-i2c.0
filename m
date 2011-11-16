From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Fix device name for 10-bit slave address
Date: Wed, 16 Nov 2011 16:27:31 +0100
Message-ID: <20111116162731.617504f5@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Jeffrey (Sheng-Hui) Chu" <jeffchu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

10-bit addresses overlap with traditional 7-bit addresses, leading in
device name collisions. Add an arbitrary offset to 10-bit addresses to
prevent this collision. The offset was chosen so that the address is
still easily recognizable.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 Documentation/i2c/ten-bit-addresses |   36 ++++++++++++++++++-----------------
 drivers/i2c/i2c-core.c              |    4 ++-
 2 files changed, 22 insertions(+), 18 deletions(-)

--- linux-3.2-rc2.orig/drivers/i2c/i2c-core.c	2011-11-16 11:13:50.000000000 +0100
+++ linux-3.2-rc2/drivers/i2c/i2c-core.c	2011-11-16 15:56:55.000000000 +0100
@@ -539,8 +539,10 @@ i2c_new_device(struct i2c_adapter *adap,
 	client->dev.type = &i2c_client_type;
 	client->dev.of_node = info->of_node;
 
+	/* For 10-bit clients, add an arbitrary offset to avoid collisions */
 	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
-		     client->addr);
+		     client->addr | ((client->flags & I2C_CLIENT_TEN)
+				     ? 0xa000 : 0));
 	status = device_register(&client->dev);
 	if (status)
 		goto out_err;
--- linux-3.2-rc2.orig/Documentation/i2c/ten-bit-addresses	2011-11-16 11:13:50.000000000 +0100
+++ linux-3.2-rc2/Documentation/i2c/ten-bit-addresses	2011-11-16 11:14:33.000000000 +0100
@@ -1,22 +1,24 @@
 The I2C protocol knows about two kinds of device addresses: normal 7 bit
 addresses, and an extended set of 10 bit addresses. The sets of addresses
 do not intersect: the 7 bit address 0x10 is not the same as the 10 bit
-address 0x10 (though a single device could respond to both of them). You
-select a 10 bit address by adding an extra byte after the address
-byte:
-  S Addr7 Rd/Wr ....
-becomes
-  S 11110 Addr10 Rd/Wr
-S is the start bit, Rd/Wr the read/write bit, and if you count the number
-of bits, you will see the there are 8 after the S bit for 7 bit addresses,
-and 16 after the S bit for 10 bit addresses.
+address 0x10 (though a single device could respond to both of them).
 
-WARNING! The current 10 bit address support is EXPERIMENTAL. There are
-several places in the code that will cause SEVERE PROBLEMS with 10 bit
-addresses, even though there is some basic handling and hooks. Also,
-almost no supported adapter handles the 10 bit addresses correctly.
+I2C messages to and from 10-bit address devices have a different format.
+See the I2C specification for the details.
 
-As soon as a real 10 bit address device is spotted 'in the wild', we
-can and will add proper support. Right now, 10 bit address devices
-are defined by the I2C protocol, but we have never seen a single device
-which supports them.
+The current 10 bit address support is minimal. It should work, however
+you can expect some problems along the way:
+* Not all bus drivers support 10-bit addresses. Some don't because the
+  hardware doesn't support them (SMBus doesn't require 10-bit address
+  support for example), some don't because nobody bothered adding the
+  code (or it's there but not working properly.) Software implementation
+  (i2c-algo-bit) is known to work.
+* Some optional features do not support 10-bit addresses. This is the
+  case of automatic detection and instantiation of devices by their,
+  drivers, for example.
+* Many user-space packages (for example i2c-tools) lack support for
+  10-bit addresses.
+
+Note that 10-bit address devices are still pretty rare, so the limitations
+listed above could stay for a long time, maybe even forever if nobody
+needs them to be fixed.


-- 
Jean Delvare
