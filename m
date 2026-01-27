Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC232248A0;
	Tue, 27 Jan 2026 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769501915; cv=none; b=gWAcAh1+aghju/Tzgyt1RiYKDz4EOTKdYAOd/2AuU2zN0xUSBk2xE3ep+MwpN7ladgeyTds7bhoN8T1QrqaulviD4UVmPIf0mERt9oUygTAqUN0opeVylHB0FxdWznwszliins9WkNH5XjsKVO3vsmyQYQ/wdTrpYeiN68lKCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769501915; c=relaxed/simple;
	bh=WyCQT6KmszXsxbLp0IXhTLUnPRp8Si0heVbUZjxvQqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/fJXFWGikj2G7dKiLmRf/KaOOQLrjGpvjaVij4Nw4QoeeoJ4fJQYtBI5MZeQJXSk1iLQXVpgSUfm+mUpFgbHT5s755TXEEKw60rvpR5xrhrzQbX9dLjqX4zqc07w7W0bchgNgT8OsfvL1Ay5wg5CKiuLITNyLozYeeVcnVANaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+wDnEKS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+wDnEKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769501913; x=1801037913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WyCQT6KmszXsxbLp0IXhTLUnPRp8Si0heVbUZjxvQqw=;
  b=J+wDnEKShHLsLP/uF/G/GcuENm3xP+M3EQhUGKGhLEQp4dOVNtW7Z7KK
   D6f72o1GyhiMXVnizPdV1SENDUwEEOU2V89QniiT+Z9EaO5V//s8MupmW
   A17qJnsNtgh2cWupQGt3qoZ8io2XyjPo1IyuEPbsvVJttWhwTibiSznjM
   WcLvpH5OHEANhweoy2ndEp7kE8yhQfLbfVT4dZJ8BfjurwxWqafol6s/E
   ZGnMrI06BiLTLFbknE4oh2t4sIZ8K9IXX7s2/MhSKkcIqeI5UoBI/XbPZ
   79ifXOixOZAQpYWZINxjh7Vq499SsP4x/71277kz03B+r0sihZM5mBCpL
   A==;
X-CSE-ConnectionGUID: GX2bXAuSQnCA8IozytgteA==
X-CSE-MsgGUID: le8pPYC/Qxuvd8vLUAOHdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70779102"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70779102"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 00:18:32 -0800
X-CSE-ConnectionGUID: NhDVZgCnSMS+rPCL0SxF+g==
X-CSE-MsgGUID: Uku9b1QhRlSDFZI/hZK0Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="207801382"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 00:18:29 -0800
Date: Tue, 27 Jan 2026 10:18:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C
 controller
Message-ID: <aXh000kBfaqd1G9H@smile.fi.intel.com>
References: <cover.1769476820.git.zhoubinbin@loongson.cn>
 <402121da829497fc97f1461c8aaa3a44252c3f06.1769476820.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402121da829497fc97f1461c8aaa3a44252c3f06.1769476820.git.zhoubinbin@loongson.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 10:47:57AM +0800, Binbin Zhou wrote:
> This I2C module is integrated into the Loongson-2K0300 SoCs.
> 
> It provides multi-master functionality and controls all I2C bus-specific
> timing, protocols, arbitration, and timing. It supports both standard
> and fast modes.

Thanks for the update, but either v1 was not reviewed properly (if reviewed
at all), or this missed comments from there. This driver needs much more work.
Since it misses v6.20 anyway, you have about 2 month to put this into a shape.

...

> +/*
> + * Loongson-2K fast I2C controller driver
> + *
> + * Copyright (C) 2025-2026 Loongson Technology Corporation Limited

> + *

Redundant blank line.

> + */

...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>

> +#include <linux/device.h>

Is this being used?

> +#include <linux/iopoll.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>

> +#include <linux/kernel.h>

No way you should include this one.

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>

Please, follow IWYU principle, exempli gratia here the types.h is missing.

> +#include <linux/units.h>

...

> +#define LOONGSON2_I2C_CR2_IRQ_MASK	(LOONGSON2_I2C_CR2_ITBUFEN | \
> +					 LOONGSON2_I2C_CR2_ITEVTEN | \
> +					 LOONGSON2_I2C_CR2_ITERREN)

Better to indent differently:

