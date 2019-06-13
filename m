From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 19/34] power: supply: max14656_charger_detector: simplify
 getting the adapter of a client
Date: Thu, 13 Jun 2019 11:51:19 +0200
Message-ID: <20190613095119.fodosp3uxua54c5q@verge.net.au>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
 <20190608105619.593-20-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190608105619.593-20-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 08, 2019 at 12:55:58PM +0200, Wolfram Sang wrote:
> We have a dedicated pointer for that, so use it. Much easier to read and
> less computation involved.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
> Please apply to your subsystem tree.
> 
>  drivers/power/supply/max14656_charger_detector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/power/supply/max14656_charger_detector.c
> index 9e6472834e37..f27b780d2c02 100644
> --- a/drivers/power/supply/max14656_charger_detector.c
> +++ b/drivers/power/supply/max14656_charger_detector.c
> @@ -251,7 +251,7 @@ static void stop_irq_work(void *data)
>  static int max14656_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> -	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct i2c_adapter *adapter = client->adapter;
>  	struct device *dev = &client->dev;
>  	struct power_supply_config psy_cfg = {};
>  	struct max14656_chip *chip;
> -- 
> 2.19.1
> 
