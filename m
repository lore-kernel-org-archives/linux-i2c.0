From: Ben Dooks <ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH 1/6] i2c/pxa2xx: Don't touch ISAR on X86
Date: Fri, 3 Dec 2010 01:44:24 +0000
Message-ID: <20101203014424.GG24979@trinity.fluff.org>
References: <1291320589-31570-1-git-send-email-bigeasy@linutronix.de> <1291320589-31570-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1291320589-31570-2-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 02, 2010 at 09:09:44PM +0100, Sebastian Andrzej Siewior wrote:
> The reset functions sets writes the slave address even in not slave
> mode. I don't see any reason in writting it if slave mode is not
> enabled.
> Ben Dooks was conserned about making this change make it unavable on X86
> where it is not available.
> 
> Cc: ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index f4c19a9..aadf9d2 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -418,7 +418,9 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>  	writel(I2C_ISR_INIT, _ISR(i2c));
>  	writel(readl(_ICR(i2c)) & ~ICR_UR, _ICR(i2c));
>  
> +#ifndef CONFIG_X86
>  	writel(i2c->slave_addr, _ISAR(i2c));
> +#endif

I'd prefer some way of changing based on either the device name (see
some other drivers which bind on multiple names) to define things such
as this, as well as possibly changing the register layout.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
