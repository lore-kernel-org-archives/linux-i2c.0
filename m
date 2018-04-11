From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/4] eeprom: at24: don't assign the i2c ID table to
 at24_driver
Date: Wed, 11 Apr 2018 11:56:24 +0200
Message-ID: <390fac56-8656-ebbb-5405-0a44f1773157@axentia.se>
References: <20180410131206.25760-1-brgl@bgdev.pl>
 <20180410131206.25760-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180410131206.25760-2-brgl@bgdev.pl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sven Van Asbroeck <svendev@arcx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-04-10 15:12, Bartosz Golaszewski wrote:
> We switched to using probe_new(), so this is no longer used
> by i2c core.

It seems to be used in i2c_device_match() ???

This could easily be me not understanding something...

Cheers,
Peter

> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/misc/eeprom/at24.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 0c125f207aea..2310f26ac4f3 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -737,7 +737,6 @@ static struct i2c_driver at24_driver = {
>  	},
>  	.probe_new = at24_probe,
>  	.remove = at24_remove,
> -	.id_table = at24_ids,
>  };
>  
>  static int __init at24_init(void)
> 
