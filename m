From: Jean Delvare <khali@linux-fr.org>
Subject: Re: linux-next: Tree for Aug 3 (drivers/i2c/busses/i2c-i801.c)
Date: Fri, 3 Aug 2012 21:57:17 +0200
Message-ID: <20120803215717.31376eb7@endymion.delvare>
References: <20120803135110.0ba0e51758021b6a4ed9d1e9@canb.auug.org.au>
	<501C0952.5050609@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <501C0952.5050609@xenotime.net>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mark Studebaker <mdsxyz123@yahoo.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Randy,

On Fri, 03 Aug 2012 10:24:34 -0700, Randy Dunlap wrote:
> on x86_64:
> 
> when CONFIG_GPIOLIB is not enabled:
> 
> drivers/i2c/busses/i2c-i801.c: In function 'match_gpio_chip_by_label':
> drivers/i2c/busses/i2c-i801.c:1011:21: error: dereferencing pointer to incomplete type
> drivers/i2c/busses/i2c-i801.c: In function 'i801_add_mux':
> drivers/i2c/busses/i2c-i801.c:1028:2: error: implicit declaration of function 'gpiochip_find'
> drivers/i2c/busses/i2c-i801.c:1028:7: warning: assignment makes pointer from integer without a cast
> drivers/i2c/busses/i2c-i801.c:1047:27: error: dereferencing pointer to incomplete type
> drivers/i2c/busses/i2c-i801.c: In function 'match_gpio_chip_by_label':
> drivers/i2c/busses/i2c-i801.c:1012:1: warning: control reaches end of non-void function

Good catch, thanks for reporting. I'll fold the following in the
offending patch, that should fix it:

--- linux-3.6-rc0.orig/drivers/i2c/busses/Kconfig	2012-08-03 21:51:51.000000000 +0200
+++ linux-3.6-rc0/drivers/i2c/busses/Kconfig	2012-08-03 21:52:18.090537018 +0200
@@ -80,6 +80,7 @@ config I2C_I801
 	tristate "Intel 82801 (ICH/PCH)"
 	depends on PCI
 	select CHECK_SIGNATURE if X86 && DMI
+	select GPIOLIB if I2C_MUX
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  801 family of mainboard I2C interfaces.  Specifically, the following


-- 
Jean Delvare
