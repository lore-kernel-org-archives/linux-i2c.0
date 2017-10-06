From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/4] i2c: Add Qualcomm Camera Control Interface driver
Date: Thu, 5 Oct 2017 22:20:40 -0700
Message-ID: <20171006052040.GB1575@tuxbook>
References: <1506953613-23875-1-git-send-email-todor.tomov@linaro.org>
 <1506953613-23875-3-git-send-email-todor.tomov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:48786 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbdJFFUp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 6 Oct 2017 01:20:45 -0400
Received: by mail-pg0-f44.google.com with SMTP id v78so7624883pgb.5
        for <linux-i2c@vger.kernel.org>; Thu, 05 Oct 2017 22:20:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1506953613-23875-3-git-send-email-todor.tomov@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Todor Tomov <todor.tomov@linaro.org>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon 02 Oct 07:13 PDT 2017, Todor Tomov wrote:
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
[..]
> +#define NUM_MASTERS 1

So you will only register one of the masters?

[..]
> +enum cci_i2c_queue_t {
> +	QUEUE_0,
> +	QUEUE_1

Could these be called QUEUE_READ and QUEUE_WRITE instead?

> +};
> +
> +enum cci_i2c_master_t {
> +	MASTER_0,
> +	MASTER_1

Just use 0 and 1 when denoting the two masters.

> +};
> +
> +struct resources {

This struct name is not awesome, name it something like cci_res instead.

> +	char *clock[CCI_RES_MAX];
> +	u32 clock_rate[CCI_RES_MAX];
> +	char *reg[CCI_RES_MAX];
> +	char *interrupt[CCI_RES_MAX];
> +};
[..]
> +
> +struct cci_master {
> +	u32 status;

You use this to pass 0 or negative errno between functions, so make it
int.

> +	u8 complete_pending;

bool

> +	struct completion irq_complete;
> +};
> +
> +struct cci {
> +	struct device *dev;
> +	struct i2c_adapter adap;
> +	void __iomem *base;
> +	u32 irq;

"irq" is generally supposed to be a "int".

> +	char irq_name[30];
> +	struct cci_clock *clock;

If you set the rate of your clocks initially you can replace this array
with clk_bulk_data and use the clk_bulk_prepare_enable() and
clk_bulk_disable_unprepare().

> +	int nclocks;
> +	u8 mode;
> +	u16 queue_size[NUM_QUEUES];
> +	struct cci_master master[NUM_MASTERS];
> +};
> +
> +static const struct resources res_v1_0_8 = {
> +	.clock = { "camss_top_ahb",
> +		   "cci_ahb",
> +		   "camss_ahb",
> +		   "cci" },

The code consuming this will read until NULL, so please add terminator.
It happens to work as the first clock_rate is 0 in both cases.

> +	.clock_rate = { 0,
> +			80000000,
> +			0,
> +			19200000 },
> +	.reg = { "cci" },
> +	.interrupt = { "cci" }

No need to specify reg and interrupt here until they actually need to be
configured; just put the strings in the code.

> +};
> +
[..]
> +
> +/*
> + * cci_enable_clocks - Enable multiple clocks

Correct kerneldoc would be:

/**
 * cci_enable_clocks() - Enable multiple clocks

> + * @nclocks: Number of clocks in clock array
> + * @clock: Clock array
> + * @dev: Device
> + *
> + * Return 0 on success or a negative error code otherwise
> + */
> +int cci_enable_clocks(int nclocks, struct cci_clock *clock, struct device *dev)

Overall this is clk_bulk_prepare_enable(), please use that.

[..]
> +/*
> + * cci_disable_clocks - Disable multiple clocks
> + * @nclocks: Number of clocks in clock array
> + * @clock: Clock array
> + */
> +void cci_disable_clocks(int nclocks, struct cci_clock *clock)

Overall this is clk_bulk_disable_unprepare(), so please use that.

