From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH] i2c: i2c-stm32f7: improve nack debug message
Date: Mon, 30 Mar 2020 10:41:28 +0200
Message-ID: <ea95b420-4368-8f91-15d3-db5f18086f22@st.com>
References: <1584642115-15378-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58018 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729398AbgC3Ilm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 30 Mar 2020 04:41:42 -0400
In-Reply-To: <1584642115-15378-1-git-send-email-alain.volmat@st.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alain Volmat <alain.volmat@st.com>, wsa@the-dreams.de
Cc: alexandre.torgue@st.com, linux-i2c@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com

Hello guys !

Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Thanks

On 3/19/20 7:21 PM, Alain Volmat wrote:
> From: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> Add information on slave addr in the nack debug message.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: Alain Volmat <alain.volmat@st.com>
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index 378956ac6d1d..78d40a4cc282 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -1431,7 +1431,8 @@ static irqreturn_t stm32f7_i2c_isr_event(int irq, void *data)
>  
>  	/* NACK received */
>  	if (status & STM32F7_I2C_ISR_NACKF) {
> -		dev_dbg(i2c_dev->dev, "<%s>: Receive NACK\n", __func__);
> +		dev_dbg(i2c_dev->dev, "<%s>: Receive NACK (addr %x)\n",
> +			__func__, f7_msg->addr);
>  		writel_relaxed(STM32F7_I2C_ICR_NACKCF, base + STM32F7_I2C_ICR);
>  		f7_msg->result = -ENXIO;
>  	}
> 
