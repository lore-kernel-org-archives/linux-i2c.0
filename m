From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c-mux-pca954x: Force reset on probe if available
Date: Tue, 8 May 2018 08:36:23 +0200
Message-ID: <bc56d669-b02f-a017-844d-e095bbbcb7cd@axentia.se>
References: <1525174932-8865-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525174932-8865-1-git-send-email-mike.looijmans@topic.nl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-05-01 13:42, Mike Looijmans wrote:
> Instead of just hogging the reset GPIO into deactivated state, activate and
> then de-activate the reset. This allows for better recovery if the CPU was
> reset halfway through an I2C transaction for example.

I can't see any problems with this, and a reset at load time can certainly
be a benefit. Some questions below though...

Cheers,
Peter

> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index 09bafd3..13e10d0 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -36,6 +36,7 @@
>   */
>  
>  #include <linux/device.h>
> +#include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-mux.h>
> @@ -389,10 +390,17 @@ static int pca954x_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, muxc);
>  	data->client = client;
>  
> -	/* Get the mux out of reset if a reset GPIO is specified. */
> -	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW);
> +	/* Reset the mux if a reset GPIO is specified. */
> +	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
>  	if (IS_ERR(gpio))
>  		return PTR_ERR(gpio);
> +	if (gpio) {
> +		/* Datasheet specifies a 4 ns reset-low time */
> +		udelay(1);

ndelay(4) ?

> +		gpiod_set_value_cansleep(gpio, 0);
> +		/* Datasheet specifies a 500 ns reset recovery time */
> +		udelay(1);

ndelay(500) ?

> +	}
>  
>  	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
>  	if (match)
> 
