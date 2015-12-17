From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [V1, 1/2] i2c: brcmstb: Adding support for CM and DSL SoCs
Date: Thu, 17 Dec 2015 15:56:52 -0800
Message-ID: <56734BC4.8060704@gmail.com>
References: <1450298950-5229-1-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34677 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbbLQX5I (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 17 Dec 2015 18:57:08 -0500
Received: by mail-pf0-f180.google.com with SMTP id 68so38676922pfc.1
        for <linux-i2c@vger.kernel.org>; Thu, 17 Dec 2015 15:57:08 -0800 (PST)
In-Reply-To: <1450298950-5229-1-git-send-email-kdasu.kdev@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kamal Dasu <kdasu.kdev@gmail.com>, linux-i2c@vger.kernel.org, wsa@the-dreams.de
Cc: f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com

On 16/12/15 12:49, Kamal Dasu wrote:
> Broadcoms DSL, CM (cable modem)and STB I2C core implementation have
> 8 data in/out registers that can transfer 8 bytes or 32 bytes max.
> Cable and DSL "Peripheral" i2c cores use single byte per data
> register and the STB can use 4 byte per data register transfer.
> Adding support to take care of this difference. Accordingly added
> the compatible string for SoCs using the "Peripheral" I2C block.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Kamal!

> ---
>  drivers/i2c/busses/i2c-brcmstb.c | 80 ++++++++++++++++++++++++++++------------
>  1 file changed, 56 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
> index 8e9637e..3711df1 100644
> --- a/drivers/i2c/busses/i2c-brcmstb.c
> +++ b/drivers/i2c/busses/i2c-brcmstb.c
> @@ -25,13 +25,16 @@
>  #include <linux/version.h>
>  
>  #define N_DATA_REGS					8
> -#define N_DATA_BYTES					(N_DATA_REGS * 4)
>  
> -/* BSC count register field definitions */
> -#define BSC_CNT_REG1_MASK				0x0000003f
> -#define BSC_CNT_REG1_SHIFT				0
> -#define BSC_CNT_REG2_MASK				0x00000fc0
> -#define BSC_CNT_REG2_SHIFT				6
> +/*
> + * PER_I2C/BSC count register mask depends on 1 byte/4 byte data register
> + * size. Cable modem and DSL SoCs with Peripheral i2c cores use 1 byte per
> + * data register whereas STB SoCs use 4 byte per data register transfer,
> + * account for this difference in total count per transaction and mask to
> + * use.
> + */
> +#define BSC_CNT_REG1_MASK(nb)	(nb == 1 ? GENMASK(3, 0) : GENMASK(5, 0))
> +#define BSC_CNT_REG1_SHIFT	0
>  
>  /* BSC CTL register field definitions */
>  #define BSC_CTL_REG_DTF_MASK				0x00000003
> @@ -41,7 +44,7 @@
>  #define BSC_CTL_REG_INT_EN_SHIFT			6
>  #define BSC_CTL_REG_DIV_CLK_MASK			0x00000080
>  
> -/* BSC_IIC_ENABLE r/w enable and interrupt field defintions */
> +/* BSC_IIC_ENABLE r/w enable and interrupt field definitions */
>  #define BSC_IIC_EN_RESTART_MASK				0x00000040
>  #define BSC_IIC_EN_NOSTART_MASK				0x00000020
>  #define BSC_IIC_EN_NOSTOP_MASK				0x00000010
> @@ -169,6 +172,7 @@ struct brcmstb_i2c_dev {
>  	struct completion done;
>  	bool is_suspended;
>  	u32 clk_freq_hz;
> +	int data_regsz;
>  };
>  
>  /* register accessors for both be and le cpu arch */
> @@ -186,6 +190,16 @@ struct brcmstb_i2c_dev {
>  #define bsc_writel(_dev, _val, _reg)					\
>  	__bsc_writel(_val, _dev->base + offsetof(struct bsc_regs, _reg))
>  
> +static inline int brcmstb_i2c_get_xfersz(struct brcmstb_i2c_dev *dev)
> +{
> +	return (N_DATA_REGS * dev->data_regsz);
> +}
> +
> +static inline int brcmstb_i2c_get_data_regsz(struct brcmstb_i2c_dev *dev)
> +{
> +	return dev->data_regsz;
> +}
> +
>  static void brcmstb_i2c_enable_disable_irq(struct brcmstb_i2c_dev *dev,
>  					   bool int_en)
>  {
> @@ -323,14 +337,16 @@ static int brcmstb_i2c_xfer_bsc_data(struct brcmstb_i2c_dev *dev,
>  				     u8 *buf, unsigned int len,
>  				     struct i2c_msg *pmsg)
>  {
> -	int cnt, byte, rc;
> +	int cnt, byte, i, rc;
>  	enum bsc_xfer_cmd cmd;
>  	u32 ctl_reg;
>  	struct bsc_regs *pi2creg = dev->bsc_regmap;
>  	int no_ack = pmsg->flags & I2C_M_IGNORE_NAK;
> +	int data_regsz = brcmstb_i2c_get_data_regsz(dev);
> +	int xfersz = brcmstb_i2c_get_xfersz(dev);
>  
>  	/* see if the transaction needs to check NACK conditions */
> -	if (no_ack || len <= N_DATA_BYTES) {
> +	if (no_ack || len <= xfersz) {
>  		cmd = (pmsg->flags & I2C_M_RD) ? CMD_RD_NOACK
>  			: CMD_WR_NOACK;
>  		pi2creg->ctlhi_reg |= BSC_CTLHI_REG_IGNORE_ACK_MASK;
> @@ -348,20 +364,22 @@ static int brcmstb_i2c_xfer_bsc_data(struct brcmstb_i2c_dev *dev,
>  		pi2creg->ctl_reg = ctl_reg | DTF_RD_MASK;
>  
>  	/* set the read/write length */
> -	bsc_writel(dev, BSC_CNT_REG1_MASK & (len << BSC_CNT_REG1_SHIFT),
> -		   cnt_reg);
> +	bsc_writel(dev, BSC_CNT_REG1_MASK(data_regsz) &
> +		   (len << BSC_CNT_REG1_SHIFT), cnt_reg);
>  
>  	/* Write data into data_in register */
> +
>  	if (cmd == CMD_WR || cmd == CMD_WR_NOACK) {
> -		for (cnt = 0; cnt < len; cnt += 4) {
> +		for (cnt = 0, i = 0; cnt < len; cnt += data_regsz, i++) {
>  			u32 word = 0;
>  
> -			for (byte = 0; byte < 4; byte++) {
> -				word >>= 8;
> +			for (byte = 0; byte < data_regsz; byte++) {
> +				word >>= BITS_PER_BYTE;
>  				if ((cnt + byte) < len)
> -					word |= buf[cnt + byte] << 24;
> +					word |= buf[cnt + byte] <<
> +					(BITS_PER_BYTE * (data_regsz - 1));
>  			}
> -			bsc_writel(dev, word, data_in[cnt >> 2]);
> +			bsc_writel(dev, word, data_in[i]);
>  		}
>  	}
>  
> @@ -373,14 +391,15 @@ static int brcmstb_i2c_xfer_bsc_data(struct brcmstb_i2c_dev *dev,
>  		return rc;
>  	}
>  
> +	/* Read data from data_out register */
>  	if (cmd == CMD_RD || cmd == CMD_RD_NOACK) {
> -		for (cnt = 0; cnt < len; cnt += 4) {
> -			u32 data = bsc_readl(dev, data_out[cnt >> 2]);
> +		for (cnt = 0, i = 0; cnt < len; cnt += data_regsz, i++) {
> +			u32 data = bsc_readl(dev, data_out[i]);
>  
> -			for (byte = 0; byte < 4 &&
> +			for (byte = 0; byte < data_regsz &&
>  				     (byte + cnt) < len; byte++) {
>  				buf[cnt + byte] = data & 0xff;
> -				data >>= 8;
> +				data >>= BITS_PER_BYTE;
>  			}
>  		}
>  	}
> @@ -448,6 +467,7 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
>  	int bytes_to_xfer;
>  	u8 *tmp_buf;
>  	int len = 0;
> +	int xfersz = brcmstb_i2c_get_xfersz(dev);
>  
>  	if (dev->is_suspended)
>  		return -EBUSY;
> @@ -482,9 +502,9 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
>  
>  		/* Perform data transfer */
>  		while (len) {
> -			bytes_to_xfer = min(len, N_DATA_BYTES);
> +			bytes_to_xfer = min(len, xfersz);
>  
> -			if (len <= N_DATA_BYTES && i == (num - 1))
> +			if (len <= xfersz && i == (num - 1))
>  				brcmstb_set_i2c_start_stop(dev,
>  							   ~(COND_START_STOP));
>  
> @@ -542,8 +562,12 @@ static void brcmstb_i2c_set_bus_speed(struct brcmstb_i2c_dev *dev)
>  
>  static void brcmstb_i2c_set_bsc_reg_defaults(struct brcmstb_i2c_dev *dev)
>  {
> -	/* 4 byte data register */
> -	dev->bsc_regmap->ctlhi_reg = BSC_CTLHI_REG_DATAREG_SIZE_MASK;
> +	if (brcmstb_i2c_get_data_regsz(dev) == sizeof(u32))
> +		/* set 4 byte data in/out xfers  */
> +		dev->bsc_regmap->ctlhi_reg = BSC_CTLHI_REG_DATAREG_SIZE_MASK;
> +	else
> +		dev->bsc_regmap->ctlhi_reg &= ~BSC_CTLHI_REG_DATAREG_SIZE_MASK;
> +
>  	bsc_writel(dev, dev->bsc_regmap->ctlhi_reg, ctlhi_reg);
>  	/* set bus speed */
>  	brcmstb_i2c_set_bus_speed(dev);
> @@ -608,6 +632,13 @@ static int brcmstb_i2c_probe(struct platform_device *pdev)
>  		dev->clk_freq_hz = bsc_clk[0].hz;
>  	}
>  
> +	/* set the data in/out register size for compatible SoCs */
> +	if (of_device_is_compatible(dev->device->of_node,
> +				    "brcmstb,brcmper-i2c"))
> +		dev->data_regsz = sizeof(u8);
> +	else
> +		dev->data_regsz = sizeof(u32);
> +
>  	brcmstb_i2c_set_bsc_reg_defaults(dev);
>  
>  	/* Add the i2c adapter */
> @@ -674,6 +705,7 @@ static SIMPLE_DEV_PM_OPS(brcmstb_i2c_pm, brcmstb_i2c_suspend,
>  
>  static const struct of_device_id brcmstb_i2c_of_match[] = {
>  	{.compatible = "brcm,brcmstb-i2c"},
> +	{.compatible = "brcm,brcmper-i2c"},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, brcmstb_i2c_of_match);
> 


-- 
Florian
