From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 2/2] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Sun, 18 Jan 2015 11:18:16 +0100
Message-ID: <20150118101816.GF22880@pengutronix.de>
References: <1421404418-50718-1-git-send-email-eddie.huang@mediatek.com>
 <1421404418-50718-3-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421404418-50718-3-git-send-email-eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Uwe Kleine-Konig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bjorn Andersson <bjorn.andersson@s>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Fri, Jan 16, 2015 at 06:33:38PM +0800, Eddie Huang wrote:
> +config I2C_MT65XX
> +	tristate "MediaTek I2C adapter"
> +	depends on ARCH_MEDIATEK
depends on ARCH_MEDIATEK || COMPILE_TEST
default ARCH_MEDIATEK

would be nice to have to get better compile coverage.

> +struct mtk_i2c {
> +	struct i2c_adapter adap;	/* i2c host adapter */
> +	struct device *dev;
> +	wait_queue_head_t wait;		/* i2c transfer wait queue */
> +	/* set in i2c probe */
> +	void __iomem *base;		/* i2c base addr */
> +	void __iomem *pdmabase;		/* dma base address*/
> +	int irqnr;			/* i2c interrupt number */
irqs are unsigned quantities

> +	struct i2c_dma_buf dma_buf;	/* memory alloc for DMA mode */
> +	struct clk *clk_main;		/* main clock for i2c bus */
> +	struct clk *clk_dma;		/* DMA clock for i2c via DMA */
> +	struct clk *clk_pmic;		/* PMIC clock for i2c from PMIC */
> +	bool have_pmic;			/* can use i2c pins from PMIC */
> +	bool use_push_pull;		/* IO config push-pull mode */
> +	u32 platform_compat;		/* platform compatible data */
> +	/* set when doing the transfer */
> +	u16 irq_stat;			/* interrupt status */
> +	unsigned int speed_hz;		/* The speed in transfer */
> +	bool trans_stop;		/* i2c transfer stop */
> +	enum mtk_trans_op op;
> +	u16 msg_len;
> +	u8 *msg_buf;			/* pointer to msg data */
> +	u16 msg_aux_len;		/* WRRD mode to set AUX_LEN register*/
> +	u16 addr;	/* 7bit slave address, without read/write bit */
Wouldn't it be easier to maintain a pointer to the message to be
transferred?

> +	u16 timing_reg;
> +	u16 high_speed_reg;
> +};
> +
> +static const struct of_device_id mtk_i2c_of_match[] =3D {
> +	{ .compatible =3D "mediatek,mt6577-i2c", .data =3D (void *)COMPAT_M=
T6577 },
> +	{ .compatible =3D "mediatek,mt6589-i2c", .data =3D (void *)COMPAT_M=
T6589 },
> +	{},
There is usually no , after the sentinel entry.

> +};
> +MODULE_DEVICE_TABLE(of, mtk_i2c_match);
> +
> +static inline void i2c_writew(u16 value, struct mtk_i2c *i2c, u8 off=
set)
> +{
> +	writew(value, i2c->base + offset);
> +}
hmm, these simple wrappers are fine in general for me because they migh=
t
ease debugging or changing the accessor-function. Still "i2c_writew"
sounds too generic. IMHO you should spend the few chars to make this
mtk_i2c_writew. And to match my taste completely, move the driver data
parameter to the front. (But there are too much different tastes out
there to really request a certain style here.) Same for the other
wrappers of course.

> +	/* Prepare buffer data to start transfer */
> +	if (i2c->op =3D=3D I2C_MASTER_RD) {
> +		i2c_writel_dma(I2C_DMA_INT_FLAG_NONE, i2c, OFFSET_INT_FLAG);
> +		i2c_writel_dma(I2C_DMA_CON_RX, i2c, OFFSET_CON);
> +		i2c_writel_dma((u32)i2c->msg_buf, i2c, OFFSET_RX_MEM_ADDR);
> +		i2c_writel_dma(i2c->msg_len, i2c, OFFSET_RX_LEN);
> +	} else if (i2c->op =3D=3D I2C_MASTER_WR) {
> +		i2c_writel_dma(I2C_DMA_INT_FLAG_NONE, i2c, OFFSET_INT_FLAG);
> +		i2c_writel_dma(I2C_DMA_CON_TX, i2c, OFFSET_CON);
> +		i2c_writel_dma((u32)i2c->msg_buf, i2c, OFFSET_TX_MEM_ADDR);
> +		i2c_writel_dma(i2c->msg_len, i2c, OFFSET_TX_LEN);
> +	} else {
		/* i2c->op =3D=3D I2C_MASTER_WRRD */

> +		i2c_writel_dma(I2C_DMA_CLR_FLAG, i2c, OFFSET_INT_FLAG);
> +		i2c_writel_dma(I2C_DMA_CLR_FLAG, i2c, OFFSET_CON);
> +		i2c_writel_dma((u32)i2c->msg_buf, i2c, OFFSET_TX_MEM_ADDR);
> +		i2c_writel_dma((u32)i2c->dma_buf.paddr, i2c,
> +			OFFSET_RX_MEM_ADDR);
> +		i2c_writel_dma(i2c->msg_len, i2c, OFFSET_TX_LEN);
> +		i2c_writel_dma(i2c->msg_aux_len, i2c, OFFSET_RX_LEN);
> +	}
> +
> +	/* flush before sending start */
> +	mb();
> +	i2c_writel_dma(I2C_DMA_START_EN, i2c, OFFSET_EN);
> +	i2c_writew(I2C_TRANSAC_START, i2c, OFFSET_START);
> +
> +	tmo =3D wait_event_timeout(i2c->wait, i2c->trans_stop, tmo);
If the request completes just when wait_event_timeout returned 0 you
shouldn't throw it away.

