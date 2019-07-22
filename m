From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] hwmon: smm665: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 11:29:08 -0700
Message-ID: <20190722182908.GA16788@roeck-us.net>
References: <20190722172611.3797-1-wsa+renesas@sang-engineering.com>
 <20190722172611.3797-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190722172611.3797-3-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 22, 2019 at 07:26:09PM +0200, Wolfram Sang wrote:
> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/hwmon/smm665.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/smm665.c b/drivers/hwmon/smm665.c
> index d8c91c2cb8cf..6eff14fe395d 100644
> --- a/drivers/hwmon/smm665.c
> +++ b/drivers/hwmon/smm665.c
> @@ -586,10 +586,10 @@ static int smm665_probe(struct i2c_client *client,
>  
>  	data->client = client;
>  	data->type = id->driver_data;
> -	data->cmdreg = i2c_new_dummy(adapter, (client->addr & ~SMM665_REGMASK)
> +	data->cmdreg = i2c_new_dummy_device(adapter, (client->addr & ~SMM665_REGMASK)
>  				     | SMM665_CMDREG_BASE);
> -	if (!data->cmdreg)
> -		return -ENOMEM;
> +	if (IS_ERR(data->cmdreg))
> +		return PTR_ERR(data->cmdreg);
>  
>  	switch (data->type) {
>  	case smm465:
