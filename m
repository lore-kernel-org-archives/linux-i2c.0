From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1] i2c: core: Allow empty id_table in ACPI case as well
Date: Thu, 6 Jul 2017 20:05:44 +0200
Message-ID: <248f12b6-28b0-a9b8-9215-f13a59915e15@redhat.com>
References: <20170706180140.49391-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170706180140.49391-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Hi,

Thank you for doing this.

On 06-07-17 20:01, Andy Shevchenko wrote:
> For now empty ID table is not allowed with ACPI and prevents driver to be
> probed.
> 
> Add a check to allow empty ID table.
> 
> Fixes: da10c06a044b ("i2c: Make I2C ID tables non-mandatory for DT'ed devices")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/i2c/i2c-core-base.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index c89dac7fd2e7..45231d2257ad 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -354,9 +354,10 @@ static int i2c_device_probe(struct device *dev)
>   
>   	/*
>   	 * An I2C ID table is not mandatory, if and only if, a suitable Device
> -	 * Tree match table entry is supplied for the probing device.
> +	 * Tree or ACPI match table entry is supplied for the probing device.
>   	 */
>   	if (!driver->id_table &&
> +	    !acpi_match_device(dev->driver->acpi_match_table, &client->dev) &&
>   	    !i2c_of_match_device(dev->driver->of_match_table, client))
>   		return -ENODEV;
>   
> 
