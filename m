From: Steven Price <steven.price@arm.com>
Subject: Re: [RESEND] i2c: imx: defer probing on dma channel request
Date: Mon, 25 Mar 2019 17:12:33 +0000
Message-ID: <873b5aeb-e20a-de6b-515e-bc8fcc263452@arm.com>
References: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: laurentiu.tudor@nxp.com, linux-i2c@vger.kernel.org, ying.zhang22455@nxp.com
Cc: upstream-release@linux.nxdi.nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, leoyang.li@nxp.com, linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On 25/03/2019 15:30, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> If the dma controller is not yet probed, defer i2c probe.
> The error path in probe was slightly modified (no functional change)

There is a functional change for cases like:

> 	ret = pm_runtime_get_sync(&pdev->dev);
> 	if (ret < 0)
> 		goto rpm_disable;

...as rpm_disable will no longer fall through to the call of
clk_disable_unprepare().

> to avoid triggering this WARN_ON():
> "cg-pll0-div1 already disabled
> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0xb0"

I'm also not sure how this WARN_ON was hit. i2c_imx_probe() calls
clk_prepare_enable() which should increment the reference count. So it
should always be possible to decrememt the enable_count. What am I missing?

> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 42fed40198a0..4e34b1572756 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1111,7 +1111,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  				pdev->name, i2c_imx);
>  	if (ret) {
>  		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
> -		goto clk_disable;
> +		clk_disable_unprepare(i2c_imx->clk);
> +		return ret;
>  	}
>  
>  	/* Init queue */
> @@ -1161,19 +1162,25 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
>  
> +	/* Init DMA config if supported */
> +	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_info(&pdev->dev, "can't use DMA, using PIO instead.\n");
> +		else
> +			goto del_adapter;
> +	}
> +

This can be simplified by reversing the condition:

	if (ret) {
		if (ret == -EPROBE_DEFER)
			goto del_adapter;
		dev_info();
	}

or even:

	if (ret == -EPROBE_DEFER)
		goto del_adapter;
	else if (ret)
		dev_info();

>  	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
>  	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);
>  	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
>  		i2c_imx->adapter.name);
>  
> -	/* Init DMA config if supported */
> -	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
> -	if (ret < 0)
> -		goto clk_notifier_unregister;
> -
>  	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
>  	return 0;   /* Return OK */
>  
> +del_adapter:
> +	i2c_del_adapter(&i2c_imx->adapter);

This looks like a separate fix (previously the call to
i2c_add_numbered_adapter() was not undone in case of later errors). It
worth spelling this out in the commit message.

Thanks,

Steve

>  clk_notifier_unregister:
>  	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
>  rpm_disable:
> @@ -1182,8 +1189,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  
> -clk_disable:
> -	clk_disable_unprepare(i2c_imx->clk);
>  	return ret;
>  }
>  
> 
