From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] hwmon: lm90: simplify getting the adapter of a client
Date: Wed, 12 Jun 2019 05:41:06 -0700
Message-ID: <20190612124106.GA26013@roeck-us.net>
References: <20190610095157.11814-1-wsa+renesas@sang-engineering.com>
 <20190610095157.11814-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190610095157.11814-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Peter Rosin <peda@axentia.se>, Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 10, 2019 at 11:51:54AM +0200, Wolfram Sang wrote:
> We have a dedicated pointer for that, so use it. Much easier to read and
> less computation involved.
> 
> Reported-by: Peter Rosin <peda@axentia.se>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Aplied.

Thanks,
Guenter

> ---
> 
> Please apply to your subsystem tree.
> 
>  drivers/hwmon/lm90.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index e562a578f20e..2ebcab8b0a9b 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -1718,7 +1718,7 @@ static int lm90_probe(struct i2c_client *client,
>  		      const struct i2c_device_id *id)
>  {
>  	struct device *dev = &client->dev;
> -	struct i2c_adapter *adapter = to_i2c_adapter(dev->parent);
> +	struct i2c_adapter *adapter = client->adapter;
>  	struct hwmon_channel_info *info;
>  	struct regulator *regulator;
>  	struct device *hwmon_dev;
