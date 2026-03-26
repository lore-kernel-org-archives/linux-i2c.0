Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587D63F7864;
	Thu, 26 Mar 2026 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525857; cv=none; b=RHd5p4PlCf4OcLAHFJ+XypGW4S31jCRw8sh8axWiDX5F0zhYlVB/3MXU3h3vk4rmtiCx+byVILyirc6c50KcZPrfS8aKIPrUyTWWY8UqtXwlOGstVyysSQ48WpCLuxKujbpA5p5JUMwXlf0Gw9G0CzZZ1cFIf+4ifS/hPgLvSLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525857; c=relaxed/simple;
	bh=yBC9iRcI0RMWYmdPl05Q2QSv8MlbDu2UM41nM8WYe6I=;
	h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=J7fT9H102IJexPlaJKoJR3ltlY6uOFEkyvBJV1bN/xysf0fofPAFntnVvmniwelNKT+emLlanKsl0FxcTsc+AwWsD6Eu6/ycmU0rebQN10jWq44HsHIlFcglLi55aKPcgXwqIqF2QZ2HPTv/MCMC1sdWkElbEJBhILZ8UAiQoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8Dx_6skHcVpsuMeAA--.29201S3;
	Thu, 26 Mar 2026 19:48:52 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJDx6+AiHcVpd+1dAA--.49386S3;
	Thu, 26 Mar 2026 19:48:50 +0800 (CST)
From: Hongliang Wang <wanghongliang@loongson.cn>
Subject: Re: [PATCH v1 1/2] dt-bindings: i2c: ls2x-i2c: Add clock- related
 properties
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20260325011852.19079-1-wanghongliang@loongson.cn>
 <20260325011852.19079-2-wanghongliang@loongson.cn>
 <20260325-outstanding-weasel-of-fruition-89db37@quoll>
 <1b5283d8-294c-86de-c3d8-bf205ac24216@loongson.cn>
 <0d7dfe5b-5e2d-4850-8922-16eb6bd9bcae@kernel.org>
 <900dc1a4-66ab-411f-8a32-4c6cf339e8ec@kernel.org>
Message-ID: <2d032399-d3fd-92b3-6dd4-28e0c78f199d@loongson.cn>
Date: Thu, 26 Mar 2026 19:48:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <900dc1a4-66ab-411f-8a32-4c6cf339e8ec@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDx6+AiHcVpd+1dAA--.49386S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF17tFWUGFy8Aw1xWFWkZrc_yoW7JryDpF
	W3Ka95Kr1qkF4SvwsFvr1xZFyYyws8Ar45Jr1UJrnrWwsxXry0vFZxGas09rWkXr1xAayj
	vrWDKayDGFW5ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
	e5UUUUU==

Hi Krzysztof and Andi,

Sorry, I didn't express myself clearly. The purpose of defining clock-input and
clock-div properties is to use them in both acpi and dts. If these properties
cannot be used in dts, can I first use them in acpi? and second, use clock
framework in dts.
if these properties can be used in acpi, use clocks property describes the
clock input may be appropriate.

the [PATCH v2] i2c: ls2x: Add clocks and clock-div properties parsing for ACPI
as follows:

 From 40bdf5588594d2b51f50682fb841c6cbe87c4297 Mon Sep 17 00:00:00 2001
From: wanghongliang <wanghongliang@loongson.cn>
Date: Sun, 12 Apr 2026 03:13:09 +0800
Subject: [PATCH v2] i2c: ls2x: Add clocks and clock-div properties parsing for
  ACPI

On 3A/7A/2K3000 platform, the input clock of i2c controller
and the divisor of input clock maybe different, so define
the clocks and clock-div properties in Device (I2Cx) in acpi
parameter passing. clocks describes the input clock of i2c
controller and clock-div describes the clock divisor of the
input clock.

  Device (I2C1)
  {
    Name (_HID, "LOON0004" /* AT Real-Time Clock */)  // _HID: Hardware ID
    Name (_UID, 0x1)  // _UID: Unique ID
    Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
    {
      ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301")
      Package (0x03)
      {
        Package (0x02)
        {
          "clock-frequency",
          100000
        }
        Package (0x02)
        {
          "clocks",
          100000000
        }
        Package (0x02)
        {
          "clock-div",
          40
        }
      }
    })

