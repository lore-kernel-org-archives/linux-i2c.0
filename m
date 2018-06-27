From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 2/2] eeprom: at24: Add support for address-width
 property
Date: Wed, 27 Jun 2018 10:46:19 +0300
Message-ID: <20180627074618.65wcohw5fohbu7cv@paasikivi.fi.intel.com>
References: <1530078385-1546-1-git-send-email-alanx.chiang@intel.com>
 <1530078385-1546-3-git-send-email-alanx.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530078385-1546-3-git-send-email-alanx.chiang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alanx.chiang@intel.com
Cc: linux-i2c@vger.kernel.org, andy.yeh@intel.com, andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com, rajmohan.mani@intel.com, andy.shevchenko@gmail.com, tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 27, 2018 at 01:46:25PM +0800, alanx.chiang@intel.com wrote:
> From: Alan Chiang <alanx.chiang@intel.com>
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
> since v2
> -- Modify the warning message for clear.
> -- Move the clearing bit operation outside of a statement.
> 
> ---
>  drivers/misc/eeprom/at24.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 0c125f2..d606f3b 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -478,6 +478,24 @@ static void at24_properties_to_pdata(struct device *dev,
>  	if (device_property_present(dev, "no-read-rollover"))
>  		chip->flags |= AT24_FLAG_NO_RDROL;
>  
> +	err = device_property_read_u32(dev, "address-width", &val);
> +	if (!err) {
> +		switch (val) {
> +		case 8:
> +			if (chip->flags & AT24_FLAG_ADDR16)
> +				dev_warn(dev, "Override address width to be 8,"
> +					 "while default is 16\n");

Please don't wrap strings --- it breaks grep. Exceeding 80 is ok in this
case.

> +			chip->flags &= ~AT24_FLAG_ADDR16;
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
> -- 
> 2.7.4
> 

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
