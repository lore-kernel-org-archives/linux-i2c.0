From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 4/5] i2c: core: Move ACPI gpio IRQ handling into
 i2c_acpi_get_irq
Date: Tue, 21 May 2019 14:37:01 +0300
Message-ID: <20190521113701.GY2781@lahna.fi.intel.com>
References: <20190520084936.10590-1-ckeepax@opensource.cirrus.com>
 <20190520084936.10590-5-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190520084936.10590-5-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Mon, May 20, 2019 at 09:49:35AM +0100, Charles Keepax wrote:
> It makes sense to contain all the ACPI IRQ handling in a single helper
> function.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Note that this one is somewhat interesting, it seems the search
> through the resource list is done against the companion device
> of the adapter but the GPIO search is done against the companion
> device of the client. It feels to me like these really should
> be done on the same device, and certainly this is what SPI
> does (both against the equivalent of the adapter). Perhaps
> someone with more ACPI knowledge than myself could comment?

What GPIO search you mean? I did not find any ACPI specific GPIO lookup
in the i2c-core-acpi/base files.

> Thanks,
> Charles
> 
>  drivers/i2c/i2c-core-acpi.c | 3 +++
>  drivers/i2c/i2c-core-base.c | 4 ----
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index e332760bf9ebc..0c882d956e9a4 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -164,6 +164,9 @@ int i2c_acpi_get_irq(struct i2c_client *client, int *irq)

Maybe worth adding kernel-doc explaining what the function does if it
does not have already.

>  
>  	acpi_dev_free_resource_list(&resource_list);
>  
> +	if (*irq < 0)
> +		*irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(&client->dev), 0);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index c1afa17a76bfc..f958b50c78c04 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -336,10 +336,6 @@ static int i2c_device_probe(struct device *dev)
>  				irq = of_irq_get(dev->of_node, 0);
>  		} else if (ACPI_COMPANION(dev)) {
>  			i2c_acpi_get_irq(client, &irq);

I think we should check and handle possible error here.

> -
> -			if (irq == -ENOENT)
> -				irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev),
> -							    0);
>  		}
>  		if (irq == -EPROBE_DEFER)
>  			return irq;
> -- 
> 2.11.0
