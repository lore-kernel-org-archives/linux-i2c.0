Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B525A39EF17;
	Mon, 30 Mar 2026 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855156; cv=none; b=XMia/SF27/xGoSKLxUtxdsASa8GPvJ/c+bonnXWJg7osxUBmw732HYm9fj6PtZbHExmDrLk+ttEWSz20f6gzyeOmxxiYoSv/ROELQJIe+Ebi1fmPVm2TbkP+MQo+f2ow2wzEuCcRvMDjdEsoks/n0w1eSh6zB5AG3xsbjJeKk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855156; c=relaxed/simple;
	bh=hyYfLWivSbr1GppGoqqzdr+sTJwkv37dXKOHBxYBOHY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RZUAfbLYAIjtG+McQB//jEo1OQwVvAa0JUxMBf4gtLKsGCMbCujSJtVuuuGLIhCHYILGKp/r4AuyA9tM5OILdvL1z3wApm+JqcKgOyyYiW7RgKdLI+4hh3jY4SUJP/rbYr3n0ExRCHhPM+JIfDsMWqTZAvvArgWRC/A9OdGiDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8Dx_8PmI8ppCt4fAA--.25415S3;
	Mon, 30 Mar 2026 15:19:03 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJCx+8HlI8ppPJBgAA--.53085S3;
	Mon, 30 Mar 2026 15:19:01 +0800 (CST)
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
 <bc22bad4-9825-829d-1df0-a801ebd933d6@loongson.cn>
 <ca984be0-e7a6-4897-bf9f-db9465942c6e@kernel.org>
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <ac62e280-1099-c0bc-f322-ba8b65307053@loongson.cn>
Date: Mon, 30 Mar 2026 15:18:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ca984be0-e7a6-4897-bf9f-db9465942c6e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJCx+8HlI8ppPJBgAA--.53085S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWrKF4xCr48WrW7Ww4UXw4DZFc_yoW8JryDpF
	93Ka4Dtr4DJr1Sqw1jqw1xXFn0qws8Jw1UJry8GF1agws8uw1IyFn3CrWUC3yrWw4fA3yj
	yF45J397JFZrZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
	WIevJa73UjIFyTuYvjxU2fMaUUUUU


On 2026/3/27 下午2:39, Krzysztof Kozlowski wrote:
> On 27/03/2026 04:09, Hongliang Wang wrote:
>> The initial idea was that this patch could be used for both ACPI and DTS.
>>>>> The i2c-ls2x driver is compatible with both Loongson 2K and 3A+7A
>>>>> platform, parse
>>>>> the same parameters regardless of dts or acpi parameter passing, So
>>>>> clock-input
>>>>> and clock-div attributes are defined to describe input clock of i2c
>>>>> controller and
>>>>> divisor of input clock. It can be used on both 2K and 3A+7A platform.
>>>> And you cannot use them in DTS.
>> OK
>>> I need to keep guessing what you want to achieve, because neither your
>>> message nor commit text was explicit
>> What I want to achieve is to describe the input clock and divisor of I2C
>> controller
> Input clocks are defined as clock inputs obviously in DT, not as
> integers. Bindings need to describe the hardware, so start with that.
I can describe the hardware in loongson,ls2x-i2c.yaml, and I would like to
confirm with you what final implementation plan you agree to? clock 
framework
or custom clock-input an clock-div attributes? if clock framework, how 
can it
also be used for ACPI?
>
> Best regards,
> Krzysztof

Best regards,
Hongliang Wang

