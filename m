From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: fixup of wait_for_completion_timeout
 return handling
Date: Tue, 10 Feb 2015 09:19:04 +0200
Message-ID: <54D9B0E8.7000000@linux.intel.com>
References: <1423499739-9423-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423499739-9423-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Du Wenkai <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi

On 02/09/2015 06:35 PM, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int.
> An appropriate return variable is introduced and assignment fixed up.
>
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
> ---
>
> Patch was compile tested with x86_64_defconfig +
> CONFIG_X86_AMD_PLATFORM_DEVICE=y, CONFIG_I2C_DESIGNWARE_PLATFORM=m
> (implies CONFIG_I2C_DESIGNWARE_CORE=y)
>
> Patch is against 3.19.0-rc7 (localversion-next is -next-20150209)
>
>   drivers/i2c/busses/i2c-designware-core.c |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 6e25c01..05934e0 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -623,6 +623,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>   {
>   	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
>   	int ret;
> +	unsigned int timeout;
>
Not unsigned long.

> @@ -656,8 +657,8 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>   	i2c_dw_xfer_init(dev);
>
>   	/* wait for tx to complete */
> -	ret = wait_for_completion_timeout(&dev->cmd_complete, HZ);
> -	if (ret == 0) {
> +	timeout = wait_for_completion_timeout(&dev->cmd_complete, HZ);
> +	if (timeout == 0) {
>   		dev_err(dev->dev, "controller timed out\n");
>   		/* i2c_dw_init implicitly disables the adapter */
>   		i2c_dw_init(dev);
>
I'd say better to test directly with "if 
(!wait_for_completion_timeout())" since remaining jiffies or potential 
error code from wait_for_completion_timeout() is not used here.

-- 
Jarkko
