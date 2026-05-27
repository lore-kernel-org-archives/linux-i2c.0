Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23533E2AAC;
	Wed, 27 May 2026 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871540; cv=none; b=rAkAKM6i0wPPUj93LVhbmR0dA8XNhXkSAyE/92PHvcOW+yc4bAWYzx1D+plt+cREvmp1Jp2x0zconemUF3l3spu+rLOLbwVUM0OoNvKvHyG7pmvdXSO5dR1rIKBr9okWtMOHNn5Bl0eFP589tNz1Zht6TbddNvVmRmzZ3ntbHfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871540; c=relaxed/simple;
	bh=luBDYDl/M9tvtAc4l//r61bCPTtBRzinp1VAQmY6maQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JrlrwDny8a0P7lDGnzh3N1BFyFUSXRZ2wBksmdZsxL3Pnqik+ZshHP/9ITW37GYN7jGH9ip1cZkAnA5FiR92yg2Z0jdi9Br3P40GjxGwuSh/5OZGDQD7OOqo7x5tesxUvEmB26mRfIRwRGDNfMynq8hiq7BMPb8A2b6HJ4l/pL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8DxrOkvrxZqqrUNAA--.37198S3;
	Wed, 27 May 2026 16:45:35 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJDxB8EsrxZqSJiSAA--.2445S3;
	Wed, 27 May 2026 16:45:34 +0800 (CST)
Subject: Re: [PATCH v4 1/2] dt-bindings: i2c: ls2x-i2c: Add clocks and
 clock-frequency properties
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20260526031021.32662-1-wanghongliang@loongson.cn>
 <20260526031021.32662-2-wanghongliang@loongson.cn>
 <CAAhV-H5eromO_QWNhus5XJdXrhB7RXf4UgdYU_WMWMnzpgUOeA@mail.gmail.com>
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <36d205b2-c1cf-d9fc-e83c-1401c4bfdb9e@loongson.cn>
Date: Wed, 27 May 2026 16:44:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5eromO_QWNhus5XJdXrhB7RXf4UgdYU_WMWMnzpgUOeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDxB8EsrxZqSJiSAA--.2445S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF4rKr1DGF4xJF1xtw13Awc_yoW8Aw1rpa
	nrC3W8GF4FvF17u3yDt34xKF1Fvr98AFs2gFZrAFy7GasxWwnavr1akr1DuFyruFWxZayj
	gFWIgw4F9asxAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vA
	pUUUUUU==

Hi, Huacai

On 2026/5/27 下午3:03, Huacai Chen wrote:
> Hi, Hongliang,
>
> On Tue, May 26, 2026 at 11:11 AM Hongliang Wang
> <wanghongliang@loongson.cn> wrote:
>> From: wanghongliang <wanghongliang@loongson.cn>
>>
>> clocks property describes the i2c bus reference clock from APB clock.
>> clock-frequency property describes i2c bus speed.
>>
>> Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
>> ---
>>   Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
>> index ee09c6d9c5f0..4bf89bb97e7d 100644
>> --- a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
>> +++ b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
>> @@ -38,10 +38,13 @@ unevaluatedProperties: false
>>   examples:
>>     - |
>>       #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
> I don't know whether dt-bindings require alpha-betical order, if
> needed, this line should before #include
> <dt-bindings/interrupt-controller/irq.h>.

I have checked other dt-bindings files, some in alpha-betical order and

some not in alpha-betical order.

I think alpha-betical order is better, I will adjust the order.

> Huacai
>
>>       i2c0: i2c@1fe21000 {
>>           compatible = "loongson,ls2k-i2c";
>>           reg = <0x1fe21000 0x8>;
>> +        clock-frequency = <100000>;
>> +        clocks = <&clk LOONGSON2_APB_CLK>;
>>           interrupt-parent = <&extioiic>;
>>           interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
>>           #address-cells = <1>;
>> --
>> 2.47.2
>>
>>

Best regards,
Hongliang Wang

