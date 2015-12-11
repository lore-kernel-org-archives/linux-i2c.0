From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2] I2C: designware: fix IO timeout issue for AMD
 controller
Date: Fri, 11 Dec 2015 10:42:30 +0200
Message-ID: <566A8C76.9080104@linux.intel.com>
References: <1449835373-4669-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:40799 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053AbbLKIme (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 11 Dec 2015 03:42:34 -0500
In-Reply-To: <1449835373-4669-1-git-send-email-Xiangliang.Yu@amd.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Xiangliang Yu <Xiangliang.Yu@amd.com>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: SPG_Linux_Kernel@amd.com

On 12/11/2015 02:02 PM, Xiangliang Yu wrote:
> Because of some hardware limitation, AMD I2C controller can't
> trigger pending interrupt if interrupt status has been changed
> after clearing interrupt status bits. Then, I2C will lost
> interrupt and IO timeout.
>
> According to hardware design, this patch implements a workaround
> to disable i2c controller interrupt and re-enable i2c interrupt
> before exiting ISR.
>
> To reduce the performance impacts on other vendors, use unlikely
> function to check flag in ISR.
> ---
> Changes in v2:
>      - pass flags with ->driver_data
>      - unmask interrupt right after masking
>
> Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
> ---
>   drivers/i2c/busses/i2c-designware-core.c    | 6 ++++++
>   drivers/i2c/busses/i2c-designware-core.h    | 1 +
>   drivers/i2c/busses/i2c-designware-platdrv.c | 7 ++++++-
>   3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 8c48b27..de7fbbb 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -813,6 +813,12 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
>   tx_aborted:
>   	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) || dev->msg_err)
>   		complete(&dev->cmd_complete);
> +	else if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK)) {
> +		/* workaround to trigger pending interrupt */
> +		stat = dw_readl(dev, DW_IC_INTR_MASK);
> +		i2c_dw_disable_int(dev);
> +		dw_writel(dev, stat, DW_IC_INTR_MASK);
> +	}
>
Looks ok to me.

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