> +{
> +	int i;
> +
> +	for (i = nclocks - 1; i >= 0; i--)
> +		clk_disable_unprepare(clock[i].clk);
> +}
> +
[..]
> +
> +static int cci_init(struct cci *cci, const struct hw_params *hw)
> +{
> +	u32 val = CCI_IRQ_MASK_0_I2C_M0_RD_DONE |
> +			CCI_IRQ_MASK_0_I2C_M0_Q0_REPORT |
> +			CCI_IRQ_MASK_0_I2C_M0_Q1_REPORT |
> +			CCI_IRQ_MASK_0_I2C_M1_RD_DONE |
> +			CCI_IRQ_MASK_0_I2C_M1_Q0_REPORT |
> +			CCI_IRQ_MASK_0_I2C_M1_Q1_REPORT |
> +			CCI_IRQ_MASK_0_RST_DONE_ACK |
> +			CCI_IRQ_MASK_0_I2C_M0_Q0Q1_HALT_ACK |
> +			CCI_IRQ_MASK_0_I2C_M1_Q0Q1_HALT_ACK |
> +			CCI_IRQ_MASK_0_I2C_M0_ERROR |
> +			CCI_IRQ_MASK_0_I2C_M1_ERROR;
> +	int i;
> +
> +	writel(val, cci->base + CCI_IRQ_MASK_0);
> +
> +	for (i = 0; i < NUM_MASTERS; i++) {
> +		val = hw->thigh << 16 | hw->tlow;
> +		writel(val, cci->base + CCI_I2C_Mm_SCL_CTL(i));
> +
> +		val = hw->tsu_sto << 16 | hw->tsu_sta;
> +		writel(val, cci->base + CCI_I2C_Mm_SDA_CTL_0(i));
> +
> +		val = hw->thd_dat << 16 | hw->thd_sta;
> +		writel(val, cci->base + CCI_I2C_Mm_SDA_CTL_1(i));
> +
> +		val = hw->tbuf;
> +		writel(val, cci->base + CCI_I2C_Mm_SDA_CTL_2(i));
> +
> +		val = hw->scl_stretch_en << 8 | hw->trdhld << 4 | hw->tsp;
> +		writel(val, cci->base + CCI_I2C_Mm_MISC_CTL(i));
> +
> +		cci->master[i].status = 0;

I don't think you need to initialize status here, it's always written
before read in the rest of the driver.

> +	}
> +
> +	return 0;
> +}
> +
> +static int cci_run_queue(struct cci *cci, u8 master, u8 queue)
> +{
> +	unsigned long time;
> +	u32 val;
> +	int ret;
> +
> +	val = readl(cci->base + CCI_I2C_Mm_Qn_CUR_WORD_CNT(master, queue));
> +	writel(val, cci->base + CCI_I2C_Mm_Qn_EXEC_WORD_CNT(master, queue));
> +
> +	val = 1 << ((master * 2) + queue);

BIT(master * 2 + queue)

> +	writel(val, cci->base + CCI_QUEUE_START);
> +
> +	time = wait_for_completion_timeout(&cci->master[master].irq_complete,
> +					   CCI_TIMEOUT_MS);
> +	if (!time) {
> +		dev_err(cci->dev, "master %d queue %d timeout\n",
> +			master, queue);
> +		return -ETIMEDOUT;
> +	}
> +
> +	ret = cci->master[master].status;
> +	if (ret < 0)
> +		dev_err(cci->dev, "master %d queue %d error %d\n",
> +			master, queue, ret);
> +
> +	return ret;
> +}
> +
> +static int cci_validate_queue(struct cci *cci, u32 len, u8 master, u8 queue)
> +{
> +	int ret = 0;
> +	u32 val;
> +
> +	val = readl(cci->base + CCI_I2C_Mm_Qn_CUR_WORD_CNT(master, queue));
> +
> +	if (val + len + 1 > cci->queue_size[queue]) {

	if (val + len >= cci->queue_size[queue])


Or even better, flip this around and do:

	if (val + len < cci->queue_size[queue])
		return 0;

	val = ..
	writel()

	return cci_run_queue();


That said, this function is always called with len ==
cci->queue_size[queue]. So this will always "run the queue" unless val
== 0. So you can simplify this function slightly by dropping the "len".

> +		val = CCI_I2C_REPORT | (1 << 8);
> +		writel(val, cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, queue));
> +
> +		ret = cci_run_queue(cci, master, queue);
> +	}
> +
> +	return ret;
> +}
> +
> +static int cci_i2c_read(struct cci *cci, u16 addr, u8 *buf, u16 len)
> +{
> +	u8 master = MASTER_0;
> +	u8 queue = QUEUE_1;
> +	u32 val;
> +	u32 words_read, words_exp;
> +	int i, index, first;
> +	int ret;
> +
> +	if (len > cci->adap.quirks->max_read_len)
> +		return -EOPNOTSUPP;
> +

The core already checks each entry against the max length quirks.

But are these actually the max amount of data you can read in one
operation? Generally one has to drain the fifo but the actual transfers
can be larger...

[..]
> +}
> +
> +static int cci_i2c_write(struct cci *cci, u16 addr, u8 *buf, u16 len)
> +{
> +	u8 master = MASTER_0;
> +	u8 queue = QUEUE_0;
> +	u8 load[12] = { 0 };
> +	u8 i, j;

Use int for counters.

> +	u32 val;
> +	int ret;
> +
> +	if (len > cci->adap.quirks->max_write_len)
> +		return -EOPNOTSUPP;
> +

This is taken care of by the core.

[..]
> +}
> +
> +static int cci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> +{
> +	struct cci *cci = i2c_get_adapdata(adap);
> +	int i;
> +	int ret = 0;
> +
> +	if (!num)
> +		return -EOPNOTSUPP;

I don't think you need to handle this case explicitly.

> +
> +	for (i = 0; i < num; i++) {
> +		if (msgs[i].flags & I2C_M_RD)
> +			ret = cci_i2c_read(cci, msgs[i].addr, msgs[i].buf,
> +					   msgs[i].len);
> +		else
> +			ret = cci_i2c_write(cci, msgs[i].addr, msgs[i].buf,
> +					    msgs[i].len);
> +
> +		if (ret < 0) {
> +			dev_err(cci->dev, "cci i2c xfer error %d", ret);
> +			break;
> +		}
> +	}
> +
> +	return ret;

This should return num on success.

[..]
> +static int cci_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
[..]
> +	cci = devm_kzalloc(&pdev->dev, sizeof(*cci), GFP_KERNEL);

Use dev instead &pdev->dev here, of just use pdev->dev throughout the
function.

[..]
> +	cci->mode = I2C_MODE_STANDARD;

cci->mode is a local variable, please don't put it in the struct.

> +	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency", &val);
> +	if (!ret) {
> +		if (val == 400000)
> +			cci->mode = I2C_MODE_FAST;
> +		else if (val == 1000000)
> +			cci->mode = I2C_MODE_FAST_PLUS;
> +	}
> +
> +	/* Memory */
> +
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[0]);

