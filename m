Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A6381B05
	for <linux-i2c@vger.kernel.org>; Tue,  8 Sep 2026 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849215; cv=none; b=tJfJYIEcGcUuYDq8Ft4+Wu9IgKen0Gaz16OwcHEDEzIIEgzf5zTZvl9vnFNpNAgRbryc9rfhXTE7lF/un1GpJ0P5TMuFt+LBAb98Pkf80bTVoL4diBmBpuOyEUg7ybIG1RFJKs1DVrkV2So/EYVkwhKvJCeLEP9mnxiiceJU4HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849215; c=relaxed/simple;
	bh=7aQWP2Vor/3sXPBp+dn/JJmr/1wEPteY5kKIKy0vNo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDjkmOI0KJKaagYn63Hr4Z0kl9QxnqaUe1QiIp3HoZZPGojYLfIG7uc80LEULueLFCyOzqhVzsUGRrAxyFZPkUv48WqrNIJrKH7UPDrg5s5h5Nz8rd6wTKN5xH81TWKBvLcezsniFd57bhtgNyL1/glg3wH+VONde6wwZoAB3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAeXS3Y6; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAeXS3Y6"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc439bfb2d8so2612316a12.2
        for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 23:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788849212; x=1789454012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsJi2lZEpF2IDanNSkhreh3goiVXfD4CAZAn7dod6ww=;
        b=bAeXS3Y6ela68qwQUfnpCk1oTtJTQd35wzLm/Zv3hdeQXCPbzW01D52v5LXEIVUXgU
         UBcyhX3AJyWlOKoa+SRo/LTWZ1+dsi8/PRnjzjqwFMHhpVcZiAfgepLAbcMH6K6UhFjF
         ht9REVfsqszruOrqdtFx/A9fB2pPPlrgbcCOYZETLF0jIu6VrNmIvIHu2J45yxusOaqR
         T9LGVrhGWdXiAZ1ZfuuUvXgpsDZ8hE3LJX38RwAPK0lbc+whJBqHWbhywLA17ZvvnJI9
         HLKJ2/b5RWKE2zexOBo2RnTJTb2Zf2hNYYsYgYrPzT3HMTI4IxXT0joVcQT0QCaP72fd
         KTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788849212; x=1789454012;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tsJi2lZEpF2IDanNSkhreh3goiVXfD4CAZAn7dod6ww=;
        b=KNDvoetgRXKH+5XUE0UfDiWrKYJwcBDOXvxbCorQB5mKaIiKcwzMS3UxCRUz5RrnzG
         0S6DZnrYR6p7efvAk8kFUzfiSPO82bAoBNYTBC9p92lE8/oShd46SibYruu2RO5o1HvG
         It6mE0OSx1Ad6GA2AwyYgSBAMIsjycDi1arXWyl3Bf52syos04VDePue0b6zMmh6++fQ
         aBWOWLaB3FemwrPuQREWxgD60m+Mw2S6uHcN+6uWaV6MTPd09xskYzLWVFezlACaqa81
         1C9fUaFBpUOjzEhaVSRTx/aFR9sRa5u7fzJuUE0/Hf0eAOTU2bauAnPI7Vs60hp289DX
         ET9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwQCRPmIRT1HiD0kZ0vGVupk7OnJBF34H/S3o6GnMrMFNOE9d0loYeIdMum4vuETD65HJty7nSNmYo=@vger.kernel.org
X-Gm-Message-State: AFuF++mf9SzqajGmvNMC6V6IrcWy+V7sbMK/ob+iZCpKbbWtRqrv5ldm
	uF56kbBQmZ6KT9xmgycVxFRj+whr+snX5EWnvaJ58VdyBgjahkP6QZja
X-Gm-Gg: AYBFou3w+7vfKYVJ134D0d1o5Cxk95R/QYnJ92SW0AU9Rwm8QmC4+57fDHen+c2ZQt/
	G0Is4Iwv/rZGSa7NhucV61wnOT05P7tQsGMIeHXIcY/M+NGG8UWjMDZ0I5ySKrgwf0oQnAxTS7B
	k+v+NMyy6M02XkqS3EkvxB4pWMhEU/3O7N5EdEwkEvlrKd3+VeF5Jm5lNVTRtRTC3+Sl3fEovMg
	RN5sBGfW4M0pwindLGlhm+GyRG4NXQg5VZyd/qWUy74U21M5uzv9cpBM3evUtZtDp0VpGlX+nIa
	/CiXw4tEfbq1KxnmS15SJiLV+8AANFSOKIA83qnIY2DMZ7NsjcLKEu8hwVfiK9+JQkxpR6uHMPd
	rRl1hKiQHckUTTgShOh8w0pfrcjsFU+VZgxngergFfLeJBCj28BXUPLdwXPQ0g8gEne95okti3C
	OrJK+nqpTKE9QiIuSgzx9uJYMGqQ40UQWDUGstCvhiDl/o4NxUmYKByrgRQNVCQsMeiMm5yw+Bl
	57plztMtHMEzBrxhYqEWQEedhg8PZZVcMw=
