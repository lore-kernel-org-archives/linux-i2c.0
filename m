Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6273D9DCC
	for <linux-i2c@vger.kernel.org>; Wed, 29 Apr 2026 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466439; cv=none; b=eK3OD+rRDVt8L/+UjdhuY0M8L6kIhPkCJePQ+FncBzJYmCXYYbUI4vz/KYbKwxVZSUqBwPOBuDN6yHjLdJRE5lT/iUb20iM3E/eZ9LqL5OLFuFZKzxYz/FCpquVvt2TcGsvy8Lw7gwllh+N+AeQv4saMrZ9WZsQ2b6G9OJG3OG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466439; c=relaxed/simple;
	bh=p9LfLbt2CL3xYkF61MZ4SKP6qKcnUY29kAaezTs/DYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RelPr7oxpoUF1klmzzCJDb5I45YH3c7krjB51ySSvrNSMCk5zUgah6HCCeR064xzIysgz6dj0YueYXBUyrtIRRDE5Gh1havAPQgU/aCdqqhyX/XYNxHiXM86f8R/cvOGAUuWjpnEXJQXJhvAjjC6wlzOxerCRIJrRimjJzKP/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=LnhepYIA; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="LnhepYIA"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8ea8563c693so1158771385a.2
        for <linux-i2c@vger.kernel.org>; Wed, 29 Apr 2026 05:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777466435; x=1778071235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AQ5XP6I4G+z1uJQPPD0WQCwIgKJzLp5z1uFbOhgID4=;
        b=LnhepYIAzyJZkhW62hqrdIPUNRa6ghIvFewNHz1pgvdzjMXOQLEoVFXjscdO5ZyDXp
         pwRpx9GWYvMBri3+82up23uA2FGZUOvtWN54lGT7AGckkeGhw2r02qGmGA0Nz8D2Exls
         eV2a34UUUlx3NS+heDEqY6COijS7EOXxDwa9stV0oUy2vlb5RlKYKCfVB8ztOgKM6JdW
         GM89XPOEvDXlEFfitDZ+Dl0EEVeLsN5j+P1aQBojfmOW/QOQziPBkM3idboQfFFzilgA
         dBJzv+CzYE/R8v8ITPGwYCw996ZYJqeq2uRjDSBxox+IKUreBvbqhJPN5oSSEpg9JpSW
         G2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466435; x=1778071235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AQ5XP6I4G+z1uJQPPD0WQCwIgKJzLp5z1uFbOhgID4=;
        b=UGPGKQ6RczJ5IWISqtyHMoESl9mo0uOpteI0Ap/k1J2waA3AMUYNk/DjCYVd5ztryC
         9sWChgkfFjGt44P0mLEeIC9Vjcu37CtAKkwlggvBXXgzRDt40AJ1G8/SoEIGxi0L8qBM
         uzFFAIHOwU8xN0SFdwYDJF2sz/9ebn8Lez6effB6WqEO7JXlxa1Bcup4XIZ9+wq8bmLV
         +gWmE6bN+vAcHXZxIHYgSeaW6u1UXJG6tKYPYOpAihrPT5gfU3UPNWH4hyebr5tePKLF
         QzU9WOtB62xDbKqOraWa10cb3lZE3D6ifOLxA0d+vyZIwe2eSylWBqDUVzLrqLF3X0gt
         P/+w==
X-Gm-Message-State: AOJu0YzNXAqE0H1a++tk2HBt5M0q3SOBx9h/qi/AwpS61j/Ws6RjD86a
	5dvyZa9VxQvggkHSkDqvpPEiKkkV3q6/Ek0rcazlOXoab28mP+DIdd8Q28lScQV8JcM=