> +	if (tmo =3D=3D 0) {
> +		dev_dbg(i2c->dev, "addr: %x, transfer timeout\n", i2c->addr);
> +		mtk_i2c_init_hw(i2c);
> +		return -ETIMEDOUT;
> +	}
> [...]
> +	if (msgs->addr =3D=3D 0) {
> +		dev_dbg(i2c->dev, " addr is invalid.\n");
Is this a hardware limitation?

I'd remove the leading space in the message. (Applies also to other
places.)

> +		ret =3D -EINVAL;
> +		goto err_exit;
> +	}
> +
> +	if (msgs->buf =3D=3D NULL) {
> +		dev_dbg(i2c->dev, " data buffer is NULL.\n");
> +		ret =3D -EINVAL;
> +		goto err_exit;
> +	}
> +
> +	i2c->addr =3D msgs->addr;
> +	i2c->msg_len =3D msgs->len;
> +	i2c->msg_buf =3D msgs->buf;
> +
> +	if (msgs->flags & I2C_M_RD)
> +		i2c->op =3D I2C_MASTER_RD;
> +	else
> +		i2c->op =3D I2C_MASTER_WR;
> +
> +	/* combined two messages into one transaction */
> +	if (num > 1) {
> +		i2c->msg_aux_len =3D (msgs + 1)->len;
> +		i2c->op =3D I2C_MASTER_WRRD;
> +	}
This means "write then read", right? You should check here that the
first message is really a write and the 2nd a read then.
Can this happen at all with the quirks defined below (.max_num_msgs =3D
1)?

> +	/*
> +	 * always use DMA mode.
Out of interest: Did you benchmark DMA vs manual mode for a typical
(what ever that means) scenario?

> +	 * 1st when write need copy the data of message to dma memory
> +	 * 2nd when read need copy the DMA data to the message buffer.
> +	 */
> +	mtk_i2c_copy_to_dma(i2c, msgs);
> +	i2c->msg_buf =3D (u8 *)i2c->dma_buf.paddr;
> +	ret =3D mtk_i2c_do_transfer(i2c);
> +	if (ret < 0)
> +		goto err_exit;
> +
> +	if (i2c->op =3D=3D I2C_MASTER_WRRD)
> +		mtk_i2c_copy_from_dma(i2c, msgs + 1);
> +	else
> +		mtk_i2c_copy_from_dma(i2c, msgs);
> +
> +	/* the return value is number of executed messages */
> +	ret =3D num;
> +
> +err_exit:
> +	mtk_i2c_clock_disable(i2c);
> +	return ret;
> +}
> +
> +static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
> +{
> +	struct mtk_i2c *i2c =3D dev_id;
> +
> +	/* Clear interrupt mask */
> +	i2c_writew(~(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP),
> +		i2c, OFFSET_INTR_MASK);
What is the effect of this. Does it disable further irqs?

> +	i2c->irq_stat =3D i2c_readw(i2c, OFFSET_INTR_STAT);
Maybe you need locking here to modify your driver data in the irq?

> +	i2c_writew(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP,
> +		i2c, OFFSET_INTR_STAT);
This is the ack? Then this is racy; I guess you want

	i2c_writew(i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR ...),
		   i2c, OFFSET_INTR_STAT);

then.

> +	i2c->trans_stop =3D true;
> +	wake_up(&i2c->wait);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static u32 mtk_i2c_functionality(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SMBUS_EMUL;
Does your hardware handle 10bit addresses that nice that there is
nothing visible in the driver apart from this functionality
announcement?

> +}
> +
> +static const struct i2c_algorithm mtk_i2c_algorithm =3D {
> +	.master_xfer =3D mtk_i2c_transfer,
> +	.functionality =3D mtk_i2c_functionality,
> +};
> +
> +static inline u32 mtk_get_device_prop(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +
> +	match =3D of_match_node(mtk_i2c_of_match, pdev->dev.of_node);
> +	return (u32)match->data;
> +}
> +
> +static int mtk_i2c_parse_dt(struct device_node *np, struct mtk_i2c *=
i2c,
> +	unsigned int *clk_src_div)
> +{
> +	i2c->speed_hz =3D I2C_DEFAUT_SPEED;
> +	of_property_read_u32(np, "clock-frequency", &i2c->speed_hz);
> +	of_property_read_u32(np, "clock-div", clk_src_div);
You should check the return value of of_property_read_u32.

> [...]
> +	ret =3D devm_request_irq(&pdev->dev, i2c->irqnr, mtk_i2c_irq,
> +		IRQF_TRIGGER_NONE, I2C_DRV_NAME, i2c);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Request I2C IRQ %d fail\n", i2c->irqnr);
> +		return ret;
> +	}
I think the devm_request_irq should go near the end of probing.
Otherwise the irq might fire before the used resources are ready.

