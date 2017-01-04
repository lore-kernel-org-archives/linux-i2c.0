From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Wed, 4 Jan 2017 18:46:19 +0100
Message-ID: <20170104174619.feke27q3ehwkylfs@ninjato>
References: <20170104090522.GN5767@mail.corp.redhat.com>
 <20170104091845.GB3499@pali>
 <20170104101306.GR5767@mail.corp.redhat.com>
 <20170104102118.GD3499@pali>
 <20170104103233.GT5767@mail.corp.redhat.com>
 <20170104112223.GE3499@pali>
 <20170104120031.GG3499@pali>
 <20170104130252.GV5767@mail.corp.redhat.com>
 <20170104160643.GH3499@pali>
 <20170104173928.GW5767@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170104173928.GW5767@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


> How about:
> ---
> From daa7571bbf337704332c0cfeec9b8fd5aeae596f Mon Sep 17 00:00:00 2001
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Date: Wed, 4 Jan 2017 18:26:54 +0100
> Subject: [PATCH] I2C: add the source of the IRQ in struct i2c_client
> 
> With commit 4d5538f5882a ("i2c: use an IRQ to report Host Notify events,
> not alert"), the IRQ provided in struct i2c_client might be assigned while
> it has not been explicitly declared by either the platform information
> or OF or ACPI.
> Some drivers (lis3lv02d) rely on the fact that the IRQ gets assigned or
> not to trigger a different behavior (exposing /dev/freefall in this case).
> 
> Provide a way for others to know who set the IRQ and so they can behave
> accordingly.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/i2c/i2c-core.c |  7 +++++++
>  include/linux/i2c.h    | 11 +++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index cf9e396..226c75d 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -935,8 +935,12 @@ static int i2c_device_probe(struct device *dev)
>  			irq = of_irq_get_byname(dev->of_node, "irq");
>  			if (irq == -EINVAL || irq == -ENODATA)
>  				irq = of_irq_get(dev->of_node, 0);
> +			if (irq > 0)
> +				client->irq_source = I2C_IRQ_SOURCE_OF;
>  		} else if (ACPI_COMPANION(dev)) {
>  			irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
> +			if (irq > 0)
> +				client->irq_source = I2C_IRQ_SOURCE_ACPI;
>  		}
>  		if (irq == -EPROBE_DEFER)
>  			return irq;
> @@ -947,6 +951,8 @@ static int i2c_device_probe(struct device *dev)
>  		if (irq < 0) {
>  			dev_dbg(dev, "Using Host Notify IRQ\n");
>  			irq = i2c_smbus_host_notify_to_irq(client);
> +			if (irq > 0)
> +				client->irq_source = I2C_IRQ_SOURCE_HOST_NOTIFY;
>  		}
>  		if (irq < 0)
>  			irq = 0;
> @@ -1317,6 +1323,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
>  	client->flags = info->flags;
>  	client->addr = info->addr;
>  	client->irq = info->irq;
> +	client->irq_source = I2C_IRQ_SOURCE_PLATFORM;
>  
>  	strlcpy(client->name, info->type, sizeof(client->name));
>  
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index b2109c5..7d0368d 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -213,6 +213,13 @@ struct i2c_driver {
>  };
>  #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
>  
> +enum i2c_irq_source {
> +	I2C_IRQ_SOURCE_PLATFORM,
> +	I2C_IRQ_SOURCE_OF,
> +	I2C_IRQ_SOURCE_ACPI,
> +	I2C_IRQ_SOURCE_HOST_NOTIFY,
> +};
> +
>  /**
>   * struct i2c_client - represent an I2C slave device
>   * @flags: I2C_CLIENT_TEN indicates the device uses a ten bit chip address;
> @@ -227,6 +234,9 @@ struct i2c_driver {
>   *	userspace_devices list
>   * @slave_cb: Callback when I2C slave mode of an adapter is used. The adapter
>   *	calls it to pass on slave events to the slave driver.
> + * @irq_source: Enum which provides the source of the IRQ. Useful to know
> + * 	if the IRQ was issued from Host Notify or if it was provided by an other
> + * 	component.

I'd think some documentation somewhere makes sense why we need to
distinguish this in some cases?

>   *
>   * An i2c_client identifies a single device (i.e. chip) connected to an
>   * i2c bus. The behaviour exposed to Linux is defined by the driver
> @@ -245,6 +255,7 @@ struct i2c_client {
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
>  	i2c_slave_cb_t slave_cb;	/* callback for slave mode	*/
>  #endif
> +	enum i2c_irq_source irq_source;	/* which component assigned the irq */
>  };
>  #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
> 
> Dmitry, Wolfram, Jean, would this be acceptable for you?

Adding something to i2c_driver is not exactly cheap, but from what I
glimpsed from this thread, this is one of the cleanest solution to this
problem?
