From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v6 2/8] i2c: i801: Use GPIO_LOOKUP() helper macro
Date: Wed, 25 Mar 2020 10:14:57 +0100
Message-ID: <20200325101457.0fff5bb9@endymion>
References: <20200324135328.5796-1-geert+renesas@glider.be>
        <20200324135653.6676-1-geert+renesas@glider.be>
        <20200324135653.6676-2-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200324135653.6676-2-geert+renesas@glider.be>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jonathan Corbet <corbet@lwn.net>, Harish Jenny K N <harish_kandiga@mentor.com>, Eugeniu Rosca <erosca@de.adit-jv.com>, Alexander Graf <graf@amazon.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Phil Reid <preid@electromag.com.au>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 24 Mar 2020 14:56:47 +0100, Geert Uytterhoeven wrote:
> i801_add_mux() fills in the GPIO lookup table by manually populating an
> array of gpiod_lookup structures.  Use the existing GPIO_LOOKUP() helper
> macro instead, to relax a dependency on the gpiod_lookup structure's
> member names.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: linux-i2c@vger.kernel.org
> ---
> While this patch is a dependency for "[PATCH v6 4/8] gpiolib: Add
> support for GPIO lookup by line name", it can be applied independently.
> But an Acked-by would be nice, too.
> 
> Cover letter and full series at
> https://lore.kernel.org/r/20200324135328.5796-1-geert+renesas@glider.be/
> 
> v6:
>   - New.
> ---
>  drivers/i2c/busses/i2c-i801.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index ca4f096fef749302..8e64a71bea684cc7 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1444,9 +1444,9 @@ static int i801_add_mux(struct i801_priv *priv)
>  		return -ENOMEM;
>  	lookup->dev_id = "i2c-mux-gpio";
>  	for (i = 0; i < mux_config->n_gpios; i++) {
> -		lookup->table[i].chip_label = mux_config->gpio_chip;
> -		lookup->table[i].chip_hwnum = mux_config->gpios[i];
> -		lookup->table[i].con_id = "mux";
> +		lookup->table[i] = (struct gpiod_lookup)
> +			GPIO_LOOKUP(mux_config->gpio_chip,
> +				    mux_config->gpios[i], "mux", 0);
>  	}
>  	gpiod_add_lookup_table(lookup);
>  	priv->lookup = lookup;

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
