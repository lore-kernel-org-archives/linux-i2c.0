From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Fix failure on baytrail
Date: Fri, 9 Feb 2018 11:25:47 +0200
Message-ID: <945d4119-5aaf-520f-de2c-a9293f236f13@linux.intel.com>
References: <1518113569-19991-1-git-send-email-gardner.ben@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:9658 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbeBIJZa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 9 Feb 2018 04:25:30 -0500
In-Reply-To: <1518113569-19991-1-git-send-email-gardner.ben@gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi

On 02/08/2018 08:12 PM, Ben Gardner wrote:
> The I2C driver for my Atom E3845 board has been broken since 4.9.
> 
> These kernel logs show up whenever am I2C transaction is attempted.
> i2c-designware-pci 0000:00:18.3: timeout in disabling adapter
> i2c-designware-pci 0000:00:18.3: timeout waiting for bus ready
> 
> The root issue is that the I2C port takes a while to enable and somewhere
> along the way, the 'enable-and-wait' approach to enabling the adapter
> was changed to 'enable'.
> That caused the driver and hardware to get out of sync and fail.
> 
> I have tested this patch on 4.14 and 4.15.
> 
> Signed-off-by: Ben Gardner <gardner.ben@gmail.com>
> ---
>   drivers/i2c/busses/i2c-designware-master.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
> index ae69188..55926ef 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
> @@ -209,7 +209,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>   	i2c_dw_disable_int(dev);
>   
>   	/* Enable the adapter */
> -	__i2c_dw_enable(dev, true);
> +	__i2c_dw_enable_and_wait(dev, true);
>   
>   	/* Clear and enable interrupts */
>   	dw_readl(dev, DW_IC_CLR_INTR);

It seems commit 2702ea7dbec5 ("i2c: designware: wait for disable/enable 
only if necessary") is most likely reason for regression. Are you able 
to test some version between v4.9 and v4.12 and revert that commit does 
it fix the issue for you? Can you also test your fix on the same kernel 
version but apply to drivers/i2c/busses/i2c-designware-core.c?

i2c-designware-master.c was renamed from i2c-designware-core.c in v4.13 
and thus we need to have the separate fix for kernels v4.9-v4.12.

-- 
Jarkko
