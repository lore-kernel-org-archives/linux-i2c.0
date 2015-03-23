From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 3/3] I2C: mediatek: Add driver for MediaTek MT8173 I2C
 controller
Date: Mon, 23 Mar 2015 08:39:05 +0100
Message-ID: <20150323073905.GF9742@pengutronix.de>
References: <1426917922-61356-1-git-send-email-eddie.huang@mediatek.com>
 <1426917922-61356-4-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426917922-61356-4-git-send-email-eddie.huang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Matthias Brugger <matthias.bgg@gmail.com>, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Box <david.e.box@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.de>, Xudong Chen <xudong.chen@mediatek.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, Liguo Zhang <liguo.zhang@mediatek.com>, Wei Yan <sledge.yanwei@huawei.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Beniamino Galvani <b.galvani@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-arm-
List-Id: linux-i2c@vger.kernel.org

On Sat, Mar 21, 2015 at 02:05:22PM +0800, Eddie Huang wrote:
> Add mediatek MT8173 I2C controller driver. Compare to I2C controller
> of earlier mediatek SoC, MT8173 fix write-then-read limitation, and
> also increase message size to 64kb.
> 

[...]

> +static const struct i2c_adapter_quirks mt8173_i2c_quirks = {
> +	.max_num_msgs = MAX_MSG_NUM_MT8173,
> +	.max_write_len = MAX_DMA_TRANS_SIZE_MT8173,
> +	.max_read_len = MAX_DMA_TRANS_SIZE_MT8173,
> +	.max_comb_1st_msg_len = MAX_DMA_TRANS_SIZE_MT8173,
> +	.max_comb_2nd_msg_len = MAX_WRRD_TRANS_SIZE_MT8173,
> +};
> +
>  static int mtk_i2c_probe(struct platform_device *pdev)
>  {
>  	int ret = 0;
> @@ -587,7 +626,8 @@ static int mtk_i2c_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  
>  	i2c->platform_compat = mtk_get_device_prop(pdev);
> -	if (i2c->have_pmic && (i2c->platform_compat & COMPAT_MT6577))
> +	if (i2c->have_pmic && (i2c->platform_compat &
> +			(COMPAT_MT6577 | COMPAT_MT8173)))
>  		return -EINVAL;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -613,7 +653,10 @@ static int mtk_i2c_probe(struct platform_device *pdev)
>  	i2c->adap.dev.parent = &pdev->dev;
>  	i2c->adap.owner = THIS_MODULE;
>  	i2c->adap.algo = &mtk_i2c_algorithm;
> -	i2c->adap.quirks = &mt6577_i2c_quirks;
> +	if (i2c->platform_compat & COMPAT_MT8173)
> +		i2c->adap.quirks = &mt8173_i2c_quirks;
> +	else
> +		i2c->adap.quirks = &mt6577_i2c_quirks;

Instead of putting an integer into struct of_device_id you should
introduce a

struct mtk_i2c_data {
	struct i2c_adapter_quirks quirks;
	int compat;
	/* Additional SoC specific data */
};

and put a pointer to this directly into the of_device_id. This way you
need less casting and can put newly discovered differences diretly into
some data struct and don't have to introduce if(socxy) ... else ...
everytime.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
