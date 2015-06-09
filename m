From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: use enable on resume instead
 initialization
Date: Tue, 9 Jun 2015 11:51:46 +0300
Message-ID: <20150609085146.GD1478@lahna.fi.intel.com>
References: <1433785828-4100-1-git-send-email-lucas.de.marchi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433785828-4100-1-git-send-email-lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Fabio Mello <fabio.mello-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 08, 2015 at 02:50:28PM -0300, lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Fabio Mello <fabio.mello-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> According to documentation and tests, initialization is not
> necessary on module resume, since the controller keeps its state
> between disable/enable. Change the target address is also allowed.
> 
> So, this patch replaces the initialization on module resume with a
> simple enable, and removes the (non required anymore) enables and
> disables.
> 
> Signed-off-by: Fabio Mello <fabio.mello-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
> 
> These pictures explain a little more the consequence of letting the
> enable+disable in the code:
> 
> 	http://pub.politreco.com/paste/TEK0011-before.jpg
> 	http://pub.politreco.com/paste/TEK0007-after.jpg
> 
> The yellow line is a GPIO toggle in userspace to mark when we start and finish
> the i2c transactions.  The blue line is the SCL in that i2c bus. Take a look on
> the huge pauses we have between any 2 transactions.  These pauses are removed
> with this patch and we are able to read our sensor's values in 950usec rather
> than 5.24msec we had before.  We are testing this using a Minnowboard Max that
> has a designware i2c controller.

Did you test this on any other platform than Intel Baytrail?

I'm adding Christian Ruppert (keeping the context) if he has any
comments. IIRC he added the per transfer enable/disable some time ago.

> 
> There's this comment in the code suggesting the designware controller might
> have problems if we don't disable it after each transfer.  We left a stress
> code running for 3 days to check if anything bad would happen.  This is the
> test code using a PCA9685 (just because it was the easiest device we had
> available to check read+write commands):
> 
> 	http://pub.politreco.com/paste/test-i2c.c
> 
>  drivers/i2c/busses/i2c-designware-core.c    | 19 ++++---------------
>  drivers/i2c/busses/i2c-designware-platdrv.c |  2 +-
>  2 files changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 6e25c01..b386c10 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -375,8 +375,12 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  	/* configure the i2c master */
>  	dw_writel(dev, dev->master_cfg , DW_IC_CON);
>  
> +	/* Enable the adapter */
> +	__i2c_dw_enable(dev, true);
> +
>  	if (dev->release_lock)
>  		dev->release_lock(dev);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(i2c_dw_init);
> @@ -405,9 +409,6 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>  	struct i2c_msg *msgs = dev->msgs;
>  	u32 ic_con, ic_tar = 0;
>  
> -	/* Disable the adapter */
> -	__i2c_dw_enable(dev, false);
> -
>  	/* if the slave address is ten bit address, enable 10BITADDR */
>  	ic_con = dw_readl(dev, DW_IC_CON);
>  	if (msgs[dev->msg_write_idx].flags & I2C_M_TEN) {
> @@ -434,9 +435,6 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>  	/* enforce disabled interrupts (due to HW issues) */
>  	i2c_dw_disable_int(dev);
>  
> -	/* Enable the adapter */
> -	__i2c_dw_enable(dev, true);
> -
>  	/* Clear and enable interrupts */
>  	i2c_dw_clear_int(dev);
>  	dw_writel(dev, DW_IC_INTR_DEFAULT_MASK, DW_IC_INTR_MASK);
> @@ -665,15 +663,6 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  		goto done;
>  	}
>  
> -	/*
> -	 * We must disable the adapter before unlocking the &dev->lock mutex
> -	 * below. Otherwise the hardware might continue generating interrupts
> -	 * which in turn causes a race condition with the following transfer.
> -	 * Needs some more investigation if the additional interrupts are
> -	 * a hardware bug or this driver doesn't handle them correctly yet.
> -	 */
> -	__i2c_dw_enable(dev, false);
> -
>  	if (dev->msg_err) {
>  		ret = dev->msg_err;
>  		goto done;
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index c270f5f..0598695 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -320,7 +320,7 @@ static int dw_i2c_resume(struct device *dev)
>  	clk_prepare_enable(i_dev->clk);
>  
>  	if (!i_dev->pm_runtime_disabled)
> -		i2c_dw_init(i_dev);
> +		i2c_dw_enable(i_dev);
>  
>  	return 0;
>  }
> -- 
> 2.4.2
