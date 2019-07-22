From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3] hwmon: w83781d: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 11:30:06 -0700
Message-ID: <20190722183006.GA16898@roeck-us.net>
References: <20190722172611.3797-1-wsa+renesas@sang-engineering.com>
 <20190722172611.3797-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190722172611.3797-4-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 22, 2019 at 07:26:10PM +0200, Wolfram Sang wrote:
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
>  drivers/hwmon/w83781d.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
> index d2c04b6a3f2b..015f1ea31966 100644
> --- a/drivers/hwmon/w83781d.c
> +++ b/drivers/hwmon/w83781d.c
> @@ -894,12 +894,12 @@ w83781d_detect_subclients(struct i2c_client *new_client)
>  	}
>  
>  	for (i = 0; i < num_sc; i++) {
> -		data->lm75[i] = i2c_new_dummy(adapter, sc_addr[i]);
> -		if (!data->lm75[i]) {
> +		data->lm75[i] = i2c_new_dummy_device(adapter, sc_addr[i]);
> +		if (IS_ERR(data->lm75[i])) {
>  			dev_err(&new_client->dev,
>  				"Subclient %d registration at address 0x%x failed.\n",
>  				i, sc_addr[i]);
> -			err = -ENOMEM;
> +			err = PTR_ERR(data->lm75[i]);
>  			if (i == 1)
>  				goto ERROR_SC_3;
>  			goto ERROR_SC_2;