X-Gm-Gg: AeBDiespNw2bJZwOIWgxpB6IbKaVTQ6Hflwj/p7UF3ciH9oIhoet5pOoQo1Jzd9RLgm
	xWjo1QNw8PW7B+czXUAitbWGjwt8s8aSaKs6K5v+CTgB4DeV+U/uCHiuln3hPu21r2eIkrD3qWn
	auiK4LG0JYgHFcALa/+7FPyyOOqfqd50uvz09JG3VpG28pj9VzANl7Nmv6kq8DyfHAm1+jEXWyE
	+dSZleIrjcppupeu8p1gts6O+r/xyQmcQLz+VbpGHnrik2hKh3NfQKpIBp4PO+oWV9u7HfidPQW
	GF0jgybwlQvQfn3CDBNpsnIUpMG8BHKTdTu29uwMhhQ4GpAg7Vn3e+IhrfwShTg5p3RckyHw/72
	iFQeXWn138EmVwJajbssZCm93pwX72PjHHm4VybVCfjIAnuIpLv958IFBosOmUqQLp5ups4MQfF
	J9+m/unl+DI+e389L/uk9INxeD9jgvzCWCB+LUu3w3cGiw58rAietvlgxtd6BfU0tL+xRL1NTl4
	g==
X-Received: by 2002:a05:620a:698a:b0:8ea:f0e0:26dc with SMTP id af79cd13be357-8f8f44e442bmr540124185a.24.1777466434853;
        Wed, 29 Apr 2026 05:40:34 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93d0f6eccsm167392885a.20.2026.04.29.05.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 05:40:34 -0700 (PDT)
Message-ID: <01278362-ae7c-424a-838b-4add1718e7f6@riscstar.com>
Date: Wed, 29 Apr 2026 07:40:33 -0500
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] i2c: spacemit: configure ILCR/IWCR for accurate
 SCL frequency
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Andi Shyti <andi.shyti@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
References: <20260429-k1-i2c-ilcr-v6-0-1c7a5a5a8b24@linux.spacemit.com>
 <20260429-k1-i2c-ilcr-v6-1-1c7a5a5a8b24@linux.spacemit.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260429-k1-i2c-ilcr-v6-1-1c7a5a5a8b24@linux.spacemit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/26 2:48 AM, Troy Mitchell wrote:
> The SpacemiT I2C controller's SCL (Serial Clock Line) frequency for
> master mode operations is determined by the ILCR (I2C Load Count Register).
> Previously, the driver relied on the hardware's reset default
> values for this register.
> 
> The hardware's default ILCR values (SLV=0x156, FLV=0x5d) yield SCL
> frequencies lower than intended. For example, with the default
> 31.5 MHz input clock, these default settings result in an SCL
> frequency of approximately 93 kHz (standard mode) when targeting 100 kHz,
> and approximately 338 kHz (fast mode) when targeting 400 kHz.
> These frequencies are below the 100 kHz/400 kHz nominal speeds.
> 
> This patch integrates the SCL frequency management into
> the Common Clock Framework (CCF). Specifically, the ILCR register,
> which acts as a frequency divider for the SCL clock, is now registered
> as a managed clock (scl_clk) within the CCF.
> 
> The actual hardware timing formulas are:
> - standard mode: SCL = FCLK / (2 * SLV + 8)
> - fast mode:     SCL = FCLK / (2 * FLV + 10)
> 
> These formulas are only valid when the IWCR (Wait Count Register) is
> programmed to 0x142A, a value specified by the I2C IP designer. The
> driver now initializes IWCR to this value during controller init.
> 
> Reviewed-by: Yixun Lan <dlan@gentoo.org>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

I have a couple "I keep thinking the same thing when I see this"
comments...  But in summary, I make three suggestions below:
- Consider defining the magic SPACEMIT_IWCR_INIT_VALUE value
   based on the values in its fields
- Have your clk_set_rate() and clk_determine_rate() functions
   call a common helper, to eliminate some duplication of code.
- Use devm_clk_hw_register() and devm_clk_get_enabled() rather
   than the deprecated devm_clk_register() and rolling your own
   managed prepare-enable function.

