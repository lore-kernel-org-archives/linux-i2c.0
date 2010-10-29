From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH -next] i2c: intel-mid depends on PCI
Date: Fri, 29 Oct 2010 13:37:09 -0700
Message-ID: <20101029133709.5e5df4ad.randy.dunlap@oracle.com>
References: <20101029121148.d27e03bc.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101029121148.d27e03bc.sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, akpm <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Ba Zheng <zheng.ba-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

i2c-intel-mid driver uses PCI data structs and interfaces,
so it should depend on PCI.  Fixes these build errors:

drivers/i2c/busses/i2c-intel-mid.c:977: error: implicit declaration of function 'pci_request_region'
drivers/i2c/busses/i2c-intel-mid.c:1077: error: implicit declaration of function 'pci_release_region'

Signed-off-by: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Ba Zheng <zheng.ba-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/i2c/busses/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20101029.orig/drivers/i2c/busses/Kconfig
+++ linux-next-20101029/drivers/i2c/busses/Kconfig
@@ -398,6 +398,7 @@ config I2C_IMX
 
 config I2C_INTEL_MID
 	tristate "Intel Moorestown/Medfield Platform I2C controller"
+	depends on PCI
 	help
 	  Say Y here if you have an Intel Moorestown/Medfield platform I2C
 	  controller.
