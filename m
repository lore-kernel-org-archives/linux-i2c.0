From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH] i2c: stm32: don't print an error on probe deferral
Date: Mon, 30 Mar 2020 10:40:59 +0200
Message-ID: <9f51c667-cb26-a087-b2a3-2cf2ddf09a87@st.com>
References: <1584642136-15418-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <1584642136-15418-1-git-send-email-alain.volmat@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alain Volmat <alain.volmat@st.com>, wsa@the-dreams.de
Cc: alexandre.torgue@st.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hello !

Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Thanks

On 3/19/20 7:22 PM, Alain Volmat wrote:
> From: Etienne Carriere <etienne.carriere@st.com>
> 
> Do not print an error trace when deferring probe for some resource.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> Signed-off-by: Alain Volmat <alain.volmat@st.com>
> ---
>  drivers/i2c/busses/i2c-stm32.c   | 10 +++++++---
>  drivers/i2c/busses/i2c-stm32f4.c |  4 +++-
>  drivers/i2c/busses/i2c-stm32f7.c |  7 +++++--
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32.c b/drivers/i2c/busses/i2c-stm32.c
> index 1da347e6a358..7be559858402 100644
> --- a/drivers/i2c/busses/i2c-stm32.c
> +++ b/drivers/i2c/busses/i2c-stm32.c
> @@ -25,8 +25,9 @@ struct stm32_i2c_dma *stm32_i2c_dma_request(struct device *dev,
>  	/* Request and configure I2C TX dma channel */
>  	dma->chan_tx = dma_request_chan(dev, "tx");
>  	if (IS_ERR(dma->chan_tx)) {
> -		dev_dbg(dev, "can't request DMA tx channel\n");
>  		ret = PTR_ERR(dma->chan_tx);
> +		if (ret != -EPROBE_DEFER)
> +			dev_dbg(dev, "can't request DMA tx channel\n");
>  		goto fail_al;
>  	}
>  
> @@ -44,8 +45,10 @@ struct stm32_i2c_dma *stm32_i2c_dma_request(struct device *dev,
>  	/* Request and configure I2C RX dma channel */
>  	dma->chan_rx = dma_request_chan(dev, "rx");
>  	if (IS_ERR(dma->chan_rx)) {
> -		dev_err(dev, "can't request DMA rx channel\n");
>  		ret = PTR_ERR(dma->chan_rx);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "can't request DMA rx channel\n");
> +
>  		goto fail_tx;
>  	}
>  
> @@ -73,7 +76,8 @@ struct stm32_i2c_dma *stm32_i2c_dma_request(struct device *dev,
>  	dma_release_channel(dma->chan_tx);
>  fail_al:
>  	devm_kfree(dev, dma);
> -	dev_info(dev, "can't use DMA\n");
> +	if (ret != -EPROBE_DEFER)
> +		dev_info(dev, "can't use DMA\n");
>  
>  	return ERR_PTR(ret);
>  }
> diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
> index ba600d77a3f8..1b8cad506ad7 100644
> --- a/drivers/i2c/busses/i2c-stm32f4.c
> +++ b/drivers/i2c/busses/i2c-stm32f4.c
> @@ -797,8 +797,10 @@ static int stm32f4_i2c_probe(struct platform_device *pdev)
>  
>  	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>  	if (IS_ERR(rst)) {
> -		dev_err(&pdev->dev, "Error: Missing controller reset\n");
>  		ret = PTR_ERR(rst);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Error: Missing reset ctrl\n");
> +
>  		goto clk_free;
>  	}
>  	reset_control_assert(rst);
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index 78d40a4cc282..ab95ed52a7dc 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -1915,7 +1915,8 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
>  
>  	i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(i2c_dev->clk)) {
> -		dev_err(&pdev->dev, "Error: Missing controller clock\n");
> +		if (PTR_ERR(i2c_dev->clk) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to get controller clock\n");
>  		return PTR_ERR(i2c_dev->clk);
>  	}
>  
> @@ -1941,8 +1942,10 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
>  
>  	rst = devm_reset_control_get(&pdev->dev, NULL);
>  	if (IS_ERR(rst)) {
> -		dev_err(&pdev->dev, "Error: Missing controller reset\n");
>  		ret = PTR_ERR(rst);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Error: Missing reset ctrl\n");
> +
>  		goto clk_free;
>  	}
>  	reset_control_assert(rst);
> 