#define LOONGSON2_I2C_CR2_IRQ_MASK	\
	(LOONGSON2_I2C_CR2_ITBUFEN | LOONGSON2_I2C_CR2_ITEVTEN | LOONGSON2_I2C_CR2_ITERREN)


...

> +#define LOONGSON2_I2C_SR1_ITEVTEN_MASK	(LOONGSON2_I2C_SR1_BTF | \
> +					 LOONGSON2_I2C_SR1_ADDR | \
> +					 LOONGSON2_I2C_SR1_SB)
> +#define LOONGSON2_I2C_SR1_ITBUFEN_MASK	(LOONGSON2_I2C_SR1_TXE | LOONGSON2_I2C_SR1_RXNE)
> +#define LOONGSON2_I2C_SR1_ITERREN_MASK	(LOONGSON2_I2C_SR1_AF | \
> +					 LOONGSON2_I2C_SR1_ARLO | \
> +					 LOONGSON2_I2C_SR1_BERR)

As per above.

...

> +#define LOONGSON2_I2C_FREE_SLEEP_US	1000
> +#define LOONGSON2_I2C_FREE_TIMEOUT_US	5000

1 * USEC_PER_MSEC
5 * USEC_PER_MSEC

...

> +#define LOONGSON2_I2C_MIN_STD_FREQ	2U
> +#define LOONGSON2_I2C_MIN_FAST_FREQ	6U
> +#define LOONGSON2_I2C_MAX_FREQ		46U

The three are unused, what are they for?


> +#define HZ_TO_MHZ			1000000

Dup. Use units.h.

...

> +enum loongson2_i2c_speed {
> +	LOONGSON2_I2C_SPEED_STANDARD, /* 100 kHz */
> +	LOONGSON2_I2C_SPEED_FAST, /* 400 kHz */
> +	LOONGSON2_I2C_SPEED_FAST_PLUS, /* 1 MHz */

Use existing speed definitions and drop this enum.

> +	LOONGSON2_I2C_SPEED_END,

Besides comma in the terminator, that has not to be there, this is unused.

> +};

...

> +/*

It's not marked as kernel-doc, but looks very much like that. Why?
Same Q for *all* cases like this.

> + * struct loongson2_i2c_msg - client specific data
> + * @addr: 8-bit slave addr, including r/w bit
> + * @count: number of bytes to be transferred
> + * @buf: data buffer
> + * @stop: last I2C msg to be sent, i.e. STOP to be generated
> + * @result: result of the transfer
> + */
> +struct loongson2_i2c_msg {
> +	u8 addr;
> +	u32 count;
> +	u8 *buf;
> +	bool stop;
> +	int result;

Run `pahole` and amend *all* data types accordingly.

> +};

...

> +struct loongson2_i2c_priv {
> +	struct i2c_adapter adapter;

> +	struct device *dev;

Isn't this a dup? Can't it be derived from regmap and/or adapter?

> +	struct clk *clk;
> +	struct completion complete;
> +	struct regmap *regmap;
> +	int speed;
> +	int parent_rate;
> +	struct loongson2_i2c_msg msg;
> +};

...

> +static int loongson2_i2c_wait_free_bus(struct loongson2_i2c_priv *priv)
> +{
> +	u32 status;
> +	int ret;
> +
> +	ret = regmap_read_poll_timeout(priv->regmap, LOONGSON2_I2C_SR2, status,
> +				       !(status & LOONGSON2_I2C_SR2_BUSY),
> +				       LOONGSON2_I2C_FREE_SLEEP_US,
> +				       LOONGSON2_I2C_FREE_TIMEOUT_US);
> +	if (ret) {
> +		dev_dbg(priv->dev, "I2C bus free failed.\n");

> +		ret = -EBUSY;

Why?! What's wrong with the error code returned in ret?

> +	}
> +
> +	return ret;
> +}

...

