From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH]1/1 gpio-pca953x.c dynamic assignment and higher verbosity
Date: Tue, 4 Oct 2011 21:58:23 +0100
Message-ID: <20111004205823.GB13323@freya.fluff.org>
References: <4E8A2EE8.5090408@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4E8A2EE8.5090408-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 03, 2011 at 11:53:44PM +0200, Hartmut Knaack wrote:
> Hi there,
> this patch adds the following features to gpio-pca953x.c:
> - set gpiobase to auto (-1) in case no platform data or openfirmware
> config are provided
> - show some details about the registered gpio-chip in kernel log (highly
> inspired by gpio-pcf857x.c)
> Successfully tested on ar71xx (TL-WR1043ND). Please let me know if there
> is anything wrong. Otherwise, please add to kernel.

Please read Documentation/SubmittingPatches please. The patch is in the wrong
format and your Signed-off-by line seems to have an invalid email address.

Also, this is not the right list for drivers/gpio.
 
> Signed-off-by: Hartmut Knaack <knaack.h [at] gmx.de>
> 
> *** /home/mbs/kerneltest/gpio-pca953x.c	2011-10-02 23:33:22.743267705 +0200
> ---
> build_dir/linux-ar71xx_generic/linux-2.6.39.4/drivers/gpio/pca953x.c
> 2011-10-03 23:32:35.283870191 +0200
> *************** pca953x_get_alt_pdata(struct i2c_client
> *** 577,582 ****
> --- 577,583 ----
>   void
>   pca953x_get_alt_pdata(struct i2c_client *client, int *gpio_base, int
> *invert)
>   {
> +   *gpio_base = -1;	
>   }
>   #endif
> 
> *************** static int __devinit pca953x_probe(struc
> *** 685,692 ****
>   	ret = gpiochip_add(&chip->gpio_chip);
>   	if (ret)
>   		goto out_failed_irq;
> 
> ! 	if (pdata && pdata->setup) {
>   		ret = pdata->setup(client, chip->gpio_chip.base,
>   				chip->gpio_chip.ngpio, pdata->context);
>   		if (ret < 0)
> --- 686,700 ----
>   	ret = gpiochip_add(&chip->gpio_chip);
>   	if (ret)
>   		goto out_failed_irq;
> + 	
> + 	dev_info(&client->dev, "gpios %d..%d added on a %s%s\n",
> + 		chip->gpio_chip.base,
> + 		chip->gpio_chip.base + chip->gpio_chip.ngpio - 1,
> + 		client->name,
> + 		client->irq ? " (irq ignored)" : "");
> 
> !
> ! if (pdata && pdata->setup) {
>   		ret = pdata->setup(client, chip->gpio_chip.base,
>   				chip->gpio_chip.ngpio, pdata->context);
>   		if (ret < 0)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
