From: Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
Date: Thu, 10 Jan 2019 00:47:56 +0300
Message-ID: <20190109214756.GA18115@jeknote.loshitsa1.net>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 19, 2018 at 09:59:58AM +0100, Charles Keepax wrote:
> The IRQ will be mapped in i2c_device_probe only if client->irq is zero and
> i2c_device_remove does not clear this. When rebinding an I2C device,
> whos IRQ provider has also been rebound this means that an IRQ mapping
> will never be created, causing the I2C device to fail to acquire its
> IRQ. Fix this issue by clearing client->irq in i2c_device_remove,
> forcing i2c_device_probe to lookup the mapping again.

Hi.

I found  driver i2c/busses/i2c-cht-wc.c which instantiates I2C device
(battery charger) and passes IRQ to driver not using standard I2C IRQ mapping code.
So if we reprobe I2C device (by reloading I2C device driver module or by
manipulations with sysfs), we get invalid IRQ number for client:

 adap->client_irq = irq_create_mapping(adap->irq_domain, 0);
 ...
 irq_set_chip_data(adap->client_irq, adap);
 irq_set_chip_and_handler(adap->client_irq, &adap->irqchip, handle_simple_irq);
 ...
 board_info.irq = adap->client_irq;
 adap->client = i2c_new_device(&adap->adapter, &board_info);


adap->client->irq will be reset after device removing here.


Any advice to fix this? Maybe move initial i2c_client->irq value to new field
like client->init_irq and copy it to client->irq at probing, for example?

> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/i2c/i2c-core-base.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 656f0a6fe3adf..28460f6a60cc1 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -430,6 +430,8 @@ static int i2c_device_remove(struct device *dev)
>  	dev_pm_clear_wake_irq(&client->dev);
>  	device_init_wakeup(&client->dev, false);
>  
> +	client->irq = 0;
> +
>  	return status;
>  }
>  

-- 
Yauhen Kharuzhy