> +static void loongson2_i2c_handle_read(struct loongson2_i2c_priv *priv, int flag)
> +{
> +	struct loongson2_i2c_msg *msg = &priv->msg;
> +	bool changed;

> +	int i;

Why signed?

> +	switch (msg->count) {
> +	case 1:
> +		/* only transmit 1 bytes condition */
> +		loongson2_i2c_disable_irq(priv);
> +		loongson2_i2c_read_msg(priv);
> +		complete(&priv->complete);
> +		break;
> +	case 2:
> +		if (flag != 1) {
> +			/* ensure only transmit 2 bytes condition */
> +			regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR2,
> +					   LOONGSON2_I2C_CR2_ITBUFEN, 0);
> +			break;
> +		}
> +		regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I2C_CR1_OP_MASK,
> +				   msg->stop ? LOONGSON2_I2C_CR1_STOP : LOONGSON2_I2C_CR1_START);
> +
> +		loongson2_i2c_disable_irq(priv);

> +		for (i = 2; i > 0; i--)
> +			loongson2_i2c_read_msg(priv);

Just unroll the loop and put a comment on top explaining the magic 2. But I
think it's just a msg->count.

> +		regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I2C_CR1_POS, 0);
> +		complete(&priv->complete);
> +		break;
> +	case 3:
> +		regmap_update_bits_check(priv->regmap, LOONGSON2_I2C_CR2, LOONGSON2_I2C_CR2_ITBUFEN,
> +					 0, &changed);
> +		if (changed)
> +			break;
> +		regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I2C_CR1_ACK, 0);
> +		fallthrough;
> +	default:
> +		loongson2_i2c_read_msg(priv);
> +	}
> +}

...

> +static irqreturn_t loongson2_i2c_isr_error(u32 status, void *data)
> +{
> +	struct loongson2_i2c_priv *priv = data;
> +	struct loongson2_i2c_msg *msg = &priv->msg;
> +
> +	/* Arbitration lost */
> +	if (status & LOONGSON2_I2C_SR1_ARLO) {
> +		regmap_update_bits(priv->regmap, LOONGSON2_I2C_SR1, LOONGSON2_I2C_SR1_ARLO, 0);
> +		msg->result = -EAGAIN;
> +	}
> +
> +	/*
> +	 * Acknowledge failure:
> +	 * In master transmitter mode a Stop must be generated by software
> +	 */
> +	if (status & LOONGSON2_I2C_SR1_AF) {
> +		regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I2C_CR1_STOP,
> +				   LOONGSON2_I2C_CR1_STOP);
> +		regmap_update_bits(priv->regmap, LOONGSON2_I2C_SR1, LOONGSON2_I2C_SR1_AF, 0);
> +		msg->result = -EIO;
> +	}
> +
> +	/* Bus error */
> +	if (status & LOONGSON2_I2C_SR1_BERR) {
> +		regmap_update_bits(priv->regmap, LOONGSON2_I2C_SR1, LOONGSON2_I2C_SR1_BERR, 0);
> +		msg->result = -EIO;
> +	}

Even if the interrupt is spurious you still Ack it, why?

Ah, it seems it's a helper. Please, return the error code from it as int and
not irqreturn_t, this will make things clearer.

> +	loongson2_i2c_disable_irq(priv);
> +	complete(&priv->complete);
> +
> +	return IRQ_HANDLED;
> +}

...

