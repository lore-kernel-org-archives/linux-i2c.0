From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: fix building driver as module
Date: Tue, 28 Nov 2017 10:58:28 +0200
Message-ID: <a8423851-ab3d-7274-3c36-4043d368b36a@linux.intel.com>
References: <1511838551-4035-1-git-send-email-preid@electromag.com.au>
 <1511838551-4035-3-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52670 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751451AbdK1I6e (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 28 Nov 2017 03:58:34 -0500
In-Reply-To: <1511838551-4035-3-git-send-email-preid@electromag.com.au>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, sfr@canb.auug.org.au

On 11/28/2017 05:09 AM, Phil Reid wrote:
> The designware core and platform are built as separate modules.
> Export i2c_dw_prepare_clk() so it can be used by the platform
> driver.
> 
> Fixes commit a34a0b6da22540d19e57
> ("i2c: designware: move i2c_dw_plat_prepare_clk to common")
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>   drivers/i2c/busses/i2c-designware-common.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
> index 6b82809..27ebd90 100644
> --- a/drivers/i2c/busses/i2c-designware-common.c
> +++ b/drivers/i2c/busses/i2c-designware-common.c
> @@ -197,6 +197,7 @@ int i2c_dw_prepare_clk(struct dw_i2c_dev *dev, bool prepare)
>   	clk_disable_unprepare(dev->clk);
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(i2c_dw_prepare_clk);
>   
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
