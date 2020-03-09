From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v5 1/3] i2c: Add Qualcomm CCI I2C driver
Date: Mon, 9 Mar 2020 12:23:16 -0700
Message-ID: <20200309192316.GD1098305@builder>
References: <1583770998-25449-1-git-send-email-loic.poulain@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1583770998-25449-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Loic Poulain <loic.poulain@linaro.org>
Cc: wsa@the-dreams.de, vkoul@kernel.org, robert.foss@linaro.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
List-Id: linux-i2c@vger.kernel.org

On Mon 09 Mar 09:23 PDT 2020, Loic Poulain wrote:
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
[..]
> +static int cci_probe(struct platform_device *pdev)
> +{
[..]
> +	for_each_available_child_of_node(dev->of_node, child) {
> +		u32 idx;
> +
> +		ret = of_property_read_u32(child, "reg", &idx);
> +		if (ret) {
> +			dev_err(dev, "%pOF invalid 'reg' property", child);
> +			continue;
> +		}
> +
> +		if (idx >= cci->data->num_masters) {
> +			dev_err(dev, "%pOF invalid 'reg' value: %u (max is %u)",
> +				child, idx, cci->data->num_masters - 1);
> +			continue;
> +		}
> +
> +		cci->master[idx].adap.quirks = &cci->data->quirks;
> +		cci->master[idx].adap.algo = &cci_algo;
> +		cci->master[idx].adap.dev.parent = dev;
> +		cci->master[idx].adap.dev.of_node = child;
> +		cci->master[idx].master = idx;
> +		cci->master[idx].cci = cci;
> +
> +		i2c_set_adapdata(&cci->master[idx].adap, &cci->master[idx]);
> +		snprintf(cci->master[idx].adap.name,
> +			 sizeof(cci->master[idx].adap.name),
> +			 "Qualcomm Camera Control Interface: %d", idx);
> +
> +		cci->master[idx].mode = I2C_MODE_STANDARD;
> +		ret = of_property_read_u32(child, "clock-frequency", &val);
> +		if (!ret) {
> +			if (val == 400000)
> +				cci->master[idx].mode = I2C_MODE_FAST;
> +			else if (val == 1000000)
> +				cci->master[idx].mode = I2C_MODE_FAST_PLUS;
> +		}
> +
> +		init_completion(&cci->master[idx].irq_complete);
> +	}

Nice, this looks good now.

[..]
> +	ret = cci_enable_clocks(cci);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Interrupt */
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "missing IRQ: %d\n", ret);

goto disable_clocks;

> +		return ret;
> +	}
> +	cci->irq = ret;
> +
> +	ret = devm_request_irq(dev, cci->irq, cci_isr, 0, dev_name(dev), cci);
> +	if (ret < 0) {
> +		dev_err(dev, "request_irq failed, ret: %d\n", ret);

goto disable_clocks;

> +		return ret;
> +	}
> +
> +	val = readl(cci->base + CCI_HW_VERSION);
> +	dev_dbg(dev, "CCI HW version = 0x%08x", val);
> +
> +	ret = cci_reset(cci);
> +	if (ret < 0)
> +		goto error;
> +
> +	ret = cci_init(cci);
> +	if (ret < 0)
> +		goto error;
> +
> +	for (i = 0; i < cci->data->num_masters; i++) {
> +		if (!cci->master[i].cci)
> +			continue;
> +
> +		ret = i2c_add_adapter(&cci->master[i].adap);
> +		if (ret < 0)
> +			goto error_i2c;
> +	}
> +
> +	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +
> +error_i2c:
> +	for (; i >= 0; i--) {
> +		if (cci->master[i].cci)
> +			i2c_del_adapter(&cci->master[i].adap);
> +	}
> +error:
> +	disable_irq(cci->irq);

disable_clocks:

> +	cci_disable_clocks(cci);
> +
> +	return ret;
> +}

With that

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