You only have a single reg, so please just use

r = platform_get_resource(pdev, IORESOURCE_MEM, 0);


> +	cci->base = devm_ioremap_resource(dev, r);
> +	if (IS_ERR(cci->base)) {
> +		dev_err(dev, "could not map memory\n");
> +		return PTR_ERR(cci->base);
> +	}
> +
> +	/* Interrupt */
> +
> +	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
> +					 res->interrupt[0]);
> +	if (!r) {
> +		dev_err(dev, "missing IRQ\n");
> +		return -EINVAL;
> +	}
> +
> +	cci->irq = r->start;

Please replace this with:

cci->irq = platform_get_irq(pdev, 0);

> +	snprintf(cci->irq_name, sizeof(cci->irq_name), "%s", dev_name(dev));

And just hard code this in the function call.

> +	ret = devm_request_irq(dev, cci->irq, cci_isr,
> +			       IRQF_TRIGGER_RISING, cci->irq_name, cci);
> +	if (ret < 0) {
> +		dev_err(dev, "request_irq failed, ret: %d\n", ret);
> +		return ret;
> +	}
> +
> +	disable_irq(cci->irq);

The time between devm_request_irq() and disable_irq() is still long
enough for cci_isr() to be called, before irq_complete is initialized.

Don't request irqs until you're ready to receive the interrupts.

> +
> +	/* Clocks */
> +
> +	cci->nclocks = 0;
> +	while (res->clock[cci->nclocks])
> +		cci->nclocks++;
> +
> +	cci->clock = devm_kzalloc(dev, cci->nclocks *
> +				  sizeof(*cci->clock), GFP_KERNEL);

This can max be CCI_RES_MAX (i.e. 6) so just make the array fixed size
and skip the kzalloc().

> +	if (!cci->clock)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < cci->nclocks; i++) {
> +		struct cci_clock *clock = &cci->clock[i];
> +
> +		clock->clk = devm_clk_get(dev, res->clock[i]);
> +		if (IS_ERR(clock->clk))
> +			return PTR_ERR(clock->clk);
> +
> +		clock->name = res->clock[i];
> +		clock->freq = res->clock_rate[i];
> +	}
> +
> +	ret = cci_enable_clocks(cci->nclocks, cci->clock, dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = readl_relaxed(cci->base + CCI_HW_VERSION);
> +	dev_info(dev, "%s: CCI HW version = 0x%08x", __func__, val);

Please don't "spam" the kernel log by default, if this is useful make it
dev_dbg() and people can easily enable the print.

> +
> +	init_completion(&cci->master[0].irq_complete);
> +	init_completion(&cci->master[1].irq_complete);
> +
> +	enable_irq(cci->irq);
> +
> +	ret = cci_reset(cci);
> +	if (ret < 0)

Clocks needs to be disabled if this fails.

> +		return ret;
> +
> +	ret = cci_init(cci, &hw[cci->mode]);
> +	if (ret < 0)

Dito

> +		return ret;
> +
> +	ret = i2c_add_adapter(&cci->adap);

Dito

> +
> +	return ret;
> +}
[..]
> +MODULE_ALIAS("platform:i2c-qcom-cci");

You don't need to specify this alias.

Regards,
Bjorn
