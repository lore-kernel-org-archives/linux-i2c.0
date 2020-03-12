From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH] i2c: acpi: put device when verifying client fails
Date: Thu, 12 Mar 2020 17:14:50 +0200
Message-ID: <20200312151450.GZ1922688@smile.fi.intel.com>
References: <20200312133244.9564-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200312133244.9564-1-wsa@the-dreams.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 12, 2020 at 02:32:44PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> i2c_verify_client() can fail, so we need to put the device when that
> happens.

I hope it's not a CoVID-19 makes me mistakenly commented in the first place. :-)

So, theoretically below is possible, but practically it's doubtful.

The I2CSerialBusV2() ACPI resource can be present solely in I²C slave device
nodes according to the specification. However, we might have two possible cases
a) screwed up ACPI table;
b) I²C master which in turn is I²C slave.

While a) has been so far unseen, b) case sounds like plasible for I²C muxes IIUC.

So, I agree with the patch, and sorry for the first reaction.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 525e6fabeae2 ("i2c / ACPI: add support for ACPI reconfigure notifications")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> RFC because I don't know if it can be that the returned dev is not an
> i2c_client. Yet, since it can happen theoretically, I think we should
> have the checks.
> 
>  drivers/i2c/i2c-core-acpi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 8f3dbc97a057..8b0ff780919b 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -394,9 +394,17 @@ EXPORT_SYMBOL_GPL(i2c_acpi_find_adapter_by_handle);
>  static struct i2c_client *i2c_acpi_find_client_by_adev(struct acpi_device *adev)
>  {
>  	struct device *dev;
> +	struct i2c_client *client;
>  
>  	dev = bus_find_device_by_acpi_dev(&i2c_bus_type, adev);
> -	return dev ? i2c_verify_client(dev) : NULL;
> +	if (!dev)
> +		return NULL;
> +
> +	client = i2c_verify_client(dev);
> +	if (!client)
> +		put_device(dev);
> +
> +	return client;
>  }
>  
>  static int i2c_acpi_notify(struct notifier_block *nb, unsigned long value,
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko
