From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] i2c-cht-wc: Add locking to interrupt / smbus_xfer
 functions
Date: Mon, 14 Aug 2017 23:35:59 +0300
Message-ID: <1502742959.25945.3.camel@linux.intel.com>
References: <20170814201726.21045-1-hdegoede@redhat.com>
         <20170814201726.21045-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:28427 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752031AbdHNUmC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 16:42:02 -0400
In-Reply-To: <20170814201726.21045-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On Mon, 2017-08-14 at 22:17 +0200, Hans de Goede wrote:
> Although unlikely without locking the smbux_xfer function may miss
> the nack flag and further fixes in this patch-set add some more
> complex constructions which need protection.
 
> -	if (read_write == I2C_SMBUS_READ) {
> +	ret = 0;
> +	mutex_lock(&adap->adap_lock);
> +	if (adap->nack)
> +		ret = -EIO;
> +	else if (read_write == I2C_SMBUS_READ) {
>  		ret = regmap_read(adap->regmap, CHT_WC_I2C_RDDATA,
> &reg);
> -		if (ret)
> -			return ret;
> -

>  		data->byte = reg;

Can this be moved out to keep logic the same (don't dirt data on error)?

>  	}
> +	mutex_unlock(&adap->adap_lock);
>  
> -	return 0;
> +	return ret;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