> ---
> Changelog in v6:
> - fix SCL frequency calculation to match hardware timing formulas
>    (SCL = FCLK / (2*SLV+8) for standard, FCLK / (2*FLV+10) for fast)
> - initialize IWCR to 0x142A during init(required by I2C IP for
>    correct SCL timing)
> - use DIV_ROUND_CLOSEST() instead of DIV_ROUND_UP() for more accurate frequency
> - use field_prep() instead of manual bit shift for ILCR register programming
> - replace .round_rate with .determine_rate (round_rate was removed from clk_ops)
> - remove _MAX_VALUE macros (no longer needed after removing max_lv validation)
> - remove redundant max_lv validation in set_rate (determine_rate guarantees valid values)
> - simplify scl_clk_disable_unprepare callback to take clk pointer directly
> - remove unused parent parameter from spacemit_i2c_register_scl_clk()
> - remove stale description about whitespace cleanup from commit message
> - Link to v5: https://lore.kernel.org/r/20251226-k1-i2c-ilcr-v5-0-b5807b7dd0e6@linux.spacemit.com
> 
> Changelog in v5:
> - use __ffs() instead of *_SHIFT
> - remove useless *_SHIFT
> - check return value when scl clk name array is truncated
> - rebase to v6.19-rc1
> - Link to v3: https://lore.kernel.org/all/20251017-k1-i2c-ilcr-v4-1-eed4903ecdb9@linux.spacemit.com/
> 
> Changelog in v4:
> - initialize clk_init_data with {} so that init.flags is implicitly set to 0
> - minor cleanup and style fixes for better readability
> - remove unused spacemit_i2c_scl_clk_exclusive_put() cleanup callback
> - replace clk_set_rate_exclusive()/clk_rate_exclusive_put() pair with clk_set_rate()
> - simplify LCR LV field macros by using FIELD_GET/FIELD_MAX helpers
> - Link to v3: https://lore.kernel.org/all/20250814-k1-i2c-ilcr-v3-1-317723e74bcd@linux.spacemit.com/
> 
> Changelog in v3:
> - use MASK macro in `recalc_rate` function
> - rename clock name
> - Link to v2: https://lore.kernel.org/r/20250718-k1-i2c-ilcr-v2-1-b4c68f13dcb1@linux.spacemit.com
> 
> Changelog in v2:
> - Align line breaks.
> - Check `lv` in `clk_set_rate` function.
> - Force fast mode when SCL frequency is illegal or unavailable.
> - Change "linux/bits.h" to <linux/bits.h>
> - Kconfig: Add dependency on CCF.
> - Link to v1: https://lore.kernel.org/all/20250710-k1-i2c-ilcr-v1-1-188d1f460c7d@linux.spacemit.com/
> ---
>   drivers/i2c/busses/Kconfig  |   2 +-
>   drivers/i2c/busses/i2c-k1.c | 160 +++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 153 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 8c935f867a37..89898fff1967 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -793,7 +793,7 @@ config I2C_JZ4780
>   config I2C_K1
>   	tristate "SpacemiT K1 I2C adapter"
>   	depends on ARCH_SPACEMIT || COMPILE_TEST
> -	depends on OF
> +	depends on OF && COMMON_CLK
>   	help
>   	  This option enables support for the I2C interface on the SpacemiT K1
>   	  platform.
> diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
> index 9152cf436bea..fad6a20bb43d 100644
> --- a/drivers/i2c/busses/i2c-k1.c
> +++ b/drivers/i2c/busses/i2c-k1.c
> @@ -4,7 +4,9 @@
>    */
>   
>   #include <linux/bitfield.h>
> +#include <linux/bits.h>
>   #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>   #include <linux/i2c.h>
>   #include <linux/iopoll.h>
>   #include <linux/module.h>
> @@ -17,6 +19,8 @@
>   #define SPACEMIT_ISR		 0x4		/* Status register */
>   #define SPACEMIT_IDBR		 0xc		/* Data buffer register */
>   #define SPACEMIT_IRCR		 0x18		/* Reset cycle counter */
> +#define SPACEMIT_ILCR		 0x10		/* Load Count Register */
> +#define SPACEMIT_IWCR		 0x14		/* Wait Count Register */
>   #define SPACEMIT_IBMR		 0x1c		/* Bus monitor register */
>   
>   /* SPACEMIT_ICR register fields */
> @@ -88,6 +92,12 @@
>   #define SPACEMIT_BMR_SDA         BIT(0)		/* SDA line level */
>   #define SPACEMIT_BMR_SCL         BIT(1)		/* SCL line level */
>   
> +#define SPACEMIT_LCR_LV_STANDARD_MASK		GENMASK(8, 0)
> +#define SPACEMIT_LCR_LV_FAST_MASK		GENMASK(17, 9)
> +
> +/* Required by I2C IP for correct SCL timing */
> +#define SPACEMIT_IWCR_INIT_VALUE		0x142A

