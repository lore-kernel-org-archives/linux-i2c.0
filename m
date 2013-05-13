From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: core: make it possible to match a pure device tree
 driver
Date: Mon, 13 May 2013 09:16:37 +0200
Message-ID: <20130513071637.GD32299@pengutronix.de>
References: <1368397583-22769-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1368397583-22769-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

On Mon, May 13, 2013 at 12:26:23AM +0200, Linus Walleij wrote:
> Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> I would need some device tree core people to confirm that I am
> on the right track with this. I was soooo confused when I found
> that .of_match_table could not be used with I2C devices...
> ---
>  drivers/i2c/i2c-core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 6b63cc7..30b5bb2 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -240,7 +240,7 @@ static int i2c_device_probe(struct device *dev)
>  		return 0;
>  
>  	driver = to_i2c_driver(dev->driver);
> -	if (!driver->probe || !driver->id_table)
> +	if (!driver->probe || (!driver->id_table && !dev->driver->of_match_table))
>  		return -ENODEV;
>  	client->driver = driver;
>  	if (!device_can_wakeup(&client->dev))
> @@ -248,7 +248,12 @@ static int i2c_device_probe(struct device *dev)
>  					client->flags & I2C_CLIENT_WAKE);
>  	dev_dbg(dev, "probe\n");
>  
> -	status = driver->probe(client, i2c_match_id(driver->id_table, client));
> +	if (dev->driver->of_match_table)
> +		/* Device tree matching */
> +		status = driver->probe(client, NULL);
> +	else
> +		/* Fall back to matching the id_table */
> +		status = driver->probe(client, i2c_match_id(driver->id_table, client));

If you correctly register a device with "vendor,product" in the devicetree
the driver can already fetch the of_device_id using of_match_device(dt_ids, &client->dev)
just like a platform driver would do aswell.

i2c_match_id will return a NULL pointer if called with "vendor,product",
because nothing matches in the drivers id_table, so for this case you
change nothing.

If anything, you introduce the problem that a devicetree capable driver
no longer gets a i2c_device_id if the device was instantiated with
i2c_board_info.

See how the mc13xxx driver does it:

	if (client->dev.of_node) {
		const struct of_device_id *of_id =
			of_match_device(mc13xxx_dt_ids, &client->dev);
		mc13xxx->variant = of_id->data;
	} else {
		mc13xxx->variant = (void *)id->driver_data;
	}

This works.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