> +static irqreturn_t loongson2_i2c_isr_event(int irq, void *data)
> +{
> +	u32 possible_status = LOONGSON2_I2C_SR1_ITEVTEN_MASK;

Split assignment...

> +	struct loongson2_i2c_priv *priv = data;
> +	struct loongson2_i2c_msg *msg = &priv->msg;
> +	u32 status, ien, event, cr2;
> +
> +	regmap_read(priv->regmap, LOONGSON2_I2C_SR1, &status);
> +	if (status & LOONGSON2_I2C_SR1_ITERREN_MASK)
> +		return loongson2_i2c_isr_error(status, data);
> +
> +	regmap_read(priv->regmap, LOONGSON2_I2C_CR2, &cr2);
> +	ien = cr2 & LOONGSON2_I2C_CR2_IRQ_MASK;

...to be here, which improves readability (no need to go somewhere up in
the code to see what this is about.

> +	/* Update possible_status if buffer interrupt is enabled */
> +	if (ien & LOONGSON2_I2C_CR2_ITBUFEN)
> +		possible_status |= LOONGSON2_I2C_SR1_ITBUFEN_MASK;
> +
> +	event = status & possible_status;
> +	if (!event) {
> +		dev_dbg(priv->dev, "spurious evt irq (status=0x%08x, ien=0x%08x)\n", status, ien);
> +		return IRQ_NONE;
> +	}
> +
> +	/* Start condition generated */
> +	if (event & LOONGSON2_I2C_SR1_SB)
> +		loongson2_i2c_write_msg(priv, msg->addr);
> +
> +	/* I2C Address sent */
> +	if (event & LOONGSON2_I2C_SR1_ADDR) {
> +		if (msg->addr & I2C_M_RD)
> +			loongson2_i2c_handle_rx_addr(priv);
> +		/* Clear ADDR flag */
> +		regmap_read(priv->regmap, LOONGSON2_I2C_SR2, &status);
> +		/* Enable buffer interrupts for RX/TX not empty events */
> +		regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR2, LOONGSON2_I2C_CR2_ITBUFEN,
> +				   LOONGSON2_I2C_CR2_ITBUFEN);
> +	}
> +
> +	if (msg->addr & I2C_M_RD) {
> +		/* RX not empty */
> +		if (event & LOONGSON2_I2C_SR1_RXNE)
> +			loongson2_i2c_handle_read(priv, 0);
> +
> +		if (event & LOONGSON2_I2C_SR1_BTF)
> +			loongson2_i2c_handle_read(priv, 1);
> +	} else {
> +		/* TX empty */
> +		if (event & LOONGSON2_I2C_SR1_TXE)
> +			loongson2_i2c_handle_write(priv);
> +
> +		if (event & LOONGSON2_I2C_SR1_BTF)
> +			loongson2_i2c_handle_write(priv);
> +	}
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int loongson2_i2c_xfer_msg(struct loongson2_i2c_priv *priv, struct i2c_msg *msg,
> +				  bool is_stop)
> +{
> +	struct loongson2_i2c_msg *l_msg = &priv->msg;
> +	unsigned long timeout;

> +	int ret;

Seems unneeded.

> +
> +	l_msg->addr   = i2c_8bit_addr_from_msg(msg);
> +	l_msg->buf    = msg->buf;
> +	l_msg->count  = msg->len;
> +	l_msg->stop   = is_stop;
> +	l_msg->result = 0;
> +
> +	reinit_completion(&priv->complete);
> +
> +	/* Enable events and errors interrupts */
> +	regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR2,
> +			   LOONGSON2_I2C_CR2_ITEVTEN | LOONGSON2_I2C_CR2_ITERREN,
> +			   LOONGSON2_I2C_CR2_ITEVTEN | LOONGSON2_I2C_CR2_ITERREN);

> +	timeout = wait_for_completion_timeout(&priv->complete, priv->adapter.timeout);
> +	ret = l_msg->result;
> +
> +	if (!timeout)
> +		ret = -ETIMEDOUT;
> +
> +	return ret;

	timeout = wait_for_completion_timeout(&priv->complete, priv->adapter.timeout);
	if (!timeout)
		return -ETIMEDOUT;

	return l_msg->result;

> +}

> +static int loongson2_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
> +{
> +	struct loongson2_i2c_priv *priv = i2c_get_adapdata(i2c_adap);
> +	int ret = 0, i;

Why is 'i' signed?
And redundant assignment for 'ret'.

> +	ret = loongson2_i2c_wait_free_bus(priv);
> +	if (ret)
> +		return ret;
> +
> +	/* START generation */
> +	regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I2C_CR1_START,
> +			   LOONGSON2_I2C_CR1_START);

> +	for (i = 0; i < num && !ret; i++)
> +		ret = loongson2_i2c_xfer_msg(priv, &msgs[i], i == num - 1);
> +
> +	return (ret < 0) ? ret : num;

	for (i = 0; i < num; i++) {
		ret = loongson2_i2c_xfer_msg(priv, &msgs[i], i == num - 1);
		if (ret < 0)
			return ret;
	}

	return num;


> +}

...

