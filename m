Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D943CE6F;
	Wed, 26 Aug 2026 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752633; cv=none; b=vDknwred2wdlfAgUW8o2i4BHCcdANL5G4+YrpZ3y+fowReh7jYbH5AnntMY4V2Ha0wKE0Y8M8oQZK5eku56ovM6caMbded88vH9B+j7JoiaEdERhTsx0UkTxmXnIHQ9rhvwLvvhUZl//t9dEb12WrU9xp6og9fTybc7RZ1E2wNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752633; c=relaxed/simple;
	bh=NcRPV43rVKX/2XfHEHMdDAXWGtg+e5JV86w+pOf6Kf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLHTGxJHzgDCcSHkxRwoq0YK1Pjz1hio8mrnv+CwYJifkyuk+qJIT/OzqWiIRtbNBuEJSPemHbZNCIxdNWqF9WSo1+50dKn15MSDZQ6s+G5RIBQbZ97Mz9+op1C2jXYOcmsk4qj2Pq+0lJTFb39JL+yrLXY73EmLXEwhnnTz1/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQZYM1s9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQZYM1s9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195591F00A3A;
	Wed, 26 Aug 2026 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787752631;
	bh=Ng6UyxcJG17QHhsyPARDfyJal85V14/IeVc1pjyLAZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fQZYM1s9E4o7LMUGYuCBa0bLUCOAx+T5jP1cW776JNFJ7AvOmWPO/tHPrCCYqqYwG
	 aozam6RXj2zmMKYpi8FLXOcIAg2YMWekRGVNuEBYdMCmvf995jrxdTZaGEvIN6XEaU
	 dFkpXczvXpDsmrYQWSznX+i8iNYEQL2T8wU8gnQ3spoZYhRvH3uvzUehIeo3T6xMFi
	 VtGx1Rdgk/MNGP7Ssr+HYgTNvQQh00Fr2K/Myy5NDRD9ugaFvg+GQyG0MsoNwsbgVG
	 2o4VbyM8IUNRXGQs4J+dUa9V5SW+bcZ7KP2SCYQmSWQd69MfaC035yaH9mv8Uz5rtM
	 KNV1kloDK7Oew==
Date: Wed, 26 Aug 2026 15:57:07 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] i2c: qcom-target: Add driver for Qualcomm I2C
 target controller
Message-ID: <ao7vB8cDufnJZKAI@zenone.zhora.eu>
References: <20260813-i2c-qcom-slave-v3-0-1d3742e2ad47@oss.qualcomm.com>
 <20260813-i2c-qcom-slave-v3-2-1d3742e2ad47@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813-i2c-qcom-slave-v3-2-1d3742e2ad47@oss.qualcomm.com>

Hi Viken,

just a quick look here.

...

> +static void qcom_i2c_target_hw_reset(struct qcom_i2c_target *target)
> +{
> +	/* Clear error bits before SW_RESET; the reset may not be instantaneous */
> +	writel(BIT(ERR_CONDITION) | BIT(CLOCK_LOW_TIMEOUT),
> +	       target->base + I2C_S_IRQ_CLR);
> +	writel(SW_RESET, target->base + I2C_S_SW_RESET_REG);
> +	/*
> +	 * I2C_S_SW_RESET_REG is write-only so completion cannot be polled.
> +	 * Use a conservative delay to allow the reset to finish before
> +	 * reconfiguring the controller.
> +	 */
> +	usleep_range(10, 20);

This is also called in atomic context from the irq handler.
Please avoid using usleep_range(), perhaps you can put this in a
thread.

> +	qcom_i2c_target_hw_init(target);
> +	writel(target->slave->addr, target->base + I2C_S_DEVICE_ADDR);
> +	writel(I2C_S_CORE_EN, target->base + I2C_S_CONFIG);
> +}
> +
> +static irqreturn_t qcom_i2c_target_handle_error(struct qcom_i2c_target *target,
> +						u32 irq_stat)
> +{
> +	u8 val = 0;
> +
> +	if (irq_stat & BIT(ERR_CONDITION))
> +		dev_err(target->dev, "Error condition: unexpected Start/Stop bits\n");
> +	else
> +		dev_err(target->dev, "Clock low timeout\n");
> +	qcom_i2c_target_dump_regs(target);
> +	qcom_i2c_target_hw_reset(target);
> +	i2c_slave_event(target->slave, I2C_SLAVE_STOP, &val);
> +	target->status = 0;
> +	return IRQ_HANDLED;
> +}