Even if it's just used to "do the right thing", I still think it's
useful to break this numeric value into what it *represents*.  The
register is defined this way:
COUNT		GENMASK(4:0)
HS_COUNT1	GENMASK(9:5)
HS_COUNT2	GENMASK(14:10)
(the rest is reserved)

So 0x142a represents:
COUNT		10	33 MHz I2C functional clock (versus 66 MHz)
HS_COUNT1	2	Count defining start bit setup/hold times
HS_COUNT2	3	Count defining stop bit setup/hold times

The first one in particular *could* be managed in your clock
to support even more accurate clock rates.  But even if you
don't change its value I think it's meaningful to know what
the value represents.

That said--what I suggest won't change what the code does,
it just helps the reader understand what it's doing.

> +
>   /* i2c bus recover timeout: us */
>   #define SPACEMIT_I2C_BUS_BUSY_TIMEOUT		100000
>   
> @@ -109,11 +119,20 @@ enum spacemit_i2c_state {
>   	SPACEMIT_STATE_WRITE,
>   };
>   
> +enum spacemit_i2c_mode {
> +	SPACEMIT_MODE_STANDARD,
> +	SPACEMIT_MODE_FAST
> +};

I have a consistent reaction to this--why not use a Boolean?
But I know the answer is that there are other modes that will
be supported, so the enum is the right thing to do...

