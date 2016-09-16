From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] gpio: pca953x: fix an incorrect lockdep warning
Date: Fri, 16 Sep 2016 16:33:14 +0200
Message-ID: <d1f3c65c-0294-19fc-8de5-fa3e79a9f505@axentia.se>
References: <1474035484-25134-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0105.outbound.protection.outlook.com ([104.47.2.105]:37903
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965546AbcIPUJe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 16 Sep 2016 16:09:34 -0400
In-Reply-To: <1474035484-25134-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2016-09-16 16:18, Bartosz Golaszewski wrote:
> If an I2C GPIO multiplexer is driven by a GPIO provided by an expander
> when there's a second expander using the same device driver on one of
> the I2C bus segments, lockdep prints a deadlock warning when trying to
> set the direction or the value of the GPIOs provided by the second
> expander.
> 
> The below diagram presents the setup:
> 
>                                                - - - - -
>  -------             ---------  Bus segment 1 |         |
> |       |           |         |---------------  Devices
> |       | SCL/SDA   |         |               |         |
> | Linux |-----------| I2C MUX |                - - - - -
> |       |    |      |         | Bus segment 2
> |       |    |      |         |-------------------
>  -------     |       ---------                    |
>              |           |                    - - - - -
>         ------------     | MUX GPIO          |         |
>        |            |    |                     Devices
>        |    GPIO    |    |                   |         |
>        | Expander 1 |----                     - - - - -
>        |            |                             |
>         ------------                              | SCL/SDA
>                                                   |
>                                              ------------
>                                             |            |
>                                             |    GPIO    |
>                                             | Expander 2 |
>                                             |            |
>                                              ------------
> 
> The reason for lockdep warning is that we take the chip->i2c_lock in
> pca953x_gpio_set_value() or pca953x_gpio_direction_output() and then
> come right back to pca953x_gpio_set_value() when the GPIO mux kicks
> in. The locks actually protect different expanders, but for lockdep
> both are of the same class, so it says:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&chip->i2c_lock);
>    lock(&chip->i2c_lock);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
> In order to get rid of the warning, check if the i2c adapter of the
> expander is multiplexed (by checking if it has a parent adapter) and,
> if so, set a different lock subclass for chip->i2c_lock.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> Note: a similar issue would occur with other gpio expanders under
> similar circumstances. If this patch get's merged, I'll prepare
> a common solution for all gpio drivers which use an internal i2c lock.
> 
>  drivers/gpio/gpio-pca953x.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 02f2a56..2d49b25 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -787,6 +787,18 @@ static int pca953x_probe(struct i2c_client *client,
>  
>  	mutex_init(&chip->i2c_lock);
>  
> +	/*
> +	 * If the i2c adapter we're connected to is multiplexed (which is
> +	 * indicated by it having a parent adapter) we need to use a
> +	 * different lock subclass. It's caused by the fact that in a rare
> +	 * case of using an i2c-gpio multiplexer controlled by a gpio
> +	 * provided by an expander using the same driver, lockdep would
> +	 * incorrectly detect a deadlock, since we'd take a second lock
> +	 * of the same class without releasing the first one.
> +	 */
> +	if (i2c_parent_is_i2c_adapter(client->adapter))
> +		lockdep_set_subclass(&chip->i2c_lock, SINGLE_DEPTH_NESTING);
> +
>  	/* initialize cached registers from their original values.
>  	 * we can't share this chip with another i2c master.
>  	 */
> 

If this is to be fixed this even for crazy setups where the pattern is
repeated for more levels, you can look into drivers/i2c/i2c-core.c
i2c_adapter_depth() and how it's used (i.e. for this exact purpose).
Maybe it's time to export that function?

Cheers,
Peter
