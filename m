From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH V3 1/2] i2c-designware: Add i2c bus locking support
Date: Thu, 04 Dec 2014 09:59:11 +0200
Message-ID: <5480144F.2040506@linux.intel.com>
References: <1411497626-7984-1-git-send-email-david.e.box@linux.intel.com> <1417478973-25522-1-git-send-email-david.e.box@linux.intel.com> <1417478973-25522-2-git-send-email-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417478973-25522-2-git-send-email-david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi

On 12/02/2014 02:09 AM, David E. Box wrote:
> Adds support for acquiring and releasing a hardware bus lock in the i2c
> designware core transfer function. This is needed for i2c bus controllers
> that are shared with but not controlled by the kernel.
>
> Signed-off-by: David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-designware-core.c    | 11 +++++++++++
>   drivers/i2c/busses/i2c-designware-core.h    |  6 ++++++
>   drivers/i2c/busses/i2c-designware-platdrv.c | 18 +++++++++++++-----
>   3 files changed, 30 insertions(+), 5 deletions(-)
>
...
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index a743115..afdff3b 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -261,10 +261,16 @@ static int dw_i2c_probe(struct platform_device *pdev)
>   		return r;
>   	}
>   
> -	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
> -	pm_runtime_use_autosuspend(&pdev->dev);
> -	pm_runtime_set_active(&pdev->dev);
> -	pm_runtime_enable(&pdev->dev);
> +	i2c_dw_eval_lock_support(dev);
i2c_dw_eval_lock_support() is added in the next patch.
> +
> +	if (dev->pm_runtime_disabled) {
> +		pm_runtime_forbid(&pdev->dev);
> +	} else {
> +		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
> +		pm_runtime_use_autosuspend(&pdev->dev);
> +		pm_runtime_set_active(&pdev->dev);
> +		pm_runtime_enable(&pdev->dev);
> +	}
>   
>   	return 0;
>   }
> @@ -314,7 +320,9 @@ static int dw_i2c_resume(struct device *dev)
>   	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
>   
>   	clk_prepare_enable(i_dev->clk);
> -	i2c_dw_init(i_dev);
> +
> +	if (!i_dev->pm_runtime_disabled)
> +		i2c_dw_init(i_dev);
>   
Should there be similar conditional call or locking around i2c_dw_init() 
and i2c_dw_disable_int() also in dw_i2c_probe()?

-- 
Jarkko
