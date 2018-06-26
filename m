From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 2/2] eeprom: at24: Add support for address-width
 property
Date: Tue, 26 Jun 2018 09:47:36 +0300
Message-ID: <20180626064736.msxcnsi5rsnxp62k@kekkonen.localdomain>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
 <1529994128-26770-3-git-send-email-alanx.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1529994128-26770-3-git-send-email-alanx.chiang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alanx.chiang@intel.com
Cc: linux-i2c@vger.kernel.org, andy.yeh@intel.com, andriy.shevchenko@intel.com, rajmohan.mani@intel.com, andy.shevchenko@gmail.com, brgl@bgdev.pl, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Alan,

On Tue, Jun 26, 2018 at 02:22:08PM +0800, alanx.chiang@intel.com wrote:
> From: "alanx.chiang" <alanx.chiang@intel.com>
> 
> Provide a flexible way to determine the addressing bits of eeprom.
> Pass the addressing bits to driver through address-width property.
> 
> Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> 
> ---
> since v1
> -- Add a warn message for 8-bit addressing.
> 
> ---
>  drivers/misc/eeprom/at24.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 0c125f2..231afcd 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -478,6 +478,22 @@ static void at24_properties_to_pdata(struct device *dev,
>  	if (device_property_present(dev, "no-read-rollover"))
>  		chip->flags |= AT24_FLAG_NO_RDROL;
>  
> +	err = device_property_read_u32(dev, "address-width", &val);
> +	if (!err) {
> +		switch (val) {
> +		case 8:
> +			chip->flags &= ~AT24_FLAG_ADDR16;
> +			dev_warn(dev, "address-width is 8, clear the ADD16 bit\n");

Even though the default is 8 address bits, I don't see a need to issue a
warning if the address-width property sets that to 8 explicitly. I.e. only
warn if the flag was set.

> +			break;
> +		case 16:
> +			chip->flags |= AT24_FLAG_ADDR16;
> +			break;
> +		default:
> +			dev_warn(dev, "Bad \"address-width\" property: %u\n",
> +				 val);
> +		}
> +	}
> +
>  	err = device_property_read_u32(dev, "size", &val);
>  	if (!err)
>  		chip->byte_len = val;

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
