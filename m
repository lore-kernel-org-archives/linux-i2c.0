Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2C028C037;
	Sat,  9 May 2026 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778296050; cv=none; b=PyeyrEKI+0Xld4uIioPCeTQlLmEVAmwwE6kUnBxR1cjHvxaJf9+1kdVpOHTOXpo2UZpHD1eeStNaVihub9JtPSca2uCpXPJOkFtGoxsa+3TWrhtOqy1tRWsg7GwdmzphlkFKFlgVxorAHCQuFEhBFZGvca8tFdd0maTzJCeclDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778296050; c=relaxed/simple;
	bh=lR9p275Ck8plWCYXsNKeLqev36Uhe2gbnt1Be/AHsA4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dwWZfPN1dxGOEsgwtBLScG0Ey1zwX4mVz+wBjUuQk+xM7W10CZjEF1s+mrLHplTGmIGqPtU79tRpINbDZJiGtz1b0wkxYDTdMHUKQWc8ZPP06g748ckTU3cOROylfDSINJ9ohy7E3TeEw4jfqYBx8iS9NLPSMQn1x021hTvxhdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8BxzsDspP5pdhsIAA--.1932S3;
	Sat, 09 May 2026 11:07:24 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJBx78LopP5pxFJ9AA--.42505S3;
	Sat, 09 May 2026 11:07:23 +0800 (CST)
Subject: Re: [PATCH v2] i2c: ls2x: Add clocks property parsing and adjust bus
 speed
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20260507081010.12810-1-wanghongliang@loongson.cn>
 <20260507081010.12810-2-wanghongliang@loongson.cn>
 <CAAhV-H46sOPPAoH31DijWYK+v5fEzgq7ZVucCuoyRTwTgUHYxA@mail.gmail.com>
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <e1a77c4d-b347-e378-ead8-b641560d8bc7@loongson.cn>
Date: Sat, 9 May 2026 11:06:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H46sOPPAoH31DijWYK+v5fEzgq7ZVucCuoyRTwTgUHYxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJBx78LopP5pxFJ9AA--.42505S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFykCF4xXrWrKFy5KFyUArc_yoW7Jry5pF
	WDCF4rGF4qqF12qrnIqw17ZFyYvws5JFZ2yr47t3WxK3sa9r1DZa1ftr90kF1kCFW8u3yx
	Xa1qgrsxuFyqvrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
	UUU==

Hi, Huacai,

