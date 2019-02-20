From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 3/3] i2c: mediatek: Add i2c support for MediaTek MT8183
Date: Wed, 20 Feb 2019 15:41:41 +0100
Message-ID: <40bf7264-1fc7-320a-1122-1782b57c5b53@gmail.com>
References: <1550666030-30211-1-git-send-email-qii.wang@mediatek.com>
 <1550666030-30211-4-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550666030-30211-4-git-send-email-qii.wang@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Qii Wang <qii.wang@mediatek.com>, wsa@the-dreams.de
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com, robh@kernel.org, leilk.liu@mediatek.com, xinping.qian@mediatek.com, linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org



On 20/02/2019 13:33, Qii Wang wrote:
> Add i2c compatible for MT8183. Compare to MT2712 i2c controller,
> MT8183 has different registers, offsets and clock.
> 
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>

So you introduce arb clock, ltiming (what is this exactly) and the new SoC in
one commit. I'd prefer to split that up and explain shortly in the commit
message why they are needed. More comments inline.

> ---
>  drivers/i2c/busses/i2c-mt65xx.c |   89 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 84 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index 428ac99..82eedbd 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -35,6 +35,7 @@
>  #include <linux/slab.h>
>  
>  #define I2C_RS_TRANSFER			(1 << 4)
> +#define I2C_ARB_LOST			(1 << 3)
>  #define I2C_HS_NACKERR			(1 << 2)
>  #define I2C_ACKERR			(1 << 1)
>  #define I2C_TRANSAC_COMP		(1 << 0)
> @@ -76,6 +77,8 @@
>  #define I2C_CONTROL_DIR_CHANGE          (0x1 << 4)
>  #define I2C_CONTROL_ACKERR_DET_EN       (0x1 << 5)
>  #define I2C_CONTROL_TRANSFER_LEN_CHANGE (0x1 << 6)
> +#define I2C_CONTROL_DMAACK_EN           (0x1 << 8)
> +#define I2C_CONTROL_ASYNC_MODE          (0x1 << 9)
>  #define I2C_CONTROL_WRAPPER             (0x1 << 0)
>  
>  #define I2C_DRV_NAME		"i2c-mt65xx"
> @@ -130,6 +133,8 @@ enum I2C_REGS_OFFSET {
>  	OFFSET_DEBUGCTRL,
>  	OFFSET_TRANSFER_LEN_AUX,
>  	OFFSET_CLOCK_DIV,
> +	/* MT8183 only regs */
> +	OFFSET_LTIMING,
>  };
>  
>  static const u16 mt_i2c_regs_v1[] = {
> @@ -159,6 +164,32 @@ enum I2C_REGS_OFFSET {
>  	[OFFSET_CLOCK_DIV] = 0x70,
>  };
>  
> +static const u16 mt_i2c_regs_v2[] = {
> +	[OFFSET_DATA_PORT] = 0x0,
> +	[OFFSET_SLAVE_ADDR] = 0x4,
> +	[OFFSET_INTR_MASK] = 0x8,
> +	[OFFSET_INTR_STAT] = 0xc,
> +	[OFFSET_CONTROL] = 0x10,
> +	[OFFSET_TRANSFER_LEN] = 0x14,
> +	[OFFSET_TRANSAC_LEN] = 0x18,
> +	[OFFSET_DELAY_LEN] = 0x1c,
> +	[OFFSET_TIMING] = 0x20,
> +	[OFFSET_START] = 0x24,
> +	[OFFSET_EXT_CONF] = 0x28,
> +	[OFFSET_LTIMING] = 0x2c,
> +	[OFFSET_HS] = 0x30,
> +	[OFFSET_IO_CONFIG] = 0x34,
> +	[OFFSET_FIFO_ADDR_CLR] = 0x38,
> +	[OFFSET_TRANSFER_LEN_AUX] = 0x44,
> +	[OFFSET_CLOCK_DIV] = 0x48,
> +	[OFFSET_SOFTRESET] = 0x50,
> +	[OFFSET_DEBUGSTAT] = 0xe0,
> +	[OFFSET_DEBUGCTRL] = 0xe8,
> +	[OFFSET_FIFO_STAT] = 0xf4,
> +	[OFFSET_FIFO_THRESH] = 0xf8,
> +	[OFFSET_DCM_EN] = 0xf88,
> +};
> +
>  struct mtk_i2c_compatible {
>  	const struct i2c_adapter_quirks *quirks;
>  	const u16 *regs;
> @@ -168,6 +199,7 @@ struct mtk_i2c_compatible {
>  	unsigned char aux_len_reg: 1;
>  	unsigned char support_33bits: 1;
>  	unsigned char timing_adjust: 1;
> +	unsigned char dma_sync: 1;
>  };
>  
>  struct mtk_i2c {
> @@ -181,6 +213,7 @@ struct mtk_i2c {
>  	struct clk *clk_main;		/* main clock for i2c bus */
>  	struct clk *clk_dma;		/* DMA clock for i2c via DMA */
>  	struct clk *clk_pmic;		/* PMIC clock for i2c from PMIC */
> +	struct clk *clk_arb;		/* Arbitrator clock for i2c */
>  	bool have_pmic;			/* can use i2c pins from PMIC */
>  	bool use_push_pull;		/* IO config push-pull mode */
>  
> @@ -190,6 +223,7 @@ struct mtk_i2c {
>  	enum mtk_trans_op op;
>  	u16 timing_reg;
>  	u16 high_speed_reg;
> +	u16 ltiming_reg;
>  	unsigned char auto_restart;
>  	bool ignore_restart_irq;
>  	const struct mtk_i2c_compatible *dev_comp;
> @@ -216,6 +250,7 @@ struct mtk_i2c {
>  	.aux_len_reg = 1,
>  	.support_33bits = 1,
>  	.timing_adjust = 1,
> +	.dma_sync = 0,
>  };
>  
>  static const struct mtk_i2c_compatible mt6577_compat = {
> @@ -227,6 +262,7 @@ struct mtk_i2c {
>  	.aux_len_reg = 0,
>  	.support_33bits = 0,
>  	.timing_adjust = 0,
> +	.dma_sync = 0,
>  };
>  
>  static const struct mtk_i2c_compatible mt6589_compat = {
> @@ -238,6 +274,7 @@ struct mtk_i2c {
>  	.aux_len_reg = 0,
>  	.support_33bits = 0,
>  	.timing_adjust = 0,
> +	.dma_sync = 0,
>  };
>  
>  static const struct mtk_i2c_compatible mt7622_compat = {
> @@ -249,6 +286,7 @@ struct mtk_i2c {
>  	.aux_len_reg = 1,
>  	.support_33bits = 0,
>  	.timing_adjust = 0,
> +	.dma_sync = 0,
>  };
>  
>  static const struct mtk_i2c_compatible mt8173_compat = {
> @@ -259,6 +297,18 @@ struct mtk_i2c {
>  	.aux_len_reg = 1,
>  	.support_33bits = 1,
>  	.timing_adjust = 0,
> +	.dma_sync = 0,
> +};
> +
> +static const struct mtk_i2c_compatible mt8183_compat = {
> +	.regs = mt_i2c_regs_v2,
> +	.pmic_i2c = 0,
> +	.dcm = 0,
> +	.auto_restart = 1,
> +	.aux_len_reg = 1,
> +	.support_33bits = 1,
> +	.timing_adjust = 1,
> +	.dma_sync = 1,
>  };
>  
>  static const struct of_device_id mtk_i2c_of_match[] = {
> @@ -267,6 +317,7 @@ struct mtk_i2c {
>  	{ .compatible = "mediatek,mt6589-i2c", .data = &mt6589_compat },
>  	{ .compatible = "mediatek,mt7622-i2c", .data = &mt7622_compat },
>  	{ .compatible = "mediatek,mt8173-i2c", .data = &mt8173_compat },
> +	{ .compatible = "mediatek,mt8183-i2c", .data = &mt8183_compat },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);
> @@ -299,8 +350,18 @@ static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
>  		if (ret)
>  			goto err_pmic;
>  	}
> +
> +	if (i2c->clk_arb) {
> +		ret = clk_prepare_enable(i2c->clk_arb);
> +		if (ret)
> +			goto err_arb;
> +	}
> +
>  	return 0;
>  
> +err_arb:
> +	if (i2c->have_pmic)
> +		clk_disable_unprepare(i2c->clk_pmic);
>  err_pmic:
>  	clk_disable_unprepare(i2c->clk_main);
>  err_main:
> @@ -311,6 +372,9 @@ static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
>  
>  static void mtk_i2c_clock_disable(struct mtk_i2c *i2c)
>  {
> +	if (i2c->clk_arb)
> +		clk_disable_unprepare(i2c->clk_arb);
> +
>  	if (i2c->have_pmic)
>  		clk_disable_unprepare(i2c->clk_pmic);
>  
> @@ -338,6 +402,8 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
>  
>  	mtk_i2c_writew(i2c, i2c->timing_reg, OFFSET_TIMING);
>  	mtk_i2c_writew(i2c, i2c->high_speed_reg, OFFSET_HS);
> +	if (i2c->dev_comp->regs == mt_i2c_regs_v2)

I'm not really happy with this check. I personally would prefer a flag or
something which shows that we need ltiming.

> +		mtk_i2c_writew(i2c, i2c->ltiming_reg, OFFSET_LTIMING);
>  
>  	/* If use i2c pin from PMIC mt6397 side, need set PATH_DIR first */
>  	if (i2c->have_pmic)
> @@ -345,6 +411,9 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
>  
>  	control_reg = I2C_CONTROL_ACKERR_DET_EN |
>  		      I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN;
> +	if (i2c->dev_comp->dma_sync)
> +		control_reg |= I2C_CONTROL_DMAACK_EN | I2C_CONTROL_ASYNC_MODE;
> +
>  	mtk_i2c_writew(i2c, control_reg, OFFSET_CONTROL);
>  	mtk_i2c_writew(i2c, I2C_DELAY_LEN, OFFSET_DELAY_LEN);
>  
> @@ -434,6 +503,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
>  	unsigned int clk_src;
>  	unsigned int step_cnt;
>  	unsigned int sample_cnt;
> +	unsigned int l_step_cnt;
> +	unsigned int l_sample_cnt;
>  	unsigned int target_speed;
>  	int ret;
>  
> @@ -443,11 +514,11 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
>  	if (target_speed > MAX_FS_MODE_SPEED) {
>  		/* Set master code speed register */
>  		ret = mtk_i2c_calculate_speed(i2c, clk_src, MAX_FS_MODE_SPEED,
> -					      &step_cnt, &sample_cnt);
> +					      &l_step_cnt, &l_sample_cnt);
>  		if (ret < 0)
>  			return ret;
>  
> -		i2c->timing_reg = (sample_cnt << 8) | step_cnt;
> +		i2c->timing_reg = (l_sample_cnt << 8) | l_step_cnt;
>  
>  		/* Set the high speed mode register */
>  		ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
> @@ -457,6 +528,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
>  
>  		i2c->high_speed_reg = I2C_TIME_DEFAULT_VALUE |
>  			(sample_cnt << 12) | (step_cnt << 8);
> +		i2c->ltiming_reg = (l_sample_cnt << 6) | l_step_cnt |
> +				   (sample_cnt << 12) | (step_cnt << 9);

IMHO setting these for all SoCs but then only using it for one makes things more
complicated. Value should only be set for SoCs that need this features.

>  	} else {
>  		ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
>  					      &step_cnt, &sample_cnt);
> @@ -467,6 +540,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
>  
>  		/* Disable the high speed transaction */
>  		i2c->high_speed_reg = I2C_TIME_CLR_VALUE;
> +
> +		i2c->ltiming_reg = (sample_cnt << 6) | step_cnt;
>  	}
>  
>  	return 0;
> @@ -519,13 +594,13 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>  
>  	/* Clear interrupt status */
>  	mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -	       I2C_TRANSAC_COMP, OFFSET_INTR_STAT);
> +			    I2C_ARB_LOST | I2C_TRANSAC_COMP, OFFSET_INTR_STAT);

Did you test that this works with all the old SoCs that are already supported by
this driver?

Regards,
Matthias

>  
>  	mtk_i2c_writew(i2c, I2C_FIFO_ADDR_CLR, OFFSET_FIFO_ADDR_CLR);
>  
>  	/* Enable interrupt */
>  	mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -	       I2C_TRANSAC_COMP, OFFSET_INTR_MASK);
> +			    I2C_ARB_LOST | I2C_TRANSAC_COMP, OFFSET_INTR_MASK);
>  
>  	/* Set transfer and transaction len */
>  	if (i2c->op == I2C_MASTER_WRRD) {
> @@ -659,7 +734,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>  
>  	/* Clear interrupt mask */
>  	mtk_i2c_writew(i2c, ~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -	       I2C_TRANSAC_COMP), OFFSET_INTR_MASK);
> +			    I2C_ARB_LOST | I2C_TRANSAC_COMP), OFFSET_INTR_MASK);
>  
>  	if (i2c->op == I2C_MASTER_WR) {
>  		dma_unmap_single(i2c->dev, wpaddr,
> @@ -884,6 +959,10 @@ static int mtk_i2c_probe(struct platform_device *pdev)
>  		return PTR_ERR(i2c->clk_dma);
>  	}
>  
> +	i2c->clk_arb = devm_clk_get(&pdev->dev, "arb");
> +	if (IS_ERR(i2c->clk_arb))
> +		i2c->clk_arb = NULL;
> +
>  	clk = i2c->clk_main;
>  	if (i2c->have_pmic) {
>  		i2c->clk_pmic = devm_clk_get(&pdev->dev, "pmic");
> 
