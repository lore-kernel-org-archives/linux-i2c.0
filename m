Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BD03E3D99;
	Wed, 27 May 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872118; cv=none; b=JL9DObnOqMoJMfX25wxaf13c9rSbh/lGpAH6rGYq75jog0eol5QFeDS5HFONdU8otOzgiPjXRHwRA73cYuAjIcA80u6smCWRL5v2X89FY++5mGal4zvQbPtwNuMUblwImp7zAYbXAgnztcrGbGDdMF7mxansmS2e/vTUea7Wi38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872118; c=relaxed/simple;
	bh=NMCfMzlLpagJzJRq9pz1qMTfTzqkM4CV0skvqOiEnmY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=E22Ufwe3Sg8EGdRClyLAz7bPoPNHEnireyVk0ACeB9QqT81OrtEW4/u2pY78ia4NLkfAiUAFG1QPh3Z0NSkcjJ2UXKBAW056Fff3/ieFs5xNvyDZeaoN1pKcsVV6j6ctLvCBzYcd2AJm7Fn0TOdAA3snUlKdDNrVCKYCQ4wBoSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8CxhnhzsRZqNbYNAA--.14317S3;
	Wed, 27 May 2026 16:55:15 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJCx2+BysRZqopqSAA--.15952S3;
	Wed, 27 May 2026 16:55:14 +0800 (CST)
Subject: Re: [PATCH v4 2/2] i2c: ls2x: Add clocks property parsing and adjust
 bus speed
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20260526031021.32662-1-wanghongliang@loongson.cn>
 <20260526031021.32662-3-wanghongliang@loongson.cn>
 <CAAhV-H71ZiakZaLVKYg2Qvp8ZJiT7hr9P9bAmXCrjWkHg+-vGg@mail.gmail.com>
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <404a35fa-b126-4ae8-b1c6-3a0d524b7138@loongson.cn>
Date: Wed, 27 May 2026 16:54:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H71ZiakZaLVKYg2Qvp8ZJiT7hr9P9bAmXCrjWkHg+-vGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJCx2+BysRZqopqSAA--.15952S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFykCF4fZrWkGF17ZF13GFX_yoWruw4xpF
	WUCFW5KF4qqF12grsIq3W7ZFyYvws5JFW8Cr17t3WxX3Zavrn3Z3WxGrn0kFykuF97u3y8
	ZayqgrsxuFyqvrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7BMNUUU
	UU=

Hi, Huacai,

