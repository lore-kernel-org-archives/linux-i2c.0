From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-nomadik: fix kerneldoc warning
Date: Mon, 27 Jun 2011 23:04:49 +0100
Message-ID: <20110627220449.GB23027@freya.fluff.org>
References: <1308134522-30858-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1308134522-30858-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 15, 2011 at 12:42:02PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> There was a missing struct item in the kerneldoc, add it and fix
> another pretty-printing formatting issue with a missing space.

weird, it didn't apply to 3.0-rc4.

i'll let the two things in one patch slide for this one.
 
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-nomadik.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
> index f9b8854..b228e09 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -146,6 +146,7 @@ struct i2c_nmk_client {
>   * @stop: stop condition
>   * @xfer_complete: acknowledge completion for a I2C message
>   * @result: controller propogated result
> + * @regulator: pointer to i2c regulator
>   * @busy: Busy doing transfer
>   */
>  struct nmk_i2c_dev {
> @@ -509,7 +510,7 @@ static int write_i2c(struct nmk_i2c_dev *dev)
>  
>  	if (timeout < 0) {
>  		dev_err(&dev->pdev->dev,
> -			"wait_for_completion_timeout"
> +			"wait_for_completion_timeout "
>  			"returned %d waiting for event\n", timeout);
>  		status = timeout;
>  	}
> -- 
> 1.7.3.2
> 
