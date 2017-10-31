From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v1 09/15] hwmon: (w83781d) Remove duplicate NULL check
Date: Tue, 31 Oct 2017 19:03:26 +0100
Message-ID: <20171031190326.28b828b1@endymion>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
        <20171031142149.32512-9-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54819 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932655AbdJaSD3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 14:03:29 -0400
In-Reply-To: <20171031142149.32512-9-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org

On Tue, 31 Oct 2017 16:21:43 +0200, Andy Shevchenko wrote:
> Since i2c_unregister_device() became NULL-aware we may remove duplicate
> NULL check.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hwmon/w83781d.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
> index 246fb2365126..2b0f182daa87 100644
> --- a/drivers/hwmon/w83781d.c
> +++ b/drivers/hwmon/w83781d.c
> @@ -1246,10 +1246,8 @@ w83781d_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  
>   exit_remove_files:
>  	w83781d_remove_files(dev);
> -	if (data->lm75[0])
> -		i2c_unregister_device(data->lm75[0]);
> -	if (data->lm75[1])
> -		i2c_unregister_device(data->lm75[1]);
> +	i2c_unregister_device(data->lm75[0]);
> +	i2c_unregister_device(data->lm75[1]);
>  	return err;
>  }
>  
> @@ -1262,10 +1260,8 @@ w83781d_remove(struct i2c_client *client)
>  	hwmon_device_unregister(data->hwmon_dev);
>  	w83781d_remove_files(dev);
>  
> -	if (data->lm75[0])
> -		i2c_unregister_device(data->lm75[0]);
> -	if (data->lm75[1])
> -		i2c_unregister_device(data->lm75[1]);
> +	i2c_unregister_device(data->lm75[0]);
> +	i2c_unregister_device(data->lm75[1]);
>  
>  	return 0;
>  }

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
