From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] hwmon: asb100: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 11:28:15 -0700
Message-ID: <20190722182815.GA16669@roeck-us.net>
References: <20190722172611.3797-1-wsa+renesas@sang-engineering.com>
 <20190722172611.3797-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190722172611.3797-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 22, 2019 at 07:26:08PM +0200, Wolfram Sang wrote:
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
>  drivers/hwmon/asb100.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
> index c9fa84b25678..4c609e23a4ef 100644
> --- a/drivers/hwmon/asb100.c
> +++ b/drivers/hwmon/asb100.c
> @@ -706,21 +706,21 @@ static int asb100_detect_subclients(struct i2c_client *client)
>  		goto ERROR_SC_2;
>  	}
>  
> -	data->lm75[0] = i2c_new_dummy(adapter, sc_addr[0]);
> -	if (!data->lm75[0]) {
> +	data->lm75[0] = i2c_new_dummy_device(adapter, sc_addr[0]);
> +	if (IS_ERR(data->lm75[0])) {
>  		dev_err(&client->dev,
>  			"subclient %d registration at address 0x%x failed.\n",
>  			1, sc_addr[0]);
> -		err = -ENOMEM;
> +		err = PTR_ERR(data->lm75[0]);
>  		goto ERROR_SC_2;
>  	}
>  
> -	data->lm75[1] = i2c_new_dummy(adapter, sc_addr[1]);
> -	if (!data->lm75[1]) {
> +	data->lm75[1] = i2c_new_dummy_device(adapter, sc_addr[1]);
> +	if (IS_ERR(data->lm75[1])) {
>  		dev_err(&client->dev,
>  			"subclient %d registration at address 0x%x failed.\n",
>  			2, sc_addr[1]);
> -		err = -ENOMEM;
> +		err = PTR_ERR(data->lm75[1]);
>  		goto ERROR_SC_3;
>  	}
>  
