From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Need to use a I2C EEPROM on normal x86 architecture
Date: Thu, 23 Jun 2011 11:10:16 +0200
Message-ID: <20110623111016.368a7ca5@endymion.delvare>
References: <BANLkTimfbe4ntzzTu0SXJothK1N56m1ghA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTimfbe4ntzzTu0SXJothK1N56m1ghA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Christian,

On Tue, 21 Jun 2011 13:54:52 +0200, Christian Gmeiner wrote:
> Hi community,
> 
> I am working on an embedded x86 device, which has an at24 based
> eeprom. I am using
> the i2c_eg20t driver to access the i2c bus. To be able to access the
> eeprom in a separated
> driver I did this:
> 
> /* technical description of our used EEPROM */
> static struct at24_platform_data custom_i2c_eeprom_info = {
> 	.byte_len	= EEPROM_BYTE_LEN,
> 	.page_size	= 16,
> 	.flags		= 0,

Note that you don't have to mention struct members with value 0 (or
NULL), as this is the default.

> 	.setup		= content_read,
> 	.context	= NULL,
> };
> 
> /* EEPROM at24 */
> static struct i2c_board_info __initdata i2c_info[] =  {
> 	{
> 		I2C_BOARD_INFO("24c04", 0x50),
> 		.platform_data	= &custom_i2c_eeprom_info,
> 	},
> };
> 
> In the init function of my custom driver I do this:
> 
> 	/* register known devices on i2c bus */
> 	status = i2c_register_board_info(0, i2c_info, ARRAY_SIZE(i2c_info))

Out of curiosity, where did you put this code? Does x86 finally support
per-machine initialization as e.g. arm does?

> 
> Now I run in some troubles... see
> http://www.spinics.net/lists/linux-i2c/msg02022.html

I see that I already replied to this post...

> What options do I have to get this running? I could use
> i2c_add_numbered_adapter, but I don't
> want to touch too much from mainline kernel sources.

It seems difficult to use i2c_add_numbered_adapter() unconditionally, as
i2c-eg20t is a PCI driver so you don't get to pass platform data to it.
Furthermore, i2c_add_numbered_adapter() is only suitable if machine
setup code could be run before any device driver is initialized;
otherwise odds are that another driver will have picked the i2c bus
number you wanted. I am unsure if this is possible at all on x86 at the
moment.

The way I would do it is from i2c-eg20t itself. Take a look at i2c-i801
for an example: at the end of the probe function, there is
hardware-specific code to instantiate a few I2C devices. If you have a
way to uniquely, reliably detect that you are running on your specific
target system, you can do the same.

I don't think it is particularly nice, BTW, but this is the only way I
found so far with what the i2c subsystem core offers. If anyone has
suggestions how to improve this, please speak up.

If you want to be able to use i2c_add_numbered_adapter() conditionally
without the help of platform data, then you need a hint from i2c-core.
Would the following patch help you? If it does, and others show
interest, and there are no objections, this could go upstream in kernel
3.1.

---
 drivers/i2c/busses/i2c-eg20t.c |    7 ++++++-
 drivers/i2c/i2c-boardinfo.c    |   20 ++++++++++++++++++++
 include/linux/i2c.h            |    5 +++++
 3 files changed, 31 insertions(+), 1 deletion(-)

--- linux-3.0-rc4.orig/drivers/i2c/i2c-boardinfo.c	2011-05-20 10:42:40.000000000 +0200
+++ linux-3.0-rc4/drivers/i2c/i2c-boardinfo.c	2011-06-23 10:15:56.000000000 +0200
@@ -90,3 +90,23 @@ i2c_register_board_info(int busnum,
 
 	return status;
 }
+
+/**
+ * i2c_adapter_is_static - let drivers know if their bus is static
+ * @busnum: identifies the bus
+ *
+ * After calling this function, i2c bus drivers can decide whether
+ * to call i2c_add_adapter or i2c_add_numbered_adapter.
+ */
+int
+i2c_adapter_is_static(int busnum)
+{
+	int is_static;
+
+	down_write(&__i2c_board_lock);
+	is_static = busnum < __i2c_first_dynamic_bus_num;
+	up_write(&__i2c_board_lock);
+
+	return is_static;
+}
+EXPORT_SYMBOL_GPL(i2c_adapter_is_static);
--- linux-3.0-rc4.orig/include/linux/i2c.h	2011-06-21 10:32:32.000000000 +0200
+++ linux-3.0-rc4/include/linux/i2c.h	2011-06-23 09:58:21.000000000 +0200
@@ -306,6 +306,7 @@ extern void i2c_unregister_device(struct
 extern int
 i2c_register_board_info(int busnum, struct i2c_board_info const *info,
 			unsigned n);
+extern int i2c_adapter_is_static(int busnum);
 #else
 static inline int
 i2c_register_board_info(int busnum, struct i2c_board_info const *info,
@@ -313,6 +314,10 @@ i2c_register_board_info(int busnum, stru
 {
 	return 0;
 }
+static inline int i2c_adapter_is_static(int busnum)
+{
+	return 0;
+}
 #endif /* I2C_BOARDINFO */
 
 /*
--- linux-3.0-rc4.orig/drivers/i2c/busses/i2c-eg20t.c	2011-05-30 20:45:09.000000000 +0200
+++ linux-3.0-rc4/drivers/i2c/busses/i2c-eg20t.c	2011-06-23 10:48:26.000000000 +0200
@@ -787,7 +787,12 @@ static int __devinit pch_i2c_probe(struc
 
 		pch_adap->dev.parent = &pdev->dev;
 
-		ret = i2c_add_adapter(pch_adap);
+		if (i2c_adapter_is_static(i)) {
+			/* We assume that a single PCI device is present */
+			pch_adap->nr = i;
+			ret = i2c_add_numbered_adapter(pch_adap);
+		} else
+			ret = i2c_add_adapter(pch_adap);
 		if (ret) {
 			pch_pci_err(pdev, "i2c_add_adapter[ch:%d] FAILED\n", i);
 			goto err_i2c_add_adapter;



-- 
Jean Delvare
