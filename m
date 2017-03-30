From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RESEND][PATCH v2] i2c: designwear: Fix clk warning on
 suspend/resume
Date: Thu, 30 Mar 2017 15:39:37 +0300
Message-ID: <4d9af49e-99a4-1647-bbbb-3f146b991209@linux.intel.com>
References: <1490844377-32182-1-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:33126 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932704AbdC3Mjn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 30 Mar 2017 08:39:43 -0400
In-Reply-To: <1490844377-32182-1-git-send-email-john.stultz@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>, lkml <linux-kernel@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

Hi

On 03/30/2017 06:26 AM, John Stultz wrote:
> On my HiKey board, I'm seeing clk warnings on suspend/resume,
> which seem to be caused by runtime pm suspending the device,
> then the same suspend hook being called again on suspend time.
>
> This patch fixes this by setting the SYSTEM_SLEEP_PM_OPS to
> using pm_runtime_force_suspend and  pm_runtime_force_resume.
>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Suggested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2: Switch to suggested fix by Jarkko.
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 79c4b4e..286447c 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -382,7 +382,7 @@ static int dw_i2c_plat_resume(struct device *dev)
>  static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
>  	.prepare = dw_i2c_plat_prepare,
>  	.complete = dw_i2c_plat_complete,
> -	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
>  	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)

We cannot do this since it will break our platforms that use the 
drivers/acpi/acpi_lpss.c power domain. Reason why it fails the 
pm_runtime_force_suspend() forces acpi_lpss to power down too early 
before suspend_late state where context is expected to be saved during 
system suspend.

acpi_lpss.c power domain
.suspend = acpi_subsys_suspend
-> pm_runtime_resume
    -> acpi_lpss_runtime_resume
       -> pm_generic_runtime_resume
          -> dw_i2c_plat_resume
-> pm_generic_suspend
    -> pm_runtime_force_suspend
       -> goes through __rpm_get_callback which selects domain ops
          -> acpi_lpss_runtime_suspend (context save + power down)
             -> pm_generic_runtime_suspend
                -> dw_i2c_plat_suspend
...
.suspend_late = acpi_lpss_suspend_late
-> acpi_lpss is already power gated here due acpi_lpss_runtime_suspend() 
done during suspend phase and context save will save just 0xFFs and 
resume restores wrong context.

I managed to found a use case where I'm able to trigger 
dw_i2c_plat_suspend() callback twice during suspend. Quite deep dive to 
PM core, lot of debugging and end result is a trivial patch that just 
checks is i2c-designware runtime suspended in its suspend/resume 
callbacks... This feels somewhat boilerplate and I figured also an 
alternative solution to PM core.

I just sent that patch out and I Cc'ed both you and Rafael so he can 
comment is this the right thing to do in driver or should it be fixed in 
the PM core.

-- 
Jarkko