> +static int loongson2_i2c_adjust_bus_speed(struct loongson2_i2c_priv *priv)
> +{
> +	u32 val, freq, ccr = 0, cr2 = 0;

Redundant assignment(s), see below why.

> +	priv->parent_rate = clk_get_rate(priv->clk);
> +	freq = DIV_ROUND_UP(priv->parent_rate, HZ_TO_MHZ);

Use unit suffix:

	freq_mhz = ...

(if I am not mistaken).

> +	cr2 |= FIELD_GET(LOONGSON2_I2C_CR2_FREQ, freq);

	cr2 = FIELD_GET(LOONGSON2_I2C_CR2_FREQ, freq);

> +	regmap_write(priv->regmap, LOONGSON2_I2C_CR2, cr2);
> +
> +	if (priv->speed == LOONGSON2_I2C_SPEED_STANDARD) {
> +		val = DIV_ROUND_UP(priv->parent_rate, I2C_MAX_STANDARD_MODE_FREQ * 2);

		/* Select Standard mode */
		ccr = 0;

> +	} else {
> +		val = DIV_ROUND_UP(priv->parent_rate, I2C_MAX_FAST_MODE_FREQ * 3);
> +
> +		/* Select Fast mode */
> +		ccr |= LOONGSON2_I2C_CCR_FS;

		ccr = LOONGSON2_I2C_CCR_FS;

> +	}

> +	ccr |= FIELD_GET(LOONGSON2_I2C_CCR_CCR, val);

FIELD_MODIFY()?

> +	regmap_write(priv->regmap, LOONGSON2_I2C_CCR, ccr);
> +
> +	/* reference clock determination the configure val(0x3f) */
> +	regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR2, LOONGSON2_I2C_CR2_FREQ,
> +			   LOONGSON2_I2C_CR2_FREQ);
> +	regmap_update_bits(priv->regmap, LOONGSON2_I2C_TRISE, LOONGSON2_I2C_TRISE_SCL,
> +			   LOONGSON2_I2C_TRISE_SCL);
> +
> +	/* Enable I2C */
> +	regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I2C_CR1_PE,
> +			   LOONGSON2_I2C_CR1_PE);
> +
> +	return 0;
> +}

...

> +static int loongson2_i2c_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct loongson2_i2c_priv *priv;
> +	struct i2c_adapter *adap;
> +	void __iomem *base;
> +	u32 clk_rate;
> +	int irq, ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))

> +		return dev_err_probe(dev, PTR_ERR(base),
> +				     "Failed to ioremap resource.\n");

You utilise 100, put this on a single line.

But, this is a dup, devm_platform_*() call above takes care already about error
message.

> +
> +	priv->regmap = devm_regmap_init_mmio(dev, base,
> +					     &loongson2_i2c_regmap_config);

Single line.

> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "Failed to init regmap.\n");

Single line.

> +	priv->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Failed  to enable clock.\n");

Single line.

> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return -EINVAL;

Why?! What's wrong with the error code in 'irq'?

> +	priv->dev = dev;
> +
> +	adap = &priv->adapter;
> +	adap->retries = 5;
> +	adap->nr = pdev->id;
> +	adap->dev.parent = dev;
> +	adap->owner = THIS_MODULE;
> +	adap->algo = &loongson2_i2c_algo;
> +	adap->timeout = 2 * HZ;
> +	device_set_node(&adap->dev, dev_fwnode(dev));
> +	i2c_set_adapdata(adap, priv);

> +	strscpy(adap->name, pdev->name, sizeof(adap->name));

2-arguments version is even better.

> +	init_completion(&priv->complete);
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->speed = LOONGSON2_I2C_SPEED_STANDARD;

> +	ret = of_property_read_u32(dev->of_node, "clock-frequency", &clk_rate);

device_property_read_u32()

> +	if (!ret && clk_rate >= I2C_MAX_FAST_MODE_FREQ)
> +		priv->speed = LOONGSON2_I2C_SPEED_FAST;
> +
> +	ret = loongson2_i2c_adjust_bus_speed(priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_irq(dev, irq, loongson2_i2c_isr_event, IRQF_SHARED, pdev->name, priv);
> +	if (ret)

> +		return dev_err_probe(dev, ret, "Unable to request irq %d\n", irq);

Dup message.

		return ret;

> +	return devm_i2c_add_adapter(dev, adap);
> +}

...

> +static struct platform_driver loongson2_i2c_driver = {
> +	.driver = {
> +		.name = "loongson2-i2c-v2",
> +		.of_match_table = loongson2_i2c_id_table,
> +	},
> +	.probe = loongson2_i2c_probe,
> +};

> +

Remove this blank line.

> +module_platform_driver(loongson2_i2c_driver);

-- 
With Best Regards,
Andy Shevchenko