On 2026/5/27 下午3:05, Huacai Chen wrote:
> Hi, Hongliang,
>
> On Tue, May 26, 2026 at 11:11 AM Hongliang Wang
> <wanghongliang@loongson.cn> wrote:
>> From: wanghongliang <wanghongliang@loongson.cn>
>>
>> The i2c-ls2x driver supports dts and acpi parameter passing.
>>
>> In dts, uses clock framework, by parsing clocks property to
>> get i2c bus reference clock, and define the div of reference
>> clock by device data.
>>
>> In acpi, by passing clocks property to describe i2c bus reference
>> clock and clock-div property to describe the div of reference clock.
>>
>> Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
>> and div, calculate the prcescale of i2c divider register. The
>> calculation formula is
>>
>> prcescale = (clock_a*10)/(div*clock_s)-1
>>
>> Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
>> ---
>>   drivers/i2c/busses/i2c-ls2x.c | 35 ++++++++++++++++++++++++++++++++---
>>   1 file changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-ls2x.c b/drivers/i2c/busses/i2c-ls2x.c
>> index b475dd27b7af..6d332e59452d 100644
>> --- a/drivers/i2c/busses/i2c-ls2x.c
>> +++ b/drivers/i2c/busses/i2c-ls2x.c
>> @@ -12,6 +12,7 @@
>>
>>   #include <linux/bitfield.h>
>>   #include <linux/bits.h>
>> +#include <linux/clk.h>
>>   #include <linux/completion.h>
>>   #include <linux/device.h>
>>   #include <linux/iopoll.h>
>> @@ -63,11 +64,18 @@
>>   /* The default bus frequency, which is an empirical value */
>>   #define LS2X_I2C_FREQ_STD      (33 * HZ_PER_KHZ)
>>
>> +/* The div of i2c reference clock on 2K0500/2K1000/2K2000 */
> Please use "LS2K0500/2K1000/2K2000".
OK.
>> +#define LS2X_I2C_2K_CLOCK_DIV  40
>> +
>> +/* The div of i2c reference clock on 7A1000/7A2000 */
> And "LS7A1000/7A2000".
OK.
> BTW, I think this series should be CC stable.
OK, I will add Cc: stable@vger.kernel.org in the next version patch series.
> Huacai
>
>> +#define LS2X_I2C_7A_CLOCK_DIV  50
>> +
>>   struct ls2x_i2c_priv {
>>          struct i2c_adapter      adapter;
>>          void __iomem            *base;
>>          struct i2c_timings      i2c_t;
>>          struct completion       cmd_complete;
>> +       unsigned int            div;
>>   };
>>
>>   /*
>> @@ -96,6 +104,8 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void *dev_id)
>>   static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>>   {
>>          u16 val;
>> +       u32 pclk, div;
>> +       struct clk *clk;
>>          struct i2c_timings *t = &priv->i2c_t;
>>          struct device *dev = priv->adapter.dev.parent;
>>          u32 acpi_speed = i2c_acpi_find_bus_speed(dev);
>> @@ -107,12 +117,29 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>>          else
>>                  t->bus_freq_hz = LS2X_I2C_FREQ_STD;
>>
>> +       if (dev_of_node(dev)) {
>> +               clk = devm_clk_get_optional_enabled(dev, NULL);
>> +               if (clk && !IS_ERR(clk))
>> +                       pclk = clk_get_rate(clk);
>> +               else
>> +                       pclk = LS2X_I2C_PCLK_FREQ;
>> +
>> +               div = priv->div;
>> +
>> +               val = (pclk * 10) / (div * t->bus_freq_hz) - 1;
>> +       } else {
>> +               if (!device_property_read_u32(dev, "clocks", &pclk) &&
>> +                   !device_property_read_u32(dev, "clock-div", &div))
>> +                       val = (pclk * 10) / (div * t->bus_freq_hz) - 1;
>> +               else
>> +                       val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
>> +       }
>> +
>>          /*
>>           * According to the chip manual, we can only access the registers as bytes,
>>           * otherwise the high bits will be truncated.
>>           * So set the I2C frequency with a sequential writeb() instead of writew().
>>           */
>> -       val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
>>          writeb(FIELD_GET(GENMASK(7, 0), val), priv->base + I2C_LS2X_PRER_LO);
>>          writeb(FIELD_GET(GENMASK(15, 8), val), priv->base + I2C_LS2X_PRER_HI);
>>   }
>> @@ -295,6 +322,8 @@ static int ls2x_i2c_probe(struct platform_device *pdev)
>>          if (!priv)
>>                  return -ENOMEM;
>>
>> +       priv->div = (unsigned int)(unsigned long)device_get_match_data(dev);
>> +
>>          /* Map hardware registers */
>>          priv->base = devm_platform_ioremap_resource(pdev, 0);
>>          if (IS_ERR(priv->base))
>> @@ -349,8 +378,8 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ls2x_i2c_pm_ops,
>>                                   ls2x_i2c_suspend, ls2x_i2c_resume, NULL);
>>
>>   static const struct of_device_id ls2x_i2c_id_table[] = {
>> -       { .compatible = "loongson,ls2k-i2c" },
>> -       { .compatible = "loongson,ls7a-i2c" },
>> +       { .compatible = "loongson,ls2k-i2c", .data = (void *)LS2X_I2C_2K_CLOCK_DIV, },
>> +       { .compatible = "loongson,ls7a-i2c", .data = (void *)LS2X_I2C_7A_CLOCK_DIV, },
>>          { /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, ls2x_i2c_id_table);
>> --
>> 2.47.2
>>
>>

Best regards,
Hongliang Wang

