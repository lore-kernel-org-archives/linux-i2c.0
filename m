From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH] i2c: i2c-stm32f7: fix a race in slave mode with
 arbitration loss irq
Date: Tue, 1 Oct 2019 14:21:16 +0200
Message-ID: <e30de80a-6ecd-a2a6-8742-8dcdd1c3253c@st.com>
References: <1569919869-3218-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1569919869-3218-1-git-send-email-fabrice.gasnier@st.com>
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
To: Fabrice Gasnier <fabrice.gasnier@st.com>, wsa@the-dreams.de
Cc: alexandre.torgue@st.com, linux-kernel@vger.kernel.org, alain.volmat@st.com, linux-i2c@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi

Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Thx

On 10/1/19 10:51 AM, Fabrice Gasnier wrote:
> When in slave mode, an arbitration loss (ARLO) may be detected before the
> slave had a chance to detect the stop condition (STOPF in ISR).
> This is seen when two master + slave adapters switch their roles. It
> provokes the i2c bus to be stuck, busy as SCL line is stretched.
> - the I2C_SLAVE_STOP event is never generated due to STOPF flag is set but
>   don't generate an irq (race with ARLO irq, STOPIE is masked). STOPF flag
>   remains set until next master xfer (e.g. when STOPIE irq get unmasked).
>   In this case, completion is generated too early: immediately upon new
>   transfer request (then it doesn't send all data).
> - Some data get stuck in TXDR register. As a consequence, the controller
>   stretches the SCL line: the bus gets busy until a future master transfer
>   triggers the bus busy / recovery mechanism (this can take time... and
>   may never happen at all)
> 
> So choice is to let the STOPF being detected by the slave isr handler,
> to properly handle this stop condition. E.g. don't mask IRQs in error
> handler, when the slave is running.
> 
> Fixes: 60d609f30de2 ("i2c: i2c-stm32f7: Add slave support")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index 266d1c2..3a8ab0c 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -1501,7 +1501,7 @@ static irqreturn_t stm32f7_i2c_isr_error(int irq, void *data)
>  	void __iomem *base = i2c_dev->base;
>  	struct device *dev = i2c_dev->dev;
>  	struct stm32_i2c_dma *dma = i2c_dev->dma;
> -	u32 mask, status;
> +	u32 status;
>  
>  	status = readl_relaxed(i2c_dev->base + STM32F7_I2C_ISR);
>  
> @@ -1526,12 +1526,15 @@ static irqreturn_t stm32f7_i2c_isr_error(int irq, void *data)
>  		f7_msg->result = -EINVAL;
>  	}
>  
> -	/* Disable interrupts */
> -	if (stm32f7_i2c_is_slave_registered(i2c_dev))
> -		mask = STM32F7_I2C_XFER_IRQ_MASK;
> -	else
> -		mask = STM32F7_I2C_ALL_IRQ_MASK;
> -	stm32f7_i2c_disable_irq(i2c_dev, mask);
> +	if (!i2c_dev->slave_running) {
> +		u32 mask;
> +		/* Disable interrupts */
> +		if (stm32f7_i2c_is_slave_registered(i2c_dev))
> +			mask = STM32F7_I2C_XFER_IRQ_MASK;
> +		else
> +			mask = STM32F7_I2C_ALL_IRQ_MASK;
> +		stm32f7_i2c_disable_irq(i2c_dev, mask);
> +	}
>  
>  	/* Disable dma */
>  	if (i2c_dev->use_dma) {
> 
