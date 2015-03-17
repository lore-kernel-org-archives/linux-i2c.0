From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH] i2c: davinci: fixup wait_for_completion_timeout handling
Date: Tue, 17 Mar 2015 10:29:42 +0100
Message-ID: <5507F406.1000202@nokia.com>
References: <1426578673-10692-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426578673-10692-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Nicholas Mc Guire <hofrat@osadl.org>, Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi!

On 17/03/15 08:51, ext Nicholas Mc Guire wrote:
> wait_for_completion_timeout return 0 (timeout) or >=1 (completion) so the check
> for >= 0 is always true and can be dropped implying that r==-EREMOTEIO and thus
> the return of -EREMOTEIO can be done in the   if (dev->buf_len)  branch.
> As wait_for_completion_timeout returns unsigned long not int, and   int r   is
> exclusively used for wait_for_completion_timeout it is renamed and the type
> changed to unsigned long.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Even if it has no effect on functionality, the learning effect is positive, so that
nobody will copy the wrong code out. So the change is correct,

Acked-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
> 
> Patch was compile tested with davinci_all_defconfig (implies CONFIG_I2C_DAVINCI=y)
> 
> Patch is against 4.0-rc4 (localversion-next is -next-20150317)
> 
>  drivers/i2c/busses/i2c-davinci.c |   17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 6dc7ff5..120a4ef 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -304,7 +304,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  	struct davinci_i2c_platform_data *pdata = dev->pdata;
>  	u32 flag;
>  	u16 w;
> -	int r;
> +	unsigned long time_left;
>  
>  	/* Introduce a delay, required for some boards (e.g Davinci EVM) */
>  	if (pdata->bus_delay)
> @@ -368,8 +368,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  		flag |= DAVINCI_I2C_MDR_STP;
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
>  
> -	r = wait_for_completion_timeout(&dev->cmd_complete, dev->adapter.timeout);
> -	if (r == 0) {
> +	time_left = wait_for_completion_timeout(&dev->cmd_complete,
> +						dev->adapter.timeout);
> +	if (!time_left) {
>  		dev_err(dev->dev, "controller timed out\n");
>  		davinci_i2c_recover_bus(dev);
>  		i2c_davinci_init(dev);
> @@ -380,17 +381,13 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  		/* This should be 0 if all bytes were transferred
>  		 * or dev->cmd_err denotes an error.
>  		 */
> -		if (r >= 0) {
> -			dev_err(dev->dev, "abnormal termination buf_len=%i\n",
> -				dev->buf_len);
> -			r = -EREMOTEIO;
> -		}
> +		dev_err(dev->dev, "abnormal termination buf_len=%i\n",
> +			dev->buf_len);
>  		dev->terminate = 1;
>  		wmb();
>  		dev->buf_len = 0;
> +		return -EREMOTEIO;
>  	}
> -	if (r < 0)
> -		return r;
>  
>  	/* no error */
>  	if (likely(!dev->cmd_err))

-- 
Best regards,
Alexander Sverdlin.
