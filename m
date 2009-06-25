From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-designware: Depend on HAVE_CLK
Date: Thu, 25 Jun 2009 12:04:49 +0200
Message-ID: <20090625120449.5cc636a6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Not all platforms implement the clk_*() function set, and the
i2c-designware driver can only be built when these functions are
available.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
 drivers/i2c/busses/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.31-rc1.orig/drivers/i2c/busses/Kconfig	2009-06-25 09:32:17.000000000 +0200
+++ linux-2.6.31-rc1/drivers/i2c/busses/Kconfig	2009-06-25 11:46:56.000000000 +0200
@@ -328,6 +328,7 @@ config I2C_DAVINCI
 
 config I2C_DESIGNWARE
 	tristate "Synopsys DesignWare"
+	depends on HAVE_CLK
 	help
 	  If you say yes to this option, support will be included for the
 	  Synopsys DesignWare I2C adapter. Only master mode is supported.


-- 
Jean Delvare
