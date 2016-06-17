From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3] i2c: designware: Use transfer timeout from ioctl
 I2C_TIMEOUT
Date: Fri, 17 Jun 2016 08:36:42 +0300
Message-ID: <52b627ca-93b6-5c67-7d00-cf4c962ab5df@linux.intel.com>
References: <1466127995-28318-1-git-send-email-weifeng.voon@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35874 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754713AbcFQFgq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 17 Jun 2016 01:36:46 -0400
In-Reply-To: <1466127995-28318-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Weifeng Voon <weifeng.voon@intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jui.nee.tan@intel.com

On 06/17/2016 04:46 AM, Weifeng Voon wrote:
> This allows applications to set the transfer timeout in 10ms increments via
> ioctl I2C_TIMEOUT.
>
> Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
> ---
>  changelog v2:
>  * No code change, just change to a more suitable title
>
>  changelog v3:
>  * Move changelog out of commit log
>
>  drivers/i2c/busses/i2c-designware-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 99b54be..c6922b8 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -663,7 +663,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  	i2c_dw_xfer_init(dev);
>
>  	/* wait for tx to complete */
> -	if (!wait_for_completion_timeout(&dev->cmd_complete, HZ)) {
> +	if (!wait_for_completion_timeout(&dev->cmd_complete, adap->timeout)) {
>  		dev_err(dev->dev, "controller timed out\n");
>  		/* i2c_dw_init implicitly disables the adapter */
>  		i2c_dw_init(dev);

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
