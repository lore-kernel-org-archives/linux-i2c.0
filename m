Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8843DDDBD;
	Wed, 27 May 2026 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870443; cv=none; b=X5WzUJ//K+c6XVMPCAwkeCIGFVcPNnaCoFVOg8rk0uLbFXZkK9j0jF7sP5GoFrl3UgP/VDk0UV7lSHesL5yJtpSPWHpBayJbVKDmNpDVbES45DoYa2y74tjj3Bk2JzlGRvBi9x2SJ9XiyXQFWevVnskoJ9PWHyT6nIZzUXWDJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870443; c=relaxed/simple;
	bh=L+gMP82+Sbsl8A+5Kq/jrXlWor806MvYZ5SThD/h7Ew=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sHAoV6JKtqTLjVYlPEOXtDnS2koTFY9kaTyXXdlBZEgweUxmVFMnllB3o72wrHfPFJxijH9/9isHUhiJ3m91/pxRT3rKKbyrmVI1KFcqwk2i7zVxks0S3XSG6onQp3YkPoihhHSvDaHP/M9HMU7aNNa1fxfqZqw4SLJkgdTbg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8DxRenfqhZqOrQNAA--.32837S3;
	Wed, 27 May 2026 16:27:11 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJAxWcHbqhZqs5OSAA--.3185S3;
	Wed, 27 May 2026 16:27:10 +0800 (CST)
Subject: Re: [PATCH v4 2/2] i2c: ls2x: Add clocks property parsing and adjust
 bus speed
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20260526031021.32662-1-wanghongliang@loongson.cn>
 <20260526031021.32662-3-wanghongliang@loongson.cn>
 <20260526-pompous-gopher-of-serendipity-d72f1f@quoll>
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <46f2c75e-3066-3f27-039b-2372e4f5fb9b@loongson.cn>
Date: Wed, 27 May 2026 16:26:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260526-pompous-gopher-of-serendipity-d72f1f@quoll>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJAxWcHbqhZqs5OSAA--.3185S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur15Jr17Xr1DCF13Xr4xAFc_yoW5Ar1UpF
	y8AF45Gryjqr1xKr1kXr1UXFy0yw45JayUGw1rJ3WxXrnrXr1FqFyYgryj93WkuF48uayU
	Zw4UWr1DurWUZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
	Z7UUUUU==

Hi, Krzysztof,

On 2026/5/26 下午11:08, Krzysztof Kozlowski wrote:
> On Tue, May 26, 2026 at 11:10:21AM +0800, Hongliang Wang wrote:
>>   };
>>   
>>   /*
>> @@ -96,6 +104,8 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void *dev_id)
>>   static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>>   {
>>   	u16 val;
>> +	u32 pclk, div;
>> +	struct clk *clk;
>>   	struct i2c_timings *t = &priv->i2c_t;
>>   	struct device *dev = priv->adapter.dev.parent;
>>   	u32 acpi_speed = i2c_acpi_find_bus_speed(dev);
>> @@ -107,12 +117,29 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>>   	else
>>   		t->bus_freq_hz = LS2X_I2C_FREQ_STD;
>>   
>> +	if (dev_of_node(dev)) {
>> +		clk = devm_clk_get_optional_enabled(dev, NULL);
>> +		if (clk && !IS_ERR(clk))
> So IS_ERR_OR_NULL?

Yes,  IS_ERR_OR_NULL is better, I will fix it like this below:

         if (dev_of_node(dev)) {
                 clk = devm_clk_get_optional_enabled(dev, NULL);
-               if (clk && !IS_ERR(clk))
+               if (!IS_ERR_OR_NULL(clk))
                         pclk = clk_get_rate(clk);

>> +			pclk = clk_get_rate(clk);
>> +		else
>> +			pclk = LS2X_I2C_PCLK_FREQ;
>> +
>> +		div = priv->div;
>> +
>> +		val = (pclk * 10) / (div * t->bus_freq_hz) - 1;
>> +	} else {
>> +		if (!device_property_read_u32(dev, "clocks", &pclk) &&
> Please document here that these are *only* ACPI properties.

OK, I will document here. like this below:

         } else {
+               /* clocks and clock-div are only ACPI properties. */
                 if (!device_property_read_u32(dev, "clocks", &pclk) &&
                     !device_property_read_u32(dev, "clock-div", &div))

>> +		    !device_property_read_u32(dev, "clock-div", &div))
>> +			val = (pclk * 10) / (div * t->bus_freq_hz) - 1;
>> +		else
>> +			val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
>> +	}
>> +
>>   	/*
>>   	 * According to the chip manual, we can only access the registers as bytes,
>>   	 * otherwise the high bits will be truncated.
>>   	 * So set the I2C frequency with a sequential writeb() instead of writew().
>>   	 */
>> -	val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
>>   	writeb(FIELD_GET(GENMASK(7, 0), val), priv->base + I2C_LS2X_PRER_LO);
>>   	writeb(FIELD_GET(GENMASK(15, 8), val), priv->base + I2C_LS2X_PRER_HI);
>>   }
>> @@ -295,6 +322,8 @@ static int ls2x_i2c_probe(struct platform_device *pdev)
>>   	if (!priv)
>>   		return -ENOMEM;
>>   
>> +	priv->div = (unsigned int)(unsigned long)device_get_match_data(dev);
> unsigned int cast should not be necessary, right?

Remove unsigned int cast without check and functional issues. So it is 
not necessary.

Would it be better to remove it?

> Best regards,
> Krzysztof

Best regards,
Hongliang Wang