The formulas is
Prcescale = (clock-input * 10) / (clock-div * t->bus_freq_hz) - 1

The value of clocks and clock-div on different platforms are
listed below:

1.7A1000/7A2000:
clock-input = 80MHZ
clock-div = 50

2.3A5000/3C5000/3A6000/3C6000:
clock-input = 100MHZ
clock-div = 40

3.2K3000:
clock-input = 100MHZ
clock-div = 55

Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
---
  drivers/i2c/busses/i2c-ls2x.c | 13 ++++++++++++-
  1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ls2x.c b/drivers/i2c/busses/i2c-ls2x.c
index b475dd27b7af..4d1d461d065a 100644
--- a/drivers/i2c/busses/i2c-ls2x.c
+++ b/drivers/i2c/busses/i2c-ls2x.c
@@ -96,6 +96,7 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void *dev_id)
  static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
  {
  	u16 val;
+	u32 pclk, div;
  	struct i2c_timings *t = &priv->i2c_t;
  	struct device *dev = priv->adapter.dev.parent;
  	u32 acpi_speed = i2c_acpi_find_bus_speed(dev);
@@ -107,12 +108,22 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
  	else
  		t->bus_freq_hz = LS2X_I2C_FREQ_STD;
  
+	if (has_acpi_companion(dev)) {
+		if (!device_property_read_u32(dev, "clock-input", &pclk) &&
+		    !device_property_read_u32(dev, "clock-div", &div) &&
+		    div != 0)
+			val = (pclk * 10) / (div * t->bus_freq_hz) - 1;
+		else
+			val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
+	} else {
+		val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
+	}
+
  	/*
  	 * According to the chip manual, we can only access the registers as bytes,
  	 * otherwise the high bits will be truncated.
  	 * So set the I2C frequency with a sequential writeb() instead of writew().
  	 */
-	val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
  	writeb(FIELD_GET(GENMASK(7, 0), val), priv->base + I2C_LS2X_PRER_LO);
  	writeb(FIELD_GET(GENMASK(15, 8), val), priv->base + I2C_LS2X_PRER_HI);
  }
-- 
2.47.2

Best regards,
Hongliang Wang

On 2026/3/26 下午3:49, Krzysztof Kozlowski wrote:
> On 26/03/2026 08:02, Krzysztof Kozlowski wrote:
>> On 26/03/2026 03:12, Hongliang Wang wrote:
>>> Hi Krzysztof,
>>>
>>> Consider the clock framework relies on the device tree, and can only be
>>> used on
>>> Loongson 2K platform with dts parameter mechanism, It cannot be used on
>>> Loongson
>> Don't top post or request read receipts.
>>
>>> 3A+7A platform with the acpi parameter mechanism.
>> And this patch is for ACPI? Then we finish discussion here, because
>> dt-bindings is not for ACPI.
>>
>>> The i2c-ls2x driver is compatible with both Loongson 2K and 3A+7A
>>> platform, parse
>>> the same parameters regardless of dts or acpi parameter passing, So
>>> clock-input
>>> and clock-div attributes are defined to describe input clock of i2c
>>> controller and
>>> divisor of input clock. It can be used on both 2K and 3A+7A platform.
>> And you cannot use them in DTS.
> I need to keep guessing what you want to achieve, because neither your
> message nor commit text was explicit - if you need properties for ACPI
> and you want to be sure that DTS does not have them, then you could
> define them as "foo:false" with a comment why (you always explain WHY
> you are doing things). We don't have such convention so far, but I think
> it will be useful when Rob finishes the ABI checker.
>
> *Otherwise* minimum would be a comment in the driver that these are not
> allowed in DTS.
>
> Best regards,
> Krzysztof

