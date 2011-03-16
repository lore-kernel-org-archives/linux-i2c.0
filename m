From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] i2c: designware-pcidrv depends on PCI
Date: Wed, 16 Mar 2011 11:38:55 -0700
Message-ID: <20110316113855.ec5410c7.randy.dunlap@oracle.com>
References: <20110316191444.d91a3263.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20110316191444.d91a3263.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Baruch Siach <baruch@tkos.co.il>, linux-i2c@vger.kernel.org
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, khali@linux-fr.org, ben-linux@fluff.org
List-Id: linux-i2c@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

i2c-designware-pcidrv is a PCI driver and should depend on PCI.
Fixes these build errors:

drivers/i2c/busses/i2c-designware-pcidrv.c:256: error: implicit declaration of function 'pci_request_region'
drivers/i2c/busses/i2c-designware-pcidrv.c:338: error: implicit declaration of function 'pci_release_region'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Baruch Siach <baruch@tkos.co.il>
---
 drivers/i2c/busses/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20110316.orig/drivers/i2c/busses/Kconfig
+++ linux-next-20110316/drivers/i2c/busses/Kconfig
@@ -359,6 +359,7 @@ config I2C_DESIGNWARE_PLATFORM
 
 config I2C_DESIGNWARE_PCI
 	tristate "Synopsys DesignWare PCI"
+	depends on PCI
 	help
 	  If you say yes to this option, support will be included for the
 	  Synopsys DesignWare I2C adapter. Only master mode is supported.