On 2026/5/8 上午11:06, Huacai Chen wrote:
> Hi, Hongliang,
>
> On Thu, May 7, 2026 at 4:11 PM Hongliang Wang <wanghongliang@loongson.cn> wrote:
>> From: wanghongliang <wanghongliang@loongson.cn>
>>
>> The i2c-ls2x driver supports dts and acpi parameter passing.
>> In dts, uses clock framework, by parsing clocks property to
>> get i2c bus reference clock, and define factor by device data.
>> In acpi, by passing clocks property to describe i2c bus reference
>> clock and clock-div property to describe factor.
>> Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
>> and factor, calculate the prcescale of i2c divider register.
>> The calculation formula is
>> prcescale = clock_a/(factor*clock_s)-1
>>
>> Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
>> ---
>>   drivers/i2c/busses/i2c-ls2x.c | 42 ++++++++++++++++++++++++++++++++---
>>   1 file changed, 39 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-ls2x.c b/drivers/i2c/busses/i2c-ls2x.c
>> index b475dd27b7af..7db91e7a5d78 100644
>> --- a/drivers/i2c/busses/i2c-ls2x.c
>> +++ b/drivers/i2c/busses/i2c-ls2x.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/bitfield.h>
>>   #include <linux/bits.h>
>>   #include <linux/completion.h>
>> +#include <linux/clk.h>
> This should be before completion.h.
>
OK.
>>   #include <linux/device.h>
>>   #include <linux/iopoll.h>
>>   #include <linux/i2c.h>
>> @@ -63,11 +64,16 @@
>>   /* The default bus frequency, which is an empirical value */
>>   #define LS2X_I2C_FREQ_STD      (33 * HZ_PER_KHZ)
>>
>> +struct ls2x_i2c_chip_data {
>> +       unsigned int    factor;
>> +};
>> +
>>   struct ls2x_i2c_priv {
>>          struct i2c_adapter      adapter;
>>          void __iomem            *base;
>>          struct i2c_timings      i2c_t;
>>          struct completion       cmd_complete;
>> +       const struct ls2x_i2c_chip_data *chip_data;
> Use "unsigned int    factor" directly?
>
OK,  I will adjust it
>>   };
>>
>>   /*
>> @@ -96,6 +102,8 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void *dev_id)
>>   static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>>   {
>>          u16 val;
>> +       u32 pclk, factor;
> factor or div? If factor is better, then rename clock-div to
> clock-factor; if div is better, then rename factor to div.
div is better,  I will adjust it
>> +       struct clk *clk;
>>          struct i2c_timings *t = &priv->i2c_t;
>>          struct device *dev = priv->adapter.dev.parent;
>>          u32 acpi_speed = i2c_acpi_find_bus_speed(dev);
>> @@ -107,12 +115,30 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>>          else
>>                  t->bus_freq_hz = LS2X_I2C_FREQ_STD;
>>
>> +       if (dev_of_node(dev)) {
>> +               clk = devm_clk_get_optional_enabled(dev, NULL);
>> +               if (IS_ERR(clk) || !clk)
>> +                       pclk = LS2X_I2C_PCLK_FREQ;
>> +               else
>> +                       pclk = clk_get_rate(clk);
> Reverse the "if & else" so the default case will be the last one, this
> is also the same as the ACPI case below.
OK
> Huacai
>
>> +
>> +               factor = priv->chip_data->factor;
>> +
>> +               val = (pclk * 10) / (factor * t->bus_freq_hz) - 1;
>> +       } else {
>> +               if (!device_property_read_u32(dev, "clocks", &pclk) &&
>> +                   !device_property_read_u32(dev, "clock-div", &factor) &&
>> +                   factor != 0)
>> +                       val = (pclk * 10) / (factor * t->bus_freq_hz) - 1;
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
>> @@ -295,6 +321,8 @@ static int ls2x_i2c_probe(struct platform_device *pdev)
>>          if (!priv)
>>                  return -ENOMEM;
>>
>> +       priv->chip_data = device_get_match_data(dev);
>> +
>>          /* Map hardware registers */
>>          priv->base = devm_platform_ioremap_resource(pdev, 0);
>>          if (IS_ERR(priv->base))
>> @@ -348,9 +376,17 @@ static int ls2x_i2c_resume(struct device *dev)
>>   static DEFINE_RUNTIME_DEV_PM_OPS(ls2x_i2c_pm_ops,
>>                                   ls2x_i2c_suspend, ls2x_i2c_resume, NULL);
>>
>> +static const struct ls2x_i2c_chip_data ls2x_i2c_2k_data = {
>> +       .factor = 4,
>> +};
>> +
>> +static const struct ls2x_i2c_chip_data ls2x_i2c_7a_data = {
>> +       .factor = 5,
>> +};
>> +
>>   static const struct of_device_id ls2x_i2c_id_table[] = {
>> -       { .compatible = "loongson,ls2k-i2c" },
>> -       { .compatible = "loongson,ls7a-i2c" },
>> +       { .compatible = "loongson,ls2k-i2c", .data = &ls2x_i2c_2k_data, },
>> +       { .compatible = "loongson,ls7a-i2c", .data = &ls2x_i2c_7a_data, },
>>          { /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, ls2x_i2c_id_table);
>> --
>> 2.47.2
>>
>>
Best regards,
Hongliang Wang

