From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-nomadik: fix regression on adapter name
Date: Mon, 29 Nov 2010 10:45:33 +0100
Message-ID: <20101129104533.545b7953@endymion.delvare>
References: <1291023335-6430-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1291023335-6430-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

On Mon, 29 Nov 2010 10:35:35 +0100, Linus Walleij wrote:
> The Nomadik I2C adapter does not provide a name for the struct
> passed into i2c_add_numbered_adapter() causing a regression on
> 2.6.37-rc3 due to commit 2236baa75f704851d3cd3310569058151acb1f06
> adding sanity checks for adapters. Fix this by providing a name
> proper.

Thanks for the fix, but see below.

> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-nomadik.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
> index c9fffd0..f34a276 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -872,6 +872,7 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
>  	adap->owner	= THIS_MODULE;
>  	adap->class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
>  	adap->algo	= &nmk_i2c_algo;
> +	strncpy(adap->name, DRIVER_NAME, sizeof(adap->name));

Please use strlcpy. strncpy is broken by design (result isn't
guaranteed to be NUL-terminated.)

Also, DRIVER_NAME ("nmk-i2c") is not a good adapter name. It's cryptic
and not unique if there is more than 1 such adapter on the system. I
would instead suggest something like:

	snprintf(adap->name, sizeof(adap->name), "Nomadik I2C at %lx\n",
		 (unsigned long)res->start);

>  
>  	/* fetch the controller id */
>  	adap->nr	= pdev->id;


-- 
Jean Delvare
