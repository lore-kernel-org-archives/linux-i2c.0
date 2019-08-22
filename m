From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] platform: chrome: chromeos_laptop: drop checks of
 NULL-safe functions
Date: Thu, 22 Aug 2019 21:41:29 +0200
Message-ID: <b6612ae3-9d6f-baf7-98db-f3d26f4a5108@collabora.com>
References: <20190820153449.7866-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820153449.7866-1-wsa+renesas@sang-engineering.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 20/8/19 17:34, Wolfram Sang wrote:
> No need to check the argument of i2c_unregister_device() and
> property_entries_free() because the functions do check it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for chrome-platform-5.4

Thanks,
 Enric

> ---
> Build tested only, buildbot is happy, too.
> 
> Please apply to your tree.
> 
>  drivers/platform/chrome/chromeos_laptop.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
> index 7abbb6167766..8723bcf10c93 100644
> --- a/drivers/platform/chrome/chromeos_laptop.c
> +++ b/drivers/platform/chrome/chromeos_laptop.c
> @@ -838,18 +838,14 @@ static void chromeos_laptop_destroy(const struct chromeos_laptop *cros_laptop)
>  		i2c_dev = &cros_laptop->i2c_peripherals[i];
>  		info = &i2c_dev->board_info;
>  
> -		if (i2c_dev->client)
> -			i2c_unregister_device(i2c_dev->client);
> -
> -		if (info->properties)
> -			property_entries_free(info->properties);
> +		i2c_unregister_device(i2c_dev->client);
> +		property_entries_free(info->properties);
>  	}
>  
>  	for (i = 0; i < cros_laptop->num_acpi_peripherals; i++) {
>  		acpi_dev = &cros_laptop->acpi_peripherals[i];
>  
> -		if (acpi_dev->properties)
> -			property_entries_free(acpi_dev->properties);
> +		property_entries_free(acpi_dev->properties);
>  	}
>  
>  	kfree(cros_laptop->i2c_peripherals);
> 
