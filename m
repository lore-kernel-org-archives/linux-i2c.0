From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH RESEND v6 4/6] i2c: mediatek: Add i2c and apdma sync in
 i2c driver
Date: Fri, 12 Apr 2019 20:42:19 +0200
Message-ID: <b0697798-af4a-7b98-762a-6990711ccb3a@gmail.com>
References: <1554208560-14817-1-git-send-email-qii.wang@mediatek.com>
 <1554208560-14817-5-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554208560-14817-5-git-send-email-qii.wang@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Qii Wang <qii.wang@mediatek.com>, wsa@the-dreams.de
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com, robh@kernel.org, leilk.liu@mediatek.com, xinping.qian@mediatek.com, linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org



On 02/04/2019 14:35, Qii Wang wrote:
> When i2c and apdma use different source clocks, we should enable
> synchronization between them.
> 
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>  drivers/i2c/busses/i2c-mt65xx.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index 1a7235e..6137ad7 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -77,6 +77,8 @@
>  #define I2C_CONTROL_DIR_CHANGE          (0x1 << 4)
>  #define I2C_CONTROL_ACKERR_DET_EN       (0x1 << 5)
>  #define I2C_CONTROL_TRANSFER_LEN_CHANGE (0x1 << 6)
> +#define I2C_CONTROL_DMAACK_EN           (0x1 << 8)
> +#define I2C_CONTROL_ASYNC_MODE          (0x1 << 9)
>  #define I2C_CONTROL_WRAPPER             (0x1 << 0)
>  
>  #define I2C_DRV_NAME		"i2c-mt65xx"
> @@ -169,6 +171,7 @@ struct mtk_i2c_compatible {
>  	unsigned char aux_len_reg: 1;
>  	unsigned char support_33bits: 1;
>  	unsigned char timing_adjust: 1;
> +	unsigned char dma_sync: 1;
>  };
>  
>  struct mtk_i2c {
> @@ -218,6 +221,7 @@ struct mtk_i2c {
>  	.aux_len_reg = 1,
>  	.support_33bits = 1,
>  	.timing_adjust = 1,
> +	.dma_sync = 0,
>  };
>  
>  static const struct mtk_i2c_compatible mt6577_compat = {
> @@ -229,6 +233,7 @@ struct mtk_i2c {
>  	.aux_len_reg = 0,
>  	.support_33bits = 0,
>  	.timing_adjust = 0,
> +	.dma_sync = 0,
>  };
>  
>  static const struct mtk_i2c_compatible mt6589_compat = {
> @@ -240,6 +245,7 @@ struct mtk_i2c {
>  	.aux_len_reg = 0,
>  	.support_33bits = 0,
>  	.timing_adjust = 0,
> +	.dma_sync = 0,
>  };
>  
>  static const struct mtk_i2c_compatible mt7622_compat = {
> @@ -251,6 +257,7 @@ struct mtk_i2c {
>  	.aux_len_reg = 1,
>  	.support_33bits = 0,
>  	.timing_adjust = 0,
> +	.dma_sync = 0,
>  };
>  
>  static const struct mtk_i2c_compatible mt8173_compat = {
> @@ -261,6 +268,7 @@ struct mtk_i2c {
>  	.aux_len_reg = 1,
>  	.support_33bits = 1,
>  	.timing_adjust = 0,
> +	.dma_sync = 0,
>  };
>  
>  static const struct of_device_id mtk_i2c_of_match[] = {
> @@ -360,6 +368,9 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
>  
>  	control_reg = I2C_CONTROL_ACKERR_DET_EN |
>  		      I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN;
> +	if (i2c->dev_comp->dma_sync)
> +		control_reg |= I2C_CONTROL_DMAACK_EN | I2C_CONTROL_ASYNC_MODE;
> +
>  	mtk_i2c_writew(i2c, control_reg, OFFSET_CONTROL);
>  	mtk_i2c_writew(i2c, I2C_DELAY_LEN, OFFSET_DELAY_LEN);
>  
> 
