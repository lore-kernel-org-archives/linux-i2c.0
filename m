From: Yegor Yefremov <yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Subject: [PATCH] Documentation: EEPROM: add kernel side usage description
Date: Wed, 25 Jan 2012 12:12:16 +0100
Message-ID: <4F1FE390.6040903@visionsystems.de>
Reply-To: yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

add EEPROM usage instructions and example for kernel side.
dm644x-evm was taken as example.

Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 Documentation/misc-devices/eeprom |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

Index: b/Documentation/misc-devices/eeprom
===================================================================
--- a/Documentation/misc-devices/eeprom
+++ b/Documentation/misc-devices/eeprom
@@ -90,7 +90,41 @@
 
 Use:
 
+1. Userland
+
 After inserting the module (and any other required SMBus/i2c modules), you
 should have some EEPROM directories in /sys/bus/i2c/devices/* of names such
 as "0-0050". Inside each of these is a series of files, the eeprom file
 contains the binary data from EEPROM.
+
+2. Kernel
+
+It is also possible to read/write EEPROM from kernel side. at24.c provides two
+routines at24_macc_read() and at24_macc_write(). Those routines can be used
+as part of setup() routine, when configuring platform data for i2c EEPROM.
+
+Example:
+
+arch/arm/mach-davinci/board-dm644x-evm.c uses EEPROM to store MAC address.
+This is how EEPROM platform data will be set up:
+
+static struct at24_platform_data eeprom_info = {
+	.byte_len	= (256*1024) / 8,
+	.page_size	= 64,
+	.flags		= AT24_FLAG_ADDR16,
+	.setup          = davinci_get_mac_addr,
+	.context	= (void *)0x7f00,
+};
+
+davinci_get_mac_addr() will be called from at24_probe() and fetches the MAC
+address from specified offset:
+
+void davinci_get_mac_addr(struct memory_accessor *mem_acc, void *context)
+{
+	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
+	off_t offset = (off_t)context;
+
+	/* Read MAC addr from EEPROM */
+	if (mem_acc->read(mem_acc, mac_addr, offset, ETH_ALEN) == ETH_ALEN)
+		pr_info("Read MAC addr from EEPROM: %pM\n", mac_addr);
+}
