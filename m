From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designwear: Fix clk warning on suspend/resume
Date: Mon, 6 Feb 2017 11:32:46 +0200
Message-ID: <c2af06f5-292f-a8f3-3baa-d239d4035bb3@linux.intel.com>
References: <1486162893-12313-1-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:58945 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbdBFJcu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 6 Feb 2017 04:32:50 -0500
In-Reply-To: <1486162893-12313-1-git-send-email-john.stultz@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>, lkml <linux-kernel@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

Hi

On 04.02.2017 01:01, John Stultz wrote:
> On my HiKey board, I'm seeing clk warnings on suspend/resume, which
> seem to be caused by runtime pm suspending the device, then the same
> suspend hook being called again on suspend time.
>
> Thus this patch adds suspend state tracking to avoid runtime pm and
> suspend causing double suspend calls on i2c-designware-platdrv.
>
> Feedback would be greatly appreciated!
>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/i2c/busses/i2c-designware-core.h    | 1 +
>  drivers/i2c/busses/i2c-designware-platdrv.c | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
...
> @@ -340,8 +340,12 @@ static int dw_i2c_plat_suspend(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
>
> +	if (i_dev->suspended)
> +		return 0;
> +
>  	i2c_dw_disable(i_dev);
>  	i2c_dw_plat_prepare_clk(i_dev, false);
> +	i_dev->suspended = true;
>
This feels a band-aid fix. At quick look some drivers appear to use 
SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, 
pm_runtime_force_resume) in their dev_pm_ops.

Could you try does it help in your case and I'll check our platforms.

-- 
Jarkko
