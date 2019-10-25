From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH] i2c: i2c-stm32f7: fix & reorder remove & probe error
 handling
Date: Fri, 25 Oct 2019 16:11:10 +0200
Message-ID: <37fc56c5-a700-a05b-2669-25295172dbdc@st.com>
References: <1572012264-31996-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1572012264-31996-1-git-send-email-alain.volmat@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alain Volmat <alain.volmat@st.com>, wsa@the-dreams.de
Cc: alexandre.torgue@st.com, linux-i2c@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com
List-Id: linux-i2c@vger.kernel.org

Hi

Look good for me

Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Thanks

On 10/25/19 4:04 PM, Alain Volmat wrote:
> Add missing dma channels free calls in case of error during probe
> and reorder the remove function so that dma channels are freed after
> the i2c adapter is deleted.
> Overall, reorder the remove function so that probe error handling order
> and remove function order are same.
> 
> Fixes: 7ecc8cfde553 ("i2c: i2c-stm32f7: Add DMA support")
> 
> Signed-off-by: Alain Volmat <alain.volmat@st.com>
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index d36cf08461f7..f8ef203dabfc 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -1980,6 +1980,11 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
>  	pm_runtime_set_suspended(i2c_dev->dev);
>  	pm_runtime_dont_use_autosuspend(i2c_dev->dev);
>  
> +	if (i2c_dev->dma) {
> +		stm32_i2c_dma_free(i2c_dev->dma);
> +		i2c_dev->dma = NULL;
> +	}
> +
>  clk_free:
>  	clk_disable_unprepare(i2c_dev->clk);
>  
> @@ -1990,21 +1995,21 @@ static int stm32f7_i2c_remove(struct platform_device *pdev)
>  {
>  	struct stm32f7_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
>  
> -	if (i2c_dev->dma) {
> -		stm32_i2c_dma_free(i2c_dev->dma);
> -		i2c_dev->dma = NULL;
> -	}
> -
>  	i2c_del_adapter(&i2c_dev->adap);
>  	pm_runtime_get_sync(i2c_dev->dev);
>  
> -	clk_disable_unprepare(i2c_dev->clk);
> -
>  	pm_runtime_put_noidle(i2c_dev->dev);
>  	pm_runtime_disable(i2c_dev->dev);
>  	pm_runtime_set_suspended(i2c_dev->dev);
>  	pm_runtime_dont_use_autosuspend(i2c_dev->dev);
>  
> +	if (i2c_dev->dma) {
> +		stm32_i2c_dma_free(i2c_dev->dma);
> +		i2c_dev->dma = NULL;
> +	}
> +
> +	clk_disable_unprepare(i2c_dev->clk);
> +
>  	return 0;
>  }
>  
> 
