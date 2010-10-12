From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Fix TX setup for more SoCs
Date: Tue, 12 Oct 2010 08:13:07 -0700
Message-ID: <87mxqj30n0.fsf@deeprootsystems.com>
References: <1286858825-21540-1-git-send-email-jon.povey@racelogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286858825-21540-1-git-send-email-jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
	(Jon Povey's message of "Tue, 12 Oct 2010 13:47:05 +0900")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ben,

Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org> writes:

> This patch is an improvement to 4bba0fd8d1c6d405df666e2573e1a1f917098be0
> which got to mainline a little early.
>
> Sudhakar Rajashekhara explains that at least OMAP-L138 requires MDR mode
> settings before DXR for correct behaviour, so load MDR first with
> STT cleared and later load again with STT set.
>
> Tested on DM355 connected to Techwell TW2836 and Wolfson WM8985
>
> Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
> Acked-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
> Tested-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
> Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> ---
> This patches to what was v4 of the original patch.
>
> The original patch which made it to 2.6.36-rc7 will as I understand it have
> introduced a regression for OMAP-L138 so this patch is a regression fix and
> wants to get into 2.6.36.

can you get this one into 2.6.36 please?

Thanks,

Kevin

>
>  drivers/i2c/busses/i2c-davinci.c |   24 +++++++++++++++---------
>  1 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index b8feac5..5795c83 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -331,21 +331,16 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  	INIT_COMPLETION(dev->cmd_complete);
>  	dev->cmd_err = 0;
>  
> -	/* Take I2C out of reset, configure it as master and set the
> -	 * start bit */
> -	flag = DAVINCI_I2C_MDR_IRS | DAVINCI_I2C_MDR_MST | DAVINCI_I2C_MDR_STT;
> +	/* Take I2C out of reset and configure it as master */
> +	flag = DAVINCI_I2C_MDR_IRS | DAVINCI_I2C_MDR_MST;
>  
>  	/* if the slave address is ten bit address, enable XA bit */
>  	if (msg->flags & I2C_M_TEN)
>  		flag |= DAVINCI_I2C_MDR_XA;
>  	if (!(msg->flags & I2C_M_RD))
>  		flag |= DAVINCI_I2C_MDR_TRX;
> -	if (stop)
> -		flag |= DAVINCI_I2C_MDR_STP;
> -	if (msg->len == 0) {
> +	if (msg->len == 0)
>  		flag |= DAVINCI_I2C_MDR_RM;
> -		flag &= ~DAVINCI_I2C_MDR_STP;
> -	}
>  
>  	/* Enable receive or transmit interrupts */
>  	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
> @@ -358,17 +353,28 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  	dev->terminate = 0;
>  
>  	/*
> +	 * Write mode register first as needed for correct behaviour
> +	 * on OMAP-L138, but don't set STT yet to avoid a race with XRDY
> +	 * occuring before we have loaded DXR
> +	 */
> +	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
> +
> +	/*
>  	 * First byte should be set here, not after interrupt,
>  	 * because transmit-data-ready interrupt can come before
>  	 * NACK-interrupt during sending of previous message and
>  	 * ICDXR may have wrong data
> +	 * It also saves us one interrupt, slightly faster
>  	 */
>  	if ((!(msg->flags & I2C_M_RD)) && dev->buf_len) {
>  		davinci_i2c_write_reg(dev, DAVINCI_I2C_DXR_REG, *dev->buf++);
>  		dev->buf_len--;
>  	}
>  
> -	/* write the data into mode register; start transmitting */
> +	/* Set STT to begin transmit now DXR is loaded */
> +	flag |= DAVINCI_I2C_MDR_STT;
> +	if (stop && msg->len != 0)
> +		flag |= DAVINCI_I2C_MDR_STP;
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
>  
>  	r = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