...

> +static irqreturn_t qcom_i2c_target_irq(int irq, void *dev)
> +{
> +	struct qcom_i2c_target *target = dev;
> +	u32 irq_stat, rx_bits;
> +
> +	/*
> +	 * Dispatch priority (highest first):
> +	 *   ERR_CONDITION / CLOCK_LOW_TIMEOUT  — hardware error, triggers SW reset
> +	 *   STOP_DETECTED                      — end of transaction, clears all state
> +	 *   RESTART_DETECTED                   — repeated start, resets state before
> +	 *                                        any data phase in the same snapshot
> +	 *   STRCH_RD                           — read-phase data supply
> +	 *   RX_FIFO_FULL / RX_DATA_AVAIL /
> +	 *   STRCH_WR                           — write-phase Rx, coalesced into one drain
> +	 */
> +	irq_stat = readl_relaxed(target->base + I2C_S_IRQ_STATUS);
> +	if (!irq_stat)
> +		return IRQ_NONE;
> +
> +	dev_dbg(target->dev, "IRQ status: 0x%x\n", irq_stat);
> +
> +	/*
> +	 * Load target->slave once. Both reg_slave() and unreg_slave() disable
> +	 * the IRQ before writing the pointer, so it cannot change while this
> +	 * handler runs. Sub-handlers may dereference target->slave directly.
> +	 *
> +	 * The core is enabled only in reg_slave() and disabled in unreg_slave(),
> +	 * so no bus activity is expected here. Clear and discard any stale IRQ.
> +	 */
> +	if (!READ_ONCE(target->slave)) {
> +		writel(irq_stat, target->base + I2C_S_IRQ_CLR);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (irq_stat & (BIT(ERR_CONDITION) | BIT(CLOCK_LOW_TIMEOUT)))
> +		return qcom_i2c_target_handle_error(target, irq_stat);
> +
> +	if (irq_stat & BIT(STOP_DETECTED))
> +		return qcom_i2c_target_handle_stop(target, irq_stat);

...

> +	target->xo_clk = devm_clk_get(dev, "xo");
> +	if (IS_ERR(target->xo_clk))
> +		return dev_err_probe(dev, PTR_ERR(target->xo_clk),
> +				     "failed to get XO clock\n");
> +
> +	target->ahb_clk = devm_clk_get(dev, "ahb");
> +	if (IS_ERR(target->ahb_clk))
> +		return dev_err_probe(dev, PTR_ERR(target->ahb_clk),
> +				     "failed to get AHB clock\n");
> +
> +	ret = clk_prepare_enable(target->xo_clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable XO clock\n");
> +
> +	ret = clk_prepare_enable(target->ahb_clk);
> +	if (ret) {
> +		clk_disable_unprepare(target->xo_clk);
> +		return dev_err_probe(dev, ret, "failed to enable AHB clock\n");
> +	}

The problem is that these clocks are not disabled in the returns
below.

Thanks,
Andi

> +
> +	target->irq = platform_get_irq(pdev, 0);
> +	if (target->irq < 0)
> +		return target->irq;
> +
> +	ret = qcom_i2c_target_icc_init(target);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_irq(dev, target->irq, qcom_i2c_target_irq, 0,
> +			       dev_name(dev), target);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "request_irq failed for IRQ %d\n",
> +				     target->irq);
> +
> +	qcom_i2c_target_hw_init(target);
> +
> +	platform_set_drvdata(pdev, target);
> +
> +	ret = qcom_i2c_target_adap_init(target);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "i2c_add_adapter failed\n");
> +
> +	return 0;
> +}
