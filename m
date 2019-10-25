From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH] i2c: i2c-stm32f7: report dma error during probe
Date: Fri, 25 Oct 2019 16:12:24 +0200
Message-ID: <fbb063f9-8f16-00ba-1a5b-deb58c711e26@st.com>
References: <1571921521-8502-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1571921521-8502-1-git-send-email-alain.volmat@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alain Volmat <alain.volmat@st.com>, wsa@the-dreams.de
Cc: alexandre.torgue@st.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi

Looks good for me

Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Regards

On 10/24/19 2:52 PM, Alain Volmat wrote:
> Distinguish between the case where dma information is not provided
> within the DT and the case of an error during the dma init.
> Exit the probe with error in case of an error during dma init.
> 
> Fixes: bb8822cbbc53 ("i2c: i2c-stm32: Add generic DMA API")
> 
> Signed-off-by: Alain Volmat <alain.volmat@st.com>
> ---
>  drivers/i2c/busses/i2c-stm32.c   | 16 ++++++++--------
>  drivers/i2c/busses/i2c-stm32f7.c |  9 +++++++++
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32.c b/drivers/i2c/busses/i2c-stm32.c
> index 07d5dfce68d4..1da347e6a358 100644
> --- a/drivers/i2c/busses/i2c-stm32.c
> +++ b/drivers/i2c/busses/i2c-stm32.c
> @@ -20,13 +20,13 @@ struct stm32_i2c_dma *stm32_i2c_dma_request(struct device *dev,
>  
>  	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
>  	if (!dma)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	/* Request and configure I2C TX dma channel */
> -	dma->chan_tx = dma_request_slave_channel(dev, "tx");
> -	if (!dma->chan_tx) {
> +	dma->chan_tx = dma_request_chan(dev, "tx");
> +	if (IS_ERR(dma->chan_tx)) {
>  		dev_dbg(dev, "can't request DMA tx channel\n");
> -		ret = -EINVAL;
> +		ret = PTR_ERR(dma->chan_tx);
>  		goto fail_al;
>  	}
>  
> @@ -42,10 +42,10 @@ struct stm32_i2c_dma *stm32_i2c_dma_request(struct device *dev,
>  	}
>  
>  	/* Request and configure I2C RX dma channel */
> -	dma->chan_rx = dma_request_slave_channel(dev, "rx");
> -	if (!dma->chan_rx) {
> +	dma->chan_rx = dma_request_chan(dev, "rx");
> +	if (IS_ERR(dma->chan_rx)) {
>  		dev_err(dev, "can't request DMA rx channel\n");
> -		ret = -EINVAL;
> +		ret = PTR_ERR(dma->chan_rx);
>  		goto fail_tx;
>  	}
>  
> @@ -75,7 +75,7 @@ struct stm32_i2c_dma *stm32_i2c_dma_request(struct device *dev,
>  	devm_kfree(dev, dma);
>  	dev_info(dev, "can't use DMA\n");
>  
> -	return NULL;
> +	return ERR_PTR(ret);
>  }
>  
>  void stm32_i2c_dma_free(struct stm32_i2c_dma *dma)
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index d36cf08461f7..cc8ba8f49ae6 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -1950,6 +1950,15 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
>  	i2c_dev->dma = stm32_i2c_dma_request(i2c_dev->dev, phy_addr,
>  					     STM32F7_I2C_TXDR,
>  					     STM32F7_I2C_RXDR);
> +	if (PTR_ERR(i2c_dev->dma) == -ENODEV)
> +		i2c_dev->dma = NULL;
> +	else if (IS_ERR(i2c_dev->dma)) {
> +		ret = PTR_ERR(i2c_dev->dma);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev,
> +				"Failed to request dma error %i\n", ret);
> +		goto clk_free;
> +	}
>  
>  	platform_set_drvdata(pdev, i2c_dev);
>  
> 
