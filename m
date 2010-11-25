From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/7] i2c/pxa2xx: Don't touch ISAR if not in slave mode
Date: Thu, 25 Nov 2010 23:52:56 +0000
Message-ID: <20101125235255.GB15948@trinity.fluff.org>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de> <1290633617-15311-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1290633617-15311-2-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 24, 2010 at 10:20:11PM +0100, Sebastian Andrzej Siewior wrote:
> The reset functions sets writes the slave address even in not slave
> mode. I don't see any reason in writting it if slave mode is not
> enabled.
> I have here a PXA-I2C variant where this register is not availbale and
> as such can not be touched.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index f4c19a9..579c8a8 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -418,7 +418,9 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>  	writel(I2C_ISR_INIT, _ISR(i2c));
>  	writel(readl(_ICR(i2c)) & ~ICR_UR, _ICR(i2c));
>  
> +#ifdef CONFIG_I2C_PXA_SLAVE
>  	writel(i2c->slave_addr, _ISAR(i2c));
> +#endif

I was thinking about whether to add a flag to this to say whether the
slave_addr field is valid, but to keep full compatiblity with the existing
pxa users, we'd have to go and change every board using it.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
