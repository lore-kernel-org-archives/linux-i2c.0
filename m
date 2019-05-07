From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] i2c: bcm2835: Model Divider in CCF
Date: Tue, 7 May 2019 08:11:15 +0200
Message-ID: <f4765697-9ce7-8b40-707a-23fae3e8580f@i2se.com>
References: <20190505034339.30778-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190505034339.30778-1-nh6z@nh6z.net>
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
To: Annaliese McDermond <nh6z@nh6z.net>, eric@anholt.net, f.fainelli@gmail.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: team@nwdigitalradio.com
List-Id: linux-i2c@vger.kernel.org

Hi,

assuming Wolfram is fine with this approach, my comments below

Am 05.05.19 um 05:43 schrieb Annaliese McDermond:
> ...
>
> Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
> ---
>  drivers/i2c/busses/i2c-bcm2835.c | 143 +++++++++++++++++++++++--------
>  1 file changed, 108 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> index d2fbb4bb4a43..1f9f60b80618 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -4,6 +4,8 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
>  #include <linux/completion.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> @@ -51,9 +53,7 @@
>  struct bcm2835_i2c_dev {
>  	struct device *dev;
>  	void __iomem *regs;
> -	struct clk *clk;
>  	int irq;
> -	u32 bus_clk_rate;
>  	struct i2c_adapter adapter;
>  	struct completion completion;
>  	struct i2c_msg *curr_msg;
> @@ -74,26 +74,28 @@ static inline u32 bcm2835_i2c_readl(struct bcm2835_i2c_dev *i2c_dev, u32 reg)
>  	return readl(i2c_dev->regs + reg);
>  }
>  
> -static int bcm2835_i2c_set_divider(struct bcm2835_i2c_dev *i2c_dev)
> +#define to_clk_bcm2835_i2c(_hw) container_of(_hw, struct clk_bcm2835_i2c, hw)
> +struct clk_bcm2835_i2c {
> +	struct clk_hw hw;
> +	struct bcm2835_i2c_dev *i2c_dev;
> +};
> +
> +static int clk_bcm2835_i2c_set_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long parent_rate)
>  {
> +	struct clk_bcm2835_i2c *div = to_clk_bcm2835_i2c(hw);
> +
please avoid such whitespace changes, i assume checkpatch.pl would
complain about this
>  	u32 divider, redl, fedl;
>  
> -	divider = DIV_ROUND_UP(clk_get_rate(i2c_dev->clk),
> -			       i2c_dev->bus_clk_rate);
> -	/*
> -	 * Per the datasheet, the register is always interpreted as an even
> -	 * number, by rounding down. In other words, the LSB is ignored. So,
> -	 * if the LSB is set, increment the divider to avoid any issue.
> -	 */
please try to keep this comment somewhere
> +	divider = DIV_ROUND_UP(parent_rate, rate);
>  	if (divider & 1)
>  		divider++;
> +
>  	if ((divider < BCM2835_I2C_CDIV_MIN) ||
> -	    (divider > BCM2835_I2C_CDIV_MAX)) {
> -		dev_err_ratelimited(i2c_dev->dev, "Invalid clock-frequency\n");
> +	    (divider > BCM2835_I2C_CDIV_MAX))
>  		return -EINVAL;
> -	}
>  
> -	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
> +	bcm2835_i2c_writel(div->i2c_dev, BCM2835_I2C_DIV, divider);
>  
>  	/*
>  	 * Number of core clocks to wait after falling edge before
> @@ -108,12 +110,72 @@ static int bcm2835_i2c_set_divider(struct bcm2835_i2c_dev *i2c_dev)
>  	 */
>  	redl = max(divider / 4, 1u);
>  
> -	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DEL,
> +	bcm2835_i2c_writel(div->i2c_dev, BCM2835_I2C_DEL,
>  			   (fedl << BCM2835_I2C_FEDL_SHIFT) |
>  			   (redl << BCM2835_I2C_REDL_SHIFT));
> +
this whitespace change is unrelated
>  	return 0;
>  }
>  
> +static long clk_bcm2835_i2c_round_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long *parent_rate)
> +{
> +	u32 divider;
> +
> +	divider = DIV_ROUND_UP(*parent_rate, rate);
this could go into one line
> +	if (divider & 1)
> +		divider++;
> +
> +	if ((divider < BCM2835_I2C_CDIV_MIN) ||
> +	    (divider > BCM2835_I2C_CDIV_MAX))
> +		return -EINVAL;
> +
> +	return DIV_ROUND_UP(*parent_rate, divider);
> +}
> +
> +static unsigned long clk_bcm2835_i2c_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	struct clk_bcm2835_i2c *div = to_clk_bcm2835_i2c(hw);
> +
same here, no empty line between the declarations
> +	u32 divider;
> +
> +	divider = bcm2835_i2c_readl(div->i2c_dev, BCM2835_I2C_DIV);
> +
> +	return DIV_ROUND_UP(parent_rate, divider);
> +}
> +
> +static const struct clk_ops clk_bcm2835_i2c_ops = {
> +	.set_rate = clk_bcm2835_i2c_set_rate,
> +	.round_rate = clk_bcm2835_i2c_round_rate,
> +	.recalc_rate = clk_bcm2835_i2c_recalc_rate,
> +};
> +
> +static struct clk *bcm2835_i2c_register_div(struct device *dev,
> +					const char *mclk_name,
> +					struct bcm2835_i2c_dev *i2c_dev)
> +{
> +	struct clk_init_data init;
> +	struct clk_bcm2835_i2c *priv;
> +	const char *devname = dev_name(dev);
> +
> +	init.ops = &clk_bcm2835_i2c_ops;
> +	init.name = "bcm2835-i2c";
> +	init.parent_names = (const char* []) { mclk_name };
> +	init.num_parents = 1;
> +	init.flags = 0;
> +
> +	priv = devm_kzalloc(dev, sizeof(struct clk_bcm2835_i2c), GFP_KERNEL);
> +	if (priv == NULL)
> +		return (struct clk *) -ENOMEM;
ERR_PTR(-ENOMEM) ?
> +
> +	priv->hw.init = &init;
> +	priv->i2c_dev = i2c_dev;
> +
> +	clk_hw_register_clkdev(&priv->hw, init.name, devname);
> +	return devm_clk_register(dev, &priv->hw);
> +}
> +
>  static void bcm2835_fill_txfifo(struct bcm2835_i2c_dev *i2c_dev)
>  {
>  	u32 val;
> @@ -271,7 +333,7 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
>  {
>  	struct bcm2835_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
>  	unsigned long time_left;
> -	int i, ret;
> +	int i;
>  
>  	for (i = 0; i < (num - 1); i++)
>  		if (msgs[i].flags & I2C_M_RD) {
> @@ -280,10 +342,6 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
>  			return -EOPNOTSUPP;
>  		}
>  
> -	ret = bcm2835_i2c_set_divider(i2c_dev);
> -	if (ret)
> -		return ret;
> -
>  	i2c_dev->curr_msg = msgs;
>  	i2c_dev->num_msgs = num;
>  	reinit_completion(&i2c_dev->completion);
> @@ -338,6 +396,9 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
>  	struct resource *mem, *irq;
>  	int ret;
>  	struct i2c_adapter *adap;
> +	const char *mclk_name;
> +	struct clk *bus_clk;
> +	u32 bus_clk_rate;
>  
>  	i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
>  	if (!i2c_dev)
> @@ -351,21 +412,6 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
>  	if (IS_ERR(i2c_dev->regs))
>  		return PTR_ERR(i2c_dev->regs);
>  
> -	i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(i2c_dev->clk)) {
> -		if (PTR_ERR(i2c_dev->clk) != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Could not get clock\n");
> -		return PTR_ERR(i2c_dev->clk);
> -	}
> -
> -	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> -				   &i2c_dev->bus_clk_rate);
> -	if (ret < 0) {
> -		dev_warn(&pdev->dev,
> -			 "Could not read clock-frequency property\n");
> -		i2c_dev->bus_clk_rate = 100000;
> -	}
> -
>  	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (!irq) {
>  		dev_err(&pdev->dev, "No IRQ resource\n");
> @@ -380,6 +426,30 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	mclk_name = of_clk_get_parent_name(pdev->dev.of_node, 0);
> +
> +	bus_clk = bcm2835_i2c_register_div(&pdev->dev, mclk_name, i2c_dev);

this function could return an error, so we better handle this

Thanks Stefan
