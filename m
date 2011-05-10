From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 09/13] i2c/i2c-nomadik: add code to retry on timeout
 failure
Date: Tue, 10 May 2011 23:23:38 +0100
Message-ID: <20110510222338.GB634@freya.fluff.org>
References: <1304977099-31694-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1304977099-31694-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, May 09, 2011 at 11:38:19PM +0200, Linus Walleij wrote:
> From: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> 
> It is seen that i2c-nomadik controller randomly stops generating the
> interrupts leading to a i2c timeout. As a workaround to this problem,
> add retries to the on going transfer on failure.
> 
> Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Reviewed-by: Jonas ABERG <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-nomadik.c |   97 +++++++++++++++++++-------------------
>  1 files changed, 49 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
> index f3a0af0..bf061e1 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -255,8 +255,6 @@ static int init_hw(struct nmk_i2c_dev *dev)
>  {
>  	int stat;
>  
> -	clk_enable(dev->clk);
> -
>  	stat = flush_i2c_fifo(dev);
>  	if (stat)
>  		goto exit;
> @@ -271,8 +269,6 @@ static int init_hw(struct nmk_i2c_dev *dev)
>  	dev->cli.operation = I2C_NO_OPERATION;
>  
>  exit:
> -	/* TODO: Why disable clocks after init hw? */
> -	clk_disable(dev->clk);
>  	/*
>  	 * TODO: What is this delay for?
>  	 * Must be pretty pointless since the hw block
> @@ -572,6 +568,7 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
>  	u32 cause;
>  	struct nmk_i2c_dev *dev = i2c_get_adapdata(i2c_adap);
>  	u32 i2c_sr;
> +	int j;
>  
>  	dev->busy = true;
>  
> @@ -579,63 +576,67 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
>  		regulator_enable(dev->regulator);
>  	pm_runtime_get_sync(&dev->pdev->dev);
>  
> +	clk_enable(dev->clk);
> +
>  	status = init_hw(dev);
>  	if (status)
> -		goto out2;
> +		goto out;
>  
> -	clk_enable(dev->clk);
> -
> -	/* setup the i2c controller */
> -	setup_i2c_controller(dev);
> +	for (j = 0; j < 3; j++) {
> +		/* setup the i2c controller */
> +		setup_i2c_controller(dev);
>  
> -	for (i = 0; i < num_msgs; i++) {
> -		if (unlikely(msgs[i].flags & I2C_M_TEN)) {
> -			dev_err(&dev->pdev->dev, "10 bit addressing"
> -					"not supported\n");
> +		for (i = 0; i < num_msgs; i++) {
> +			if (unlikely(msgs[i].flags & I2C_M_TEN)) {
> +				dev_err(&dev->pdev->dev, "10 bit addressing"
> +						"not supported\n");
>  
> -			status = -EINVAL;
> -			goto out;
> -		}
> -		dev->cli.slave_adr	= msgs[i].addr;
> -		dev->cli.buffer		= msgs[i].buf;
> -		dev->cli.count		= msgs[i].len;
> -		dev->stop = (i < (num_msgs - 1)) ? 0 : 1;
> -		dev->result = 0;
> -
> -		if (msgs[i].flags & I2C_M_RD) {
> -			/* it is a read operation */
> -			dev->cli.operation = I2C_READ;
> -			status = read_i2c(dev);
> -		} else {
> -			/* write operation */
> -			dev->cli.operation = I2C_WRITE;
> -			status = write_i2c(dev);
> -		}
> -		if (status || (dev->result)) {
> -			i2c_sr = readl(dev->virtbase + I2C_SR);
> -			/*
> -			 * Check if the controller I2C operation status is set
> -			 * to ABORT(11b).
> -			 */
> -			if (((i2c_sr >> 2) & 0x3) == 0x3) {
> -				/* get the abort cause */
> -				cause =	(i2c_sr >> 4)
> -					& 0x7;
> -				dev_err(&dev->pdev->dev, "%s\n", cause >=
> -						ARRAY_SIZE(abort_causes) ?
> +				status = -EINVAL;
> +				goto out;
> +			}
> +			dev->cli.slave_adr	= msgs[i].addr;
> +			dev->cli.buffer		= msgs[i].buf;
> +			dev->cli.count		= msgs[i].len;
> +			dev->stop = (i < (num_msgs - 1)) ? 0 : 1;
> +			dev->result = 0;
> +
> +			if (msgs[i].flags & I2C_M_RD) {
> +				/* it is a read operation */
> +				dev->cli.operation = I2C_READ;
> +				status = read_i2c(dev);
> +			} else {
> +				/* write operation */
> +				dev->cli.operation = I2C_WRITE;
> +				status = write_i2c(dev);
> +			}
> +			if (status || (dev->result)) {
> +				i2c_sr = readl(dev->virtbase + I2C_SR);
> +				/*
> +				 * Check if the controller I2C operation status
> +				 * is set to ABORT(11b).
> +				 */
> +				if (((i2c_sr >> 2) & 0x3) == 0x3) {
> +					/* get the abort cause */
> +					cause =	(i2c_sr >> 4)
> +						& 0x7;
> +					dev_err(&dev->pdev->dev, "%s\n", cause
> +						>= ARRAY_SIZE(abort_causes) ?
>  						"unknown reason" :
>  						abort_causes[cause]);
> -			}
> +				}
>  
> -			status = status ? status : dev->result;
> -			goto out;
> +				status = status ? status : dev->result;
> +
> +				break;
> +			}
> +			udelay(I2C_DELAY);
>  		}
> -		udelay(I2C_DELAY);
> +		if (status == 0)
> +			break;

this code is getting a bit complicated, could some of it be factored
into a new sub-function?