> +
>   /* i2c-spacemit driver's main struct */
>   struct spacemit_i2c_dev {
>   	struct device *dev;
>   	struct i2c_adapter adapt;
>   
> +	struct clk_hw scl_clk_hw;
> +	struct clk *scl_clk;
> +	enum spacemit_i2c_mode mode;
> +
>   	/* hardware resources */
>   	void __iomem *base;
>   	int irq;
> @@ -135,6 +154,82 @@ struct spacemit_i2c_dev {
>   	u32 status;
>   };
>   
> +static void spacemit_i2c_scl_clk_disable_unprepare(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}

I have a consistent reaction to this, too, but I saw that it's
a devm action (which also explains the void pointer argument).

> +
> +static int spacemit_i2c_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +				     unsigned long parent_rate)
> +{
> +	struct spacemit_i2c_dev *i2c = container_of(hw, struct spacemit_i2c_dev, scl_clk_hw);
> +	u32 lv, lcr, mask, denom;
> +
> +	/*
> +	 * Hardware timing formulas:
> +	 * - standard mode: SCL = FCLK / (2 * SLV + 8)
> +	 * - fast mode:     SCL = FCLK / (2 * FLV + 10)
> +	 */
> +	denom = DIV_ROUND_CLOSEST(parent_rate, rate);
> +
> +	if (i2c->mode == SPACEMIT_MODE_STANDARD) {
> +		mask = SPACEMIT_LCR_LV_STANDARD_MASK;
> +		lv = (denom <= 8) ? 0 : DIV_ROUND_CLOSEST(denom - 8, 2);
> +	} else {
> +		mask = SPACEMIT_LCR_LV_FAST_MASK;
> +		lv = (denom <= 10) ? 0 : DIV_ROUND_CLOSEST(denom - 10, 2);
> +	}
> +
> +	lcr = readl(i2c->base + SPACEMIT_ILCR);
> +	lcr &= ~mask;
> +	lcr |= field_prep(mask, lv);
> +	writel(lcr, i2c->base + SPACEMIT_ILCR);
> +
> +	return 0;
> +}
> +
> +static int spacemit_i2c_clk_determine_rate(struct clk_hw *hw,
> +					   struct clk_rate_request *req)
> +{
> +	struct spacemit_i2c_dev *i2c = container_of(hw, struct spacemit_i2c_dev, scl_clk_hw);
> +	u32 lv, denom;

Can you have clk_set_rate() call clk_determine_rate(), or at
least have them both share a helper that does these (duplicated)
calculations?

> +
> +	denom = DIV_ROUND_CLOSEST(req->best_parent_rate, req->rate);
> +
> +	if (i2c->mode == SPACEMIT_MODE_STANDARD) {
> +		lv = (denom <= 8) ? 0 : DIV_ROUND_CLOSEST(denom - 8, 2);
> +		req->rate = DIV_ROUND_CLOSEST(req->best_parent_rate, lv * 2 + 8);
> +	} else {
> +		lv = (denom <= 10) ? 0 : DIV_ROUND_CLOSEST(denom - 10, 2);
> +		req->rate = DIV_ROUND_CLOSEST(req->best_parent_rate, lv * 2 + 10);
> +	}
> +
> +	return 0;
> +}
> +
> +static unsigned long spacemit_i2c_clk_recalc_rate(struct clk_hw *hw,
> +						  unsigned long parent_rate)
> +{
> +	struct spacemit_i2c_dev *i2c = container_of(hw, struct spacemit_i2c_dev, scl_clk_hw);
> +	u32 lcr, lv = 0;
> +
> +	lcr = readl(i2c->base + SPACEMIT_ILCR);
> +
> +	if (i2c->mode == SPACEMIT_MODE_STANDARD) {
> +		lv = FIELD_GET(SPACEMIT_LCR_LV_STANDARD_MASK, lcr);
> +		return DIV_ROUND_CLOSEST(parent_rate, lv * 2 + 8);
> +	}
> +
> +	lv = FIELD_GET(SPACEMIT_LCR_LV_FAST_MASK, lcr);
> +	return DIV_ROUND_CLOSEST(parent_rate, lv * 2 + 10);
> +}
> +
> +static const struct clk_ops spacemit_i2c_clk_ops = {
> +	.set_rate = spacemit_i2c_clk_set_rate,
> +	.determine_rate = spacemit_i2c_clk_determine_rate,
> +	.recalc_rate = spacemit_i2c_clk_recalc_rate,
> +};
> +
>   static void spacemit_i2c_enable(struct spacemit_i2c_dev *i2c)
>   {
>   	u32 val;
> @@ -153,6 +248,28 @@ static void spacemit_i2c_disable(struct spacemit_i2c_dev *i2c)
>   	writel(val, i2c->base + SPACEMIT_ICR);
>   }
>   
> +static struct clk *spacemit_i2c_register_scl_clk(struct spacemit_i2c_dev *i2c)
> +{
> +	struct clk_init_data init = {};
> +	char name[64];
> +	int ret;
> +
> +	ret = snprintf(name, sizeof(name), "%s_scl_clk", dev_name(i2c->dev));
> +	if (ret >= ARRAY_SIZE(name))
> +		dev_warn(i2c->dev, "scl clock name truncated");
> +
> +	init.name = name;
> +	init.ops = &spacemit_i2c_clk_ops;
> +	init.parent_data = (struct clk_parent_data[]) {
> +		{ .fw_name = "func" },
> +	};
> +	init.num_parents = 1;
> +
> +	i2c->scl_clk_hw.init = &init;
> +
> +	return devm_clk_register(i2c->dev, &i2c->scl_clk_hw);

The comments above clk_register() indicate that this is a deprecated
interface, and you should use a form of clk_hw_register() instead.
devm_clk_hw_register() exists and takes the same arguments, but
returns an int rather than the clock pointer.  But I think then you
can call devm_clk_get_enabled() in the caller (spacemit_i2c_probe()).
That would allow you to get rid of your clk_disable_unprepare()
wrapper too.

					-Alex

> +}
> +
>   static void spacemit_i2c_reset(struct spacemit_i2c_dev *i2c)
>   {
>   	writel(SPACEMIT_CR_UR, i2c->base + SPACEMIT_ICR);
> @@ -286,7 +403,7 @@ static void spacemit_i2c_init(struct spacemit_i2c_dev *i2c)
>   		val |= SPACEMIT_CR_MSDIE;
>   	}
>   
> -	if (i2c->clock_freq == SPACEMIT_I2C_MAX_FAST_MODE_FREQ)
> +	if (i2c->mode == SPACEMIT_MODE_FAST)
>   		val |= SPACEMIT_CR_MODE_FAST;
>   
>   	/* disable response to general call */
> @@ -309,6 +426,14 @@ static void spacemit_i2c_init(struct spacemit_i2c_dev *i2c)
>   	writel(val, i2c->base + SPACEMIT_IRCR);
>   
>   	spacemit_i2c_clear_int_status(i2c, SPACEMIT_I2C_INT_STATUS_MASK);
> +
> +	/*
> +	 * Initialize IWCR to the value specified by the I2C IP designer.
> +	 * The SCL frequency formulas (SCL = FCLK / (2*SLV+8) for standard
> +	 * mode, SCL = FCLK / (2*FLV+10) for fast mode) are only valid when
> +	 * IWCR contains this specific value.
> +	 */
> +	writel(SPACEMIT_IWCR_INIT_VALUE, i2c->base + SPACEMIT_IWCR);
>   }
>   
>   static void spacemit_i2c_start(struct spacemit_i2c_dev *i2c)
> @@ -703,14 +828,15 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
>   		dev_warn(dev, "failed to read clock-frequency property: %d\n", ret);
>   
>   	/* For now, this driver doesn't support high-speed. */
> -	if (!i2c->clock_freq || i2c->clock_freq > SPACEMIT_I2C_MAX_FAST_MODE_FREQ) {
> -		dev_warn(dev, "unsupported clock frequency %u; using %u\n",
> -			 i2c->clock_freq, SPACEMIT_I2C_MAX_FAST_MODE_FREQ);
> +	if (i2c->clock_freq > SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ &&
> +	    i2c->clock_freq <= SPACEMIT_I2C_MAX_FAST_MODE_FREQ) {
> +		i2c->mode = SPACEMIT_MODE_FAST;
> +	} else if (i2c->clock_freq && i2c->clock_freq <= SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ) {
> +		i2c->mode = SPACEMIT_MODE_STANDARD;
> +	} else {
> +		dev_warn(i2c->dev, "invalid clock-frequency, fallback to fast mode");
> +		i2c->mode = SPACEMIT_MODE_FAST;
>   		i2c->clock_freq = SPACEMIT_I2C_MAX_FAST_MODE_FREQ;
> -	} else if (i2c->clock_freq < SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ) {
> -		dev_warn(dev, "unsupported clock frequency %u; using %u\n",
> -			 i2c->clock_freq,  SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ);
> -		i2c->clock_freq = SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ;
>   	}
>   
>   	i2c->dev = &pdev->dev;
> @@ -732,6 +858,11 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
>   	if (IS_ERR(clk))
>   		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable func clock");
>   
> +	i2c->scl_clk = spacemit_i2c_register_scl_clk(i2c);
> +	if (IS_ERR(i2c->scl_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->scl_clk),
> +				     "failed to register scl clock\n");
> +
>   	clk = devm_clk_get_enabled(dev, "bus");
>   	if (IS_ERR(clk))
>   		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable bus clock");
> @@ -741,6 +872,19 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
>   		return dev_err_probe(dev, PTR_ERR(rst),
>   				     "failed to acquire deasserted reset\n");
>   
> +	ret = clk_set_rate(i2c->scl_clk, i2c->clock_freq);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to set rate for SCL clock");
> +
> +	ret = clk_prepare_enable(i2c->scl_clk);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to prepare and enable clock");
> +
> +	ret = devm_add_action_or_reset(dev, spacemit_i2c_scl_clk_disable_unprepare,
> +				       i2c->scl_clk);
> +	if (ret)
> +		return ret;
> +
>   	spacemit_i2c_reset(i2c);
>   
>   	i2c_set_adapdata(&i2c->adapt, i2c);
> 