X-Received: by 2002:a17:90b:2884:b0:398:e86b:ce14 with SMTP id 98e67ed59e1d1-39b262ab44emr39243676a91.20.1788849211851;
        Mon, 07 Sep 2026 23:33:31 -0700 (PDT)
Received: from [172.19.1.48] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d0d845sm31381442a91.17.2026.09.07.23.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 23:33:30 -0700 (PDT)
Message-ID: <bbe24480-a844-4b02-b072-6388859cdc1e@gmail.com>
Date: Tue, 8 Sep 2026 14:33:26 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] i2c: ma35d1: Add Nuvoton MA35D1 I2C driver support
To: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
References: <20260807060400.2047517-1-zychennvt@gmail.com>
 <20260807060400.2047517-3-zychennvt@gmail.com>
Content-Language: en-US
From: zychen <zychennvt@gmail.com>
In-Reply-To: <20260807060400.2047517-3-zychennvt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andi,

Gentle ping on this patch.

You reviewed the driver part in v7, and this part has been updated in v8/v9 based on the review feedback.

The v9 series was sent on Aug 7. Please let me know if you have any further comments on this version.

Thanks!
Zi-Yu Chen

Zi-Yu Chen 於 2026/8/7 下午 02:03 寫道:
> Add I2C support for Nuvoton MA35D1 SoC.
> The controller supports standard, fast and fast-plus modes,
> and provides controller/target functionality.
> 
> Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
> ---
>  drivers/i2c/busses/Kconfig      |  13 +
>  drivers/i2c/busses/Makefile     |   1 +
>  drivers/i2c/busses/i2c-ma35d1.c | 779 ++++++++++++++++++++++++++++++++
>  3 files changed, 793 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-ma35d1.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d7b89508311f..e69120d46977 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1602,4 +1602,17 @@ config I2C_VIRTIO
>            This driver can also be built as a module. If so, the module
>            will be called i2c-virtio.
>  
> +config I2C_MA35D1
> +	tristate "Nuvoton MA35D1 I2C driver"
> +	depends on ARCH_MA35 || COMPILE_TEST
> +	select I2C_SLAVE
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  I2C controller in the Nuvoton MA35D1 SoC. This driver
> +	  supports the standard I2C bus protocols, including master and
> +	  slave modes.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called i2c-ma35d1.
> +
>  endmenu
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 3755c54b3d82..ca75dae4955c 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -131,6 +131,7 @@ obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
>  obj-$(CONFIG_I2C_XLP9XX)	+= i2c-xlp9xx.o
>  obj-$(CONFIG_I2C_RCAR)		+= i2c-rcar.o
>  obj-$(CONFIG_I2C_GXP)		+= i2c-gxp.o
> +obj-$(CONFIG_I2C_MA35D1)	+= i2c-ma35d1.o
>  
>  # External I2C/SMBus adapter drivers
>  obj-$(CONFIG_I2C_DIOLAN_U2C)	+= i2c-diolan-u2c.o
> diff --git a/drivers/i2c/busses/i2c-ma35d1.c b/drivers/i2c/busses/i2c-ma35d1.c
> new file mode 100644
> index 000000000000..61d7605c3a05
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-ma35d1.c
> @@ -0,0 +1,779 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026 Nuvoton technology corporation.
> + *
> + * Author: Zi-Yu Chen <zychennvt@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/reset.h>
> +#include <linux/units.h>
> +
> +/* MA35D1 I2C registers offset */
> +#define MA35_CTL0		0x00
> +#define MA35_ADDR0		0x04
> +#define MA35_DAT		0x08
> +#define MA35_STATUS0	0x0c
> +#define MA35_CLKDIV		0x10
> +#define MA35_TOCTL		0x14
> +#define MA35_ADDR1		0x18
> +#define MA35_ADDR2		0x1c
> +#define MA35_ADDR3		0x20
> +#define MA35_ADDRMSK0	0x24
> +#define MA35_ADDRMSK1	0x28
> +#define MA35_ADDRMSK2	0x2c
> +#define MA35_ADDRMSK3	0x30
> +#define MA35_WKCTL		0x3c
> +#define MA35_WKSTS		0x40
> +#define MA35_CTL1		0x44
> +#define MA35_STATUS1	0x48
> +#define MA35_TMCTL		0x4c
> +#define MA35_BUSCTL		0x50
> +#define MA35_BUSTCTL	0x54
> +#define MA35_BUSSTS		0x58
> +#define MA35_PKTSIZE	0x5c
> +#define MA35_PKTCRC		0x60
> +#define MA35_BUSTOUT	0x64
> +#define MA35_CLKTOUT	0x68
> +#define MA35_AUTOCNT	0x78
> +
> +/* MA35D1 I2C Status */
> +/* Controller */
> +#define MA35_M_START				0x08	/* Start */
> +#define MA35_M_REPEAT_START			0x10	/* Controller Repeat Start */
> +#define MA35_M_TRAN_ADDR_ACK		0x18	/* Controller Transmit Address ACK */
> +#define MA35_M_TRAN_ADDR_NACK		0x20	/* Controller Transmit Address NACK */
> +#define MA35_M_TRAN_DATA_ACK		0x28	/* Controller Transmit Data ACK */
> +#define MA35_M_TRAN_DATA_NACK		0x30	/* Controller Transmit Data NACK */
> +#define MA35_M_ARB_LOST				0x38	/* Controller Arbitration Lost */
> +#define MA35_M_RECE_ADDR_ACK		0x40	/* Controller Receive Address ACK */
> +#define MA35_M_RECE_ADDR_NACK		0x48	/* Controller Receive Address NACK */
> +#define MA35_M_RECE_DATA_ACK		0x50	/* Controller Receive Data ACK */
> +#define MA35_M_RECE_DATA_NACK		0x58	/* Controller Receive Data NACK */
> +#define MA35_BUS_ERROR				0x00	/* Bus error */
> +
> +/*  Target */
> +#define MA35_S_REPEAT_START_STOP	0xa0	/* Target Transmit Repeat Start or Stop */
> +#define MA35_S_TRAN_ADDR_ACK		0xa8	/* Target Transmit Address ACK */
> +#define MA35_S_TRAN_DATA_ACK		0xb8	/* Target Transmit Data ACK */
> +#define MA35_S_TRAN_DATA_NACK		0xc0	/* Target Transmit Data NACK */
> +#define MA35_S_TRAN_LAST_DATA_ACK	0xc8	/* Target Transmit Last Data ACK */
> +#define MA35_S_RECE_ADDR_ACK		0x60	/* Target Receive Address ACK */
> +#define MA35_S_RECE_ARB_LOST		0x68	/* Target Receive Arbitration Lost */
> +#define MA35_S_RECE_DATA_ACK		0x80	/* Target Receive Data ACK */
> +#define MA35_S_RECE_DATA_NACK		0x88	/* Target Receive Data NACK */
> +
> +/* Other */
> +#define MA35_ADDR_TRAN_ARB_LOST		0xb0	/* Address Transmit Arbitration Lost */
> +#define MA35_BUS_RELEASED			0xf8	/* Bus Released */
> +
> +/*  I2C_CTL constant definitions. */
> +#define MA35_CTL_AA			BIT(2)
> +#define MA35_CTL_SI			BIT(3)
> +#define MA35_CTL_STO		BIT(4)
> +#define MA35_CTL_STA		BIT(5)
> +#define MA35_CTL_I2CEN		BIT(6)
> +#define MA35_CTL_INTEN		BIT(7)
> +#define MA35_CTL_SI_AA		(MA35_CTL_SI | MA35_CTL_AA)
> +#define MA35_CTL_STO_SI		(MA35_CTL_STO | MA35_CTL_SI)
> +#define MA35_CTL_STA_SI		(MA35_CTL_STA | MA35_CTL_SI)
> +
> +/* Constants */
> +#define MA35_CLKDIV_MSK		GENMASK(15, 0)
> +#define I2C_PM_TIMEOUT_MS	5000
> +#define STOP_TIMEOUT_MS		50
> +
> +struct ma35d1_i2c {
> +	spinlock_t lock;
> +	wait_queue_head_t wait;
> +	struct i2c_msg *msg;
> +	unsigned int msg_num;
> +	unsigned int msg_idx;
> +	unsigned int msg_ptr;
> +	int err;
> +	int irq;
> +	void __iomem *regs;
> +	struct clk *clk;
> +	struct device *dev;
> +	struct i2c_adapter adap;
> +	struct i2c_client *target;
> +	struct reset_control *rst;
> +};
> +
> +static inline bool ma35d1_is_controller_status(unsigned int status)
> +{
> +	return status >= MA35_M_START && status <= MA35_M_RECE_DATA_NACK;
> +}
> +
> +/*
> + * ma35d1_i2c_write_ctl - Update the I2C control register
> + * @i2c: Pointer to the ma35d1 i2c instance
> + * @ctl: Control bits to set (e.g., MA35_CTL_STA, SI, AA)
> + *
> + * Read-modify-write the CTL0 register while preserving unrelated bits.
> + */
> +static void ma35d1_i2c_write_ctl(struct ma35d1_i2c *i2c, unsigned int ctl)
> +{
> +	unsigned int val;
> +
> +	guard(spinlock_irqsave)(&i2c->lock);
> +	val = readl(i2c->regs + MA35_CTL0);
> +	val &= ~(MA35_CTL_SI_AA);
> +	val |= ctl;
> +	writel(val, i2c->regs + MA35_CTL0);
> +}
> +
> +static void ma35d1_i2c_set_addr(struct ma35d1_i2c *i2c)
> +{
> +	unsigned int rw = i2c->msg->flags & I2C_M_RD;
> +
> +	writel(((i2c->msg->addr & 0x7f) << 1) | rw, i2c->regs + MA35_DAT);
> +}
> +
> +static void ma35d1_i2c_controller_complete(struct ma35d1_i2c *i2c)
> +{
> +	i2c->msg_ptr = 0;
> +	i2c->msg = NULL;
> +	i2c->msg_idx++;
> +	i2c->msg_num = 0;
> +
> +	wake_up(&i2c->wait);
> +}
> +
> +static void ma35d1_i2c_reset(struct ma35d1_i2c *i2c)
> +{
> +	unsigned int clkdiv, slvaddr;
> +
> +	clkdiv = readl(i2c->regs + MA35_CLKDIV);
> +	slvaddr = readl(i2c->regs + MA35_ADDR0);
> +
> +	disable_irq(i2c->irq);
> +	i2c->msg = NULL;
> +	reset_control_assert(i2c->rst);
> +	usleep_range(10, 20);
> +	reset_control_deassert(i2c->rst);
> +	enable_irq(i2c->irq);
> +
> +	writel(clkdiv, (i2c->regs + MA35_CLKDIV));
> +	ma35d1_i2c_write_ctl(i2c, MA35_CTL_I2CEN | MA35_CTL_INTEN);
> +
> +	if (i2c->target)
> +		writel(slvaddr, i2c->regs + MA35_ADDR0);
> +}
> +
> +static void ma35d1_i2c_stop(struct ma35d1_i2c *i2c, int ret)
> +{
> +	ma35d1_i2c_write_ctl(i2c, MA35_CTL_STO_SI);
> +
> +	if (ret)
> +		i2c->err = ret;
> +
> +	ma35d1_i2c_controller_complete(i2c);
> +}
> +
> +/*
> + * ma35d1_i2c_restore_idle - restore controller state to idle
> + * @i2c: Pointer to the ma35d1 i2c instance
> + *
> + * Restore the controller to an idle state after an unexpected event.
> + * Abort an active controller transfer, otherwise re-arm target mode
> + * if enabled.
> + */
> +static void ma35d1_i2c_restore_idle(struct ma35d1_i2c *i2c)
> +{
> +	if (i2c->msg)
> +		ma35d1_i2c_stop(i2c, -EIO);
> +	else if (i2c->target)
> +		ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI_AA);
> +	else
> +		ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI);
> +}
> +
> +/* Check if this is the last message in the set */
> +static inline bool is_last_msg(struct ma35d1_i2c *i2c)
> +{
> +	return i2c->msg_idx >= (i2c->msg_num - 1);
> +}
> +
> +/* Check if this is the last byte in the current message */
> +static inline bool is_last_byte(struct ma35d1_i2c *i2c)
> +{
> +	return i2c->msg_ptr == i2c->msg->len - 1;
> +}
> +
> +/* Check if reached the end of the current message */
> +static inline bool is_msgend(struct ma35d1_i2c *i2c)
> +{
> +	return i2c->msg_ptr >= i2c->msg->len;
> +}
> +
> +/*
> + * ma35d1_i2c_irq_target_trx - I2C Target state machine handler
> + * @i2c: ma35d1 i2c instance
> + * @i2c_status: hardware status code from MA35_STATUS0
> + */
> +static irqreturn_t ma35d1_i2c_irq_target_trx(struct ma35d1_i2c *i2c,
> +					     unsigned long i2c_status)
> +{
> +	unsigned char byte = 0;
> +
> +	switch (i2c_status) {
> +	case MA35_S_RECE_ARB_LOST:
> +		/*
> +		 * Arbitration lost during address transmission phase.
> +		 * The hardware switches to Target Transmitter mode when
> +		 * our own SLA+W is detected on the bus.
> +		 */
> +		i2c->err = -EAGAIN;
> +		ma35d1_i2c_controller_complete(i2c);
> +		i2c_slave_event(i2c->target, I2C_SLAVE_WRITE_REQUESTED, &byte);
> +		break;
> +
> +	case MA35_S_RECE_ADDR_ACK:
> +		/* Own SLA+W has been receive; ACK has been return */
> +		i2c_slave_event(i2c->target, I2C_SLAVE_WRITE_REQUESTED, &byte);
> +		break;
> +
> +	case MA35_S_TRAN_DATA_NACK:
> +	case MA35_S_RECE_DATA_NACK:
> +		/*
> +		 * Data byte or last data in I2CDAT has been transmitted and NACK received,
> +		 * or previously addressed with own SLA address and NACK returned.
> +		 */
> +		break;
> +
> +	case MA35_S_RECE_DATA_ACK:
> +		/*
> +		 * Previously address with own SLA address Data has been received;
> +		 * ACK has been returned
> +		 */
> +		byte = readb(i2c->regs + MA35_DAT);
> +		i2c_slave_event(i2c->target, I2C_SLAVE_WRITE_RECEIVED, &byte);
> +		break;
> +
> +	case MA35_ADDR_TRAN_ARB_LOST:
> +		/*
> +		 * Arbitration lost during address transmission phase.
> +		 * The hardware switches to Target Receiver mode when
> +		 * our own SLA+R is detected on the bus.
> +		 */
> +		i2c->err = -EAGAIN;
> +		ma35d1_i2c_controller_complete(i2c);
> +		i2c_slave_event(i2c->target, I2C_SLAVE_READ_REQUESTED, &byte);
> +		writel(byte, i2c->regs + MA35_DAT);
> +		break;
> +
> +	case MA35_S_TRAN_ADDR_ACK:
> +		/* Own SLA+R has been receive; ACK has been return */
> +		i2c_slave_event(i2c->target, I2C_SLAVE_READ_REQUESTED, &byte);
> +		writel(byte, i2c->regs + MA35_DAT);
> +		break;
> +
> +	case MA35_S_TRAN_DATA_ACK:
> +		i2c_slave_event(i2c->target, I2C_SLAVE_READ_PROCESSED, &byte);
> +		writel(byte, i2c->regs + MA35_DAT);
> +		break;
> +
> +	case MA35_S_REPEAT_START_STOP:
> +	/*
> +	 *  A STOP or repeated START has been received
> +	 *  while still addressed as Target/Receiver
> +	 */
> +		i2c_slave_event(i2c->target, I2C_SLAVE_STOP, &byte);
> +		break;
> +
> +	default:
> +		dev_err(i2c->dev, "Status 0x%02lx is NOT processed\n",
> +			i2c_status);
> +		ma35d1_i2c_restore_idle(i2c);
> +		return IRQ_NONE;
> +	}
> +	ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI_AA);
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * ma35d1_i2c_irq_controller_trx - I2C Controller state machine handler
> + * @i2c: ma35d1 i2c instance
> + * @i2c_status: hardware status code from MA35_STATUS0
> + */
> +static irqreturn_t ma35d1_i2c_irq_controller_trx(struct ma35d1_i2c *i2c,
> +						 unsigned long i2c_status)
> +{
> +	unsigned char byte;
> +
> +	/* Ensuring messages are absolutely valid in Controller mode. */
> +	if (unlikely(!i2c->msg)) {
> +		dev_err(i2c->dev, "Spurious controller interrupt (status: 0x%02lx)\n", i2c_status);
> +		ma35d1_i2c_restore_idle(i2c);
> +		return IRQ_HANDLED;
> +	}
> +
> +	switch (i2c_status) {
> +	case MA35_M_START:
> +	case MA35_M_REPEAT_START:
> +		ma35d1_i2c_set_addr(i2c);
> +		ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI);
> +		break;
> +
> +	case MA35_M_TRAN_ADDR_ACK:
> +	case MA35_M_TRAN_DATA_ACK:
> +		/* SLA+W has been transmitted and ACK has been received */
> +		if (i2c_status == MA35_M_TRAN_ADDR_ACK) {
> +			if (is_last_msg(i2c) && i2c->msg->len == 0) {
> +				ma35d1_i2c_stop(i2c, 0);
> +				return IRQ_HANDLED;
> +			}
> +		}
> +
> +		if (!is_msgend(i2c)) {
> +			byte = i2c->msg->buf[i2c->msg_ptr++];
> +			writel(byte, i2c->regs + MA35_DAT);
> +			ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI);
> +		} else if (!is_last_msg(i2c)) {
> +			dev_dbg(i2c->dev, "WRITE: Next Message\n");
> +
> +			i2c->msg_ptr = 0;
> +			i2c->msg_idx++;
> +			i2c->msg++;
> +
> +			ma35d1_i2c_write_ctl(i2c, MA35_CTL_STA | MA35_CTL_SI);
> +		} else {
> +			ma35d1_i2c_stop(i2c, 0);
> +		}
> +		break;
> +
> +	case MA35_M_TRAN_DATA_NACK:
> +		ma35d1_i2c_stop(i2c, -EIO);
> +		break;
> +
> +	case MA35_M_TRAN_ADDR_NACK:
> +	case MA35_M_RECE_ADDR_NACK:
> +		/*
> +		 * Controller Transmit Address NACK
> +		 * 0x20: SLA+W has been transmitted and NACK has been received
> +		 * 0x48: SLA+R has been transmitted and NACK has been received
> +		 */
> +		dev_dbg(i2c->dev, "\n i2c: ack was not received\n");
> +		ma35d1_i2c_stop(i2c, -ENXIO);
> +		break;
> +
> +	case MA35_M_RECE_ADDR_ACK:
> +		if (is_msgend(i2c)) {
> +			if (is_last_msg(i2c)) {
> +				ma35d1_i2c_stop(i2c, 0);
> +			} else {
> +				dev_dbg(i2c->dev, "READ: Next Transfer\n");
> +
> +				i2c->msg_ptr = 0;
> +				i2c->msg_idx++;
> +				i2c->msg++;
> +
> +				ma35d1_i2c_write_ctl(i2c, MA35_CTL_STA_SI);
> +			}
> +		} else if (i2c->msg->len == 1) {
> +			ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI);
> +		} else {
> +			ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI_AA);
> +		}
> +		break;
> +
> +	case MA35_M_RECE_DATA_ACK:
> +	case MA35_M_RECE_DATA_NACK:
> +		/* DATA has been received and ACK/NACK has been received */
> +		byte = readb(i2c->regs + MA35_DAT);
> +		i2c->msg->buf[i2c->msg_ptr++] = byte;
> +
> +		if (is_last_byte(i2c)) {
> +			ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI);
> +		} else if (is_msgend(i2c)) {
> +			if (is_last_msg(i2c)) {
> +				dev_dbg(i2c->dev, "READ: Send Stop\n");
> +
> +				ma35d1_i2c_stop(i2c, 0);
> +			} else {
> +				dev_dbg(i2c->dev, "READ: Next Transfer\n");
> +
> +				i2c->msg_ptr = 0;
> +				i2c->msg_idx++;
> +				i2c->msg++;
> +
> +				ma35d1_i2c_write_ctl(i2c, MA35_CTL_STA_SI);
> +			}
> +		} else {
> +			ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI_AA);
> +		}
> +		break;
> +
> +	case MA35_M_ARB_LOST:
> +		/* Arbitration Lost */
> +		i2c->err = -EAGAIN;
> +		ma35d1_i2c_controller_complete(i2c);
> +		ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI);
> +		break;
> +
> +	default:
> +		dev_err(i2c->dev, "Status 0x%02lx is NOT processed\n",
> +			i2c_status);
> +		ma35d1_i2c_restore_idle(i2c);
> +		return IRQ_NONE;
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ma35d1_i2c_irq(int irqno, void *dev_id)
> +{
> +	struct ma35d1_i2c *i2c = dev_id;
> +	unsigned long status;
> +
> +	status = readl(i2c->regs + MA35_STATUS0);
> +
> +	if (status == MA35_BUS_ERROR) {
> +		dev_err(i2c->dev, "bus error\n");
> +		ma35d1_i2c_restore_idle(i2c);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (ma35d1_is_controller_status(status))
> +		return ma35d1_i2c_irq_controller_trx(i2c, status);
> +	else
> +		return ma35d1_i2c_irq_target_trx(i2c, status);
> +}
> +
> +static int ma35d1_i2c_doxfer(struct ma35d1_i2c *i2c, struct i2c_msg *msgs,
> +			     int num)
> +{
> +	unsigned long timeout;
> +	unsigned int val;
> +	int ret, err;
> +
> +	i2c->msg = msgs;
> +	i2c->msg_num = num;
> +	i2c->msg_ptr = 0;
> +	i2c->msg_idx = 0;
> +	i2c->err = 0;
> +
> +	ma35d1_i2c_write_ctl(i2c, MA35_CTL_STA);
> +
> +	timeout = wait_event_timeout(i2c->wait, i2c->msg_num == 0, HZ * 5);
> +	ret = i2c->msg_idx;
> +
> +	if (timeout == 0) {
> +		dev_dbg(i2c->dev, "xfer timeout\n");
> +		ret = -ETIMEDOUT;
> +		goto reset;
> +	}
> +
> +	err = readl_poll_timeout(i2c->regs + MA35_CTL0, val,
> +				 !(val & MA35_CTL_STO), 100,
> +				 STOP_TIMEOUT_MS * 1000);
> +	if (err) {
> +		dev_err(i2c->dev, "bus idle timeout\n");
> +		ret = -EBUSY;
> +		goto reset;
> +	} else if (i2c->err) {
> +		dev_dbg(i2c->dev, "xfer error %d\n", i2c->err);
> +		ret = i2c->err;
> +	}
> +	return ret;
> +
> +reset:
> +	ma35d1_i2c_reset(i2c);
> +	return ret;
> +}
> +
> +static int ma35d1_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +			   int num)
> +{
> +	struct ma35d1_i2c *i2c = i2c_get_adapdata(adap);
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(i2c->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ma35d1_i2c_doxfer(i2c, msgs, num);
> +
> +	if (i2c->target)
> +		ma35d1_i2c_write_ctl(i2c, MA35_CTL_AA);
> +	pm_runtime_put_autosuspend(i2c->dev);
> +
> +	return ret;
> +}
> +
> +static int ma35d1_reg_target(struct i2c_client *target)
> +{
> +	struct ma35d1_i2c *i2c = i2c_get_adapdata(target->adapter);
> +	unsigned int slvaddr;
> +	int ret;
> +
> +	if (i2c->target)
> +		return -EBUSY;
> +
> +	if (target->flags & I2C_CLIENT_TEN)
> +		return -EAFNOSUPPORT;
> +
> +	/* Keep device active for target mode listening. */
> +	ret = pm_runtime_resume_and_get(i2c->dev);
> +	if (ret) {
> +		dev_err(i2c->dev, "failed to resume i2c controller\n");
> +		return ret;
> +	}
> +
> +	i2c->target = target;
> +
> +	slvaddr = target->addr << 1;
> +	writel(slvaddr, i2c->regs + MA35_ADDR0);
> +
> +	/* I2C enter SLV mode */
> +	ma35d1_i2c_write_ctl(i2c, MA35_CTL_AA);
> +
> +	return 0;
> +}
> +
> +static int ma35d1_unreg_target(struct i2c_client *target)
> +{
> +	struct ma35d1_i2c *i2c = i2c_get_adapdata(target->adapter);
> +	int ret;
> +
> +	if (!i2c->target)
> +		return -EINVAL;
> +
> +	writel(0, i2c->regs + MA35_ADDR0);
> +	/* Clear AA bit */
> +	ma35d1_i2c_write_ctl(i2c, 0);
> +
> +	synchronize_irq(i2c->irq);
> +	i2c->target = NULL;
> +
> +	ret = pm_runtime_put_sync(i2c->dev);
> +	if (ret < 0)
> +		dev_err(i2c->dev, "failed to suspend i2c controller");
> +
> +	return 0;
> +}
> +
> +/* Declare Our I2C Functionality */
> +static u32 ma35d1_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +/* I2C Bus Registration Info */
> +static const struct i2c_algorithm ma35d1_i2c_algorithm = {
> +	.xfer = ma35d1_i2c_xfer,
> +	.functionality = ma35d1_i2c_func,
> +	.reg_target = ma35d1_reg_target,
> +	.unreg_target = ma35d1_unreg_target,
> +};
> +
> +static const struct i2c_adapter_quirks ma35d1_i2c_quirks = {
> +	.flags = I2C_AQ_NO_ZERO_LEN_READ,
> +};
> +
> +static int ma35d1_i2c_suspend(struct device *dev)
> +{
> +	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
> +	unsigned int val;
> +
> +	/* Prepare for wake-up from I2C events if target mode is active */
> +	if (i2c->target) {
> +		ma35d1_i2c_write_ctl(i2c, MA35_CTL_AA);
> +
> +		/* Setup wake-up control */
> +		writel(0x1, i2c->regs + MA35_WKCTL);
> +
> +		/* Clear pending wake-up flags */
> +		val = readl(i2c->regs + MA35_WKSTS);
> +		writel(val, i2c->regs + MA35_WKSTS);
> +
> +		enable_irq_wake(i2c->irq);
> +
> +		return 0;
> +	}
> +	return pm_runtime_force_suspend(dev);
> +}
> +
> +static int ma35d1_i2c_resume(struct device *dev)
> +{
> +	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
> +	unsigned int val;
> +
> +	if (i2c->target) {
> +		/* Disable wake-up */
> +		writel(0x0, i2c->regs + MA35_WKCTL);
> +
> +		/* Clear pending wake-up flags */
> +		val = readl(i2c->regs + MA35_WKSTS);
> +		writel(val, i2c->regs + MA35_WKSTS);
> +
> +		disable_irq_wake(i2c->irq);
> +		return 0;
> +	}
> +	return pm_runtime_force_resume(dev);
> +}
> +
> +static int ma35d1_i2c_runtime_suspend(struct device *dev)
> +{
> +	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
> +
> +	clk_disable(i2c->clk);
> +
> +	return 0;
> +}
> +
> +static int ma35d1_i2c_runtime_resume(struct device *dev)
> +{
> +	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_enable(i2c->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock in resume\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ma35d1_i2c_pm_cleanup(void *data)
> +{
> +	struct device *dev = data;
> +
> +	pm_runtime_get_sync(dev);
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
> +}
> +
> +static int ma35d1_i2c_probe(struct platform_device *pdev)
> +{
> +	unsigned int busfreq = I2C_MAX_STANDARD_MODE_FREQ;
> +	struct device *dev = &pdev->dev;
> +	struct ma35d1_i2c *i2c;
> +	struct resource *res;
> +	int ret, clkdiv;
> +	u32 val;
> +
> +	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
> +	if (!i2c)
> +		return -ENOMEM;
> +
> +	init_waitqueue_head(&i2c->wait);
> +	spin_lock_init(&i2c->lock);
> +
> +	i2c->dev = dev;
> +
> +	i2c->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(i2c->clk))
> +		return dev_err_probe(dev, PTR_ERR(i2c->clk),
> +				     "failed to get core clk\n");
> +
> +	i2c->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(i2c->regs))
> +		return PTR_ERR(i2c->regs);
> +
> +	i2c->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(i2c->rst))
> +		return dev_err_probe(dev, PTR_ERR(i2c->rst),
> +				     "failed to get reset control\n");
> +
> +	ret = reset_control_deassert(i2c->rst);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to deassert reset line\n");
> +
> +	/* Setup info block for the I2C core */
> +	strscpy(i2c->adap.name, "ma35d1-i2c", sizeof(i2c->adap.name));
> +	i2c->adap.owner = THIS_MODULE;
> +	i2c->adap.algo = &ma35d1_i2c_algorithm;
> +	i2c->adap.quirks = &ma35d1_i2c_quirks;
> +	i2c->adap.retries = 2;
> +	i2c->adap.algo_data = i2c;
> +	i2c->adap.dev.parent = &pdev->dev;
> +	i2c->adap.dev.of_node = pdev->dev.of_node;
> +	i2c_set_adapdata(&i2c->adap, i2c);
> +
> +	if (!device_property_read_u32(dev, "clock-frequency", &val)) {
> +		if (val != 0 && val <= MEGA)
> +			busfreq = val;
> +	}
> +	/* Calculate divider based on the current peripheral clock rate */
> +	clkdiv = DIV_ROUND_CLOSEST(clk_get_rate(i2c->clk), busfreq * 4) - 1;
> +	if (clkdiv < 0 || clkdiv > 0xffff)
> +		return dev_err_probe(dev, -EINVAL, "invalid clkdiv value: %d\n",
> +				     clkdiv);
> +
> +	i2c->irq = platform_get_irq(pdev, 0);
> +	if (i2c->irq < 0)
> +		return dev_err_probe(dev, i2c->irq, "failed to get irq\n");
> +
> +	platform_set_drvdata(pdev, i2c);
> +
> +	pm_runtime_set_autosuspend_delay(dev, I2C_PM_TIMEOUT_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	ret = devm_add_action_or_reset(dev, ma35d1_i2c_pm_cleanup, dev);
> +	if (ret)
> +		return ret;
> +
> +	writel(MA35_CTL_I2CEN | MA35_CTL_INTEN, i2c->regs + MA35_CTL0);
> +	writel(FIELD_PREP(MA35_CLKDIV_MSK, clkdiv), i2c->regs + MA35_CLKDIV);
> +
> +	ret = devm_request_irq(dev, i2c->irq, ma35d1_i2c_irq, 0, dev_name(dev),
> +			       i2c);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "cannot claim IRQ %d\n", i2c->irq);
> +		return ret;
> +	}
> +
> +	ret = devm_i2c_add_adapter(dev, &i2c->adap);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to add bus to i2c core\n");
> +		return ret;
> +	}
> +
> +	dev_info(&i2c->adap.dev, "%pa MA35D1 I2C adapter registered\n",
> +		 &res->start);
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ma35d1_i2c_pmops = {
> +	SYSTEM_SLEEP_PM_OPS(ma35d1_i2c_suspend, ma35d1_i2c_resume)
> +		RUNTIME_PM_OPS(ma35d1_i2c_runtime_suspend,
> +			       ma35d1_i2c_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id ma35d1_i2c_of_match[] = {
> +	{ .compatible = "nuvoton,ma35d1-i2c" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ma35d1_i2c_of_match);
> +
> +static struct platform_driver ma35d1_i2c_driver = {
> +	.probe      = ma35d1_i2c_probe,
> +	.driver     = {
> +		.name   = "ma35d1-i2c",
> +		.of_match_table = ma35d1_i2c_of_match,
> +		.pm = pm_ptr(&ma35d1_i2c_pmops),
> +	},
> +};
> +module_platform_driver(ma35d1_i2c_driver);
> +
> +MODULE_AUTHOR("Zi-Yu Chen <zychennvt@gmail.com>");
> +MODULE_DESCRIPTION("MA35D1 I2C Bus Driver");
> +MODULE_LICENSE("GPL");

