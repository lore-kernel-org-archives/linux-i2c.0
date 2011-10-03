From: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH]1/1 gpio-pca953x.c dynamic assignment and higher verbosity
Date: Mon, 03 Oct 2011 23:53:44 +0200
Message-ID: <4E8A2EE8.5090408@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi there,
this patch adds the following features to gpio-pca953x.c:
- set gpiobase to auto (-1) in case no platform data or openfirmware
config are provided
- show some details about the registered gpio-chip in kernel log (highly
inspired by gpio-pcf857x.c)
Successfully tested on ar71xx (TL-WR1043ND). Please let me know if there
is anything wrong. Otherwise, please add to kernel.

Signed-off-by: Hartmut Knaack <knaack.h [at] gmx.de>

*** /home/mbs/kerneltest/gpio-pca953x.c	2011-10-02 23:33:22.743267705 +0200
---
build_dir/linux-ar71xx_generic/linux-2.6.39.4/drivers/gpio/pca953x.c
2011-10-03 23:32:35.283870191 +0200
*************** pca953x_get_alt_pdata(struct i2c_client
*** 577,582 ****
--- 577,583 ----
  void
  pca953x_get_alt_pdata(struct i2c_client *client, int *gpio_base, int
*invert)
  {
+   *gpio_base = -1;	
  }
  #endif

*************** static int __devinit pca953x_probe(struc
*** 685,692 ****
  	ret = gpiochip_add(&chip->gpio_chip);
  	if (ret)
  		goto out_failed_irq;

! 	if (pdata && pdata->setup) {
  		ret = pdata->setup(client, chip->gpio_chip.base,
  				chip->gpio_chip.ngpio, pdata->context);
  		if (ret < 0)
--- 686,700 ----
  	ret = gpiochip_add(&chip->gpio_chip);
  	if (ret)
  		goto out_failed_irq;
+ 	
+ 	dev_info(&client->dev, "gpios %d..%d added on a %s%s\n",
+ 		chip->gpio_chip.base,
+ 		chip->gpio_chip.base + chip->gpio_chip.ngpio - 1,
+ 		client->name,
+ 		client->irq ? " (irq ignored)" : "");

!
! if (pdata && pdata->setup) {
  		ret = pdata->setup(client, chip->gpio_chip.base,
  				chip->gpio_chip.ngpio, pdata->context);
  		if (ret < 0)