> +
> +	i2c->adap.dev.of_node =3D pdev->dev.of_node;
> +	i2c->dev =3D &i2c->adap.dev;
> +	i2c->adap.dev.parent =3D &pdev->dev;
> +	i2c->adap.owner =3D THIS_MODULE;
> +	i2c->adap.algo =3D &mtk_i2c_algorithm;
> +	i2c->adap.quirks =3D &mt6577_i2c_quirks;
> +	i2c->adap.algo_data =3D NULL;
No need to initialize this to NULL as the struct was allocated using
kzalloc.

> +	i2c->adap.timeout =3D 2 * HZ;
> +	i2c->adap.retries =3D 1;
> +
> +	i2c->clk_main =3D devm_clk_get(&pdev->dev, "main");
> +	if (IS_ERR(i2c->clk_main)) {
> +		dev_err(&pdev->dev, "cannot get main clock\n");
> +		return PTR_ERR(i2c->clk_main);
> +	}
> +
> +	i2c->clk_dma =3D devm_clk_get(&pdev->dev, "dma");
> +	if (IS_ERR(i2c->clk_dma)) {
> +		dev_err(&pdev->dev, "cannot get dma clock\n");
> +		return PTR_ERR(i2c->clk_dma);
> +	}
> +
> +	if (i2c->have_pmic) {
> +		i2c->clk_pmic =3D devm_clk_get(&pdev->dev, "pmic");
> +		if (IS_ERR(i2c->clk_pmic)) {
> +			dev_err(&pdev->dev, "cannot get pmic clock\n");
> +			return PTR_ERR(i2c->clk_pmic);
> +		}
> +		clk_src_in_hz =3D clk_get_rate(i2c->clk_pmic) / clk_src_div;
> +	} else {
> +		clk_src_in_hz =3D clk_get_rate(i2c->clk_main) / clk_src_div;
> +	}
This can be simplified, i.e. the common line can go after the if block
and then the else branch can be dropped.

> +	dev_dbg(&pdev->dev, "clock source %p,clock src frequency %d\n",
> +		i2c->clk_main, clk_src_in_hz);
> +	strlcpy(i2c->adap.name, I2C_DRV_NAME, sizeof(i2c->adap.name));
> +	init_waitqueue_head(&i2c->wait);
> +
> +	ret =3D i2c_set_speed(i2c, clk_src_in_hz);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to set the speed.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D mtk_i2c_clock_enable(i2c);
> +	if (ret) {
> +		dev_err(&pdev->dev, "clock enable failed!\n");
> +		return ret;
> +	}
> +	mtk_i2c_init_hw(i2c);
> +	mtk_i2c_clock_disable(i2c);
> +
> +	i2c->dma_buf.vaddr =3D dma_alloc_coherent(&pdev->dev,
> +		PAGE_SIZE, &i2c->dma_buf.paddr, GFP_KERNEL);
> +	if (i2c->dma_buf.vaddr =3D=3D NULL) {
> +		dev_err(&pdev->dev, "dma_alloc_coherent fail\n");
> +		return -ENOMEM;
> +	}
> +
> +	i2c_set_adapdata(&i2c->adap, i2c);
> +	ret =3D i2c_add_adapter(&i2c->adap);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to add i2c bus to i2c core\n");
> +		free_i2c_dma_bufs(i2c);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, i2c);
> +
> +	return 0;
> +}
> +
> +static int mtk_i2c_remove(struct platform_device *pdev)
> +{
> +	struct mtk_i2c *i2c =3D platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(&i2c->adap);
> +	free_i2c_dma_bufs(i2c);
> +	platform_set_drvdata(pdev, NULL);
> +
Here you need to make sure that no irq is running when i2c_del_adapter
is called.

> +	return 0;
> +}
> +
> +static struct platform_driver mtk_i2c_driver =3D {
> +	.probe =3D mtk_i2c_probe,
> +	.remove =3D mtk_i2c_remove,
> +	.driver =3D {
> +		.name =3D I2C_DRV_NAME,
> +		.owner =3D THIS_MODULE,
You don't need to set .owner any more. That's included in
module_platform_driver since some time.

> +		.of_match_table =3D of_match_ptr(mtk_i2c_of_match),
> +	},
> +};
> +
> +module_platform_driver(mtk_i2c_driver);
> +
> +MODULE_LICENSE("GPL");
MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("MediaTek I2C Bus Driver");
> +MODULE_AUTHOR("Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
