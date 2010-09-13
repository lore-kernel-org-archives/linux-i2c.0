From: Jonathan Cameron <arm-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
Subject: Re: [PATCH 05/25] drivers/i2c: Use static const char arrays
Date: Mon, 13 Sep 2010 21:08:00 +0100
Message-ID: <4C8E84A0.1010606@jic23.retrosnub.co.uk>
References: <cover.1284406638.git.joe@perches.com> <b0c83cb1b42c6adf38f6322066fb457693f7ac3b.1284406638.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b0c83cb1b42c6adf38f6322066fb457693f7ac3b.1284406638.git.joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

 Commit message is  somewhat inaccurate...

On 09/13/10 20:47, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-stu300.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
> index 495be45..2f7c09c 100644
> --- a/drivers/i2c/busses/i2c-stu300.c
> +++ b/drivers/i2c/busses/i2c-stu300.c
> @@ -871,7 +871,7 @@ stu300_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	int bus_nr;
>  	int ret = 0;
> -	char clk_name[] = "I2C0";
> +	char clk_name[sizeof("I2Cx")];
>  
>  	dev = kzalloc(sizeof(struct stu300_dev), GFP_KERNEL);
>  	if (!dev) {
> @@ -881,7 +881,7 @@ stu300_probe(struct platform_device *pdev)
>  	}
>  
>  	bus_nr = pdev->id;
> -	clk_name[3] += (char)bus_nr;
> +	sprintf(clk_name, "I2C%c", '0' + bus_nr);
I'm guessing that there are never more than a couple of these.
Why is this method a better bet than just putting %d?
>  	dev->clk = clk_get(&pdev->dev, clk_name);
>  	if (IS_ERR(dev->clk)) {
>  		ret = PTR_ERR(dev->clk);
