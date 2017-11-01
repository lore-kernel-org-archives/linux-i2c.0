From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 09/15] hwmon: (w83781d) Remove duplicate NULL check
Date: Wed, 1 Nov 2017 06:19:42 -0700
Message-ID: <4b621f23-f251-7fa6-c79c-059b48f27345@roeck-us.net>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
 <20171031142149.32512-9-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:54081 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdKANTo (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 1 Nov 2017 09:19:44 -0400
In-Reply-To: <20171031142149.32512-9-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org

On 10/31/2017 07:21 AM, Andy Shevchenko wrote:
> Since i2c_unregister_device() became NULL-aware we may remove duplicate
> NULL check.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'll keep the hwmon patches from this series on hold until the changes
to i2c_unregister_device make it into the tree. Ok with me if the patches
are merged through some other tree.

Guenter

> ---
>   drivers/hwmon/w83781d.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
> index 246fb2365126..2b0f182daa87 100644
> --- a/drivers/hwmon/w83781d.c
> +++ b/drivers/hwmon/w83781d.c
> @@ -1246,10 +1246,8 @@ w83781d_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   
>    exit_remove_files:
>   	w83781d_remove_files(dev);
> -	if (data->lm75[0])
> -		i2c_unregister_device(data->lm75[0]);
> -	if (data->lm75[1])
> -		i2c_unregister_device(data->lm75[1]);
> +	i2c_unregister_device(data->lm75[0]);
> +	i2c_unregister_device(data->lm75[1]);
>   	return err;
>   }
>   
> @@ -1262,10 +1260,8 @@ w83781d_remove(struct i2c_client *client)
>   	hwmon_device_unregister(data->hwmon_dev);
>   	w83781d_remove_files(dev);
>   
> -	if (data->lm75[0])
> -		i2c_unregister_device(data->lm75[0]);
> -	if (data->lm75[1])
> -		i2c_unregister_device(data->lm75[1]);
> +	i2c_unregister_device(data->lm75[0]);
> +	i2c_unregister_device(data->lm75[1]);
>   
>   	return 0;
>   }
> 
