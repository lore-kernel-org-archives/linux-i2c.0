Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C1B37B021;
	Thu,  9 Apr 2026 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736254; cv=none; b=m+vOelGfJCypLykj6C/uxnOZALlSKECdGl9HRN6UeleuM7qvJJUlxqBTiEdEkrI/iuw5xv4NlPiViUxTTFO6zIQJWJ30Mv4v5byDC28V5Dbs10R3fAWdRlLQevD4ViKLqazomZIvxzA/+PGpxbMVWCrKKVulano3BaH97dz9uHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736254; c=relaxed/simple;
	bh=5WasvOpauCqZlJbQqv5FdiGEWOrnwuKxSVRmUTAcyjs=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JOSJNJfQGWbDEkvOS/Ca1dnl2g1nTAKb0ibECKwJx8gBSEteWTmC3kQf4EFSND8gi1gjfiL3eTTfvU1zrsZSUl5qvOuVF2wU3knKzB3bfq+JdXfkWHYwPQhAYDh2xJXqXVrMUpdlpNaLHztLcWamtHPUedcCWjvSNCkpSZzZ6OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8CxosCxlddpj4ojAA--.39949S3;
	Thu, 09 Apr 2026 20:04:02 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJCxWeCulddprHtpAA--.4704S3;
	Thu, 09 Apr 2026 20:04:00 +0800 (CST)
Subject: Re: [PATCH v1 1/2] dt-bindings: i2c: ls2x-i2c: Add clock- related
 properties
From: Hongliang Wang <wanghongliang@loongson.cn>
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
 <ac62e280-1099-c0bc-f322-ba8b65307053@loongson.cn>
 <2388acbc-a927-4727-a23c-5ecd7c33a926@kernel.org>
 <a08ac3f9-a770-df48-a95b-4b07cd2c0d58@loongson.cn>
Message-ID: <e10017ce-cda0-5b5e-8cd8-3488aef4cdb0@loongson.cn>
Date: Thu, 9 Apr 2026 20:03:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a08ac3f9-a770-df48-a95b-4b07cd2c0d58@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJCxWeCulddprHtpAA--.4704S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr43JFyfZryfWFW8Kw1kCrX_yoW8Kr4fpF
	95KFyqyFWDAr4Svw10qw1xXF1Yvw45Jr15Xry8Grn8Xws0vw1SyF1fJrWUC3yUWr4fC3yj
	yF1Uta97XrZrZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU1RBT5UUUUU==

Hi, Krzysztof

On 2026/3/31 下午3:11, Hongliang Wang wrote:
>
> On 2026/3/30 下午3:23, Krzysztof Kozlowski wrote:
>> On 30/03/2026 09:18, Hongliang Wang wrote:
>>> On 2026/3/27 下午2:39, Krzysztof Kozlowski wrote:
>>>> On 27/03/2026 04:09, Hongliang Wang wrote:
>>>>> The initial idea was that this patch could be used for both ACPI 
>>>>> and DTS.
>>>>>>>> The i2c-ls2x driver is compatible with both Loongson 2K and 3A+7A
>>>>>>>> platform, parse
>>>>>>>> the same parameters regardless of dts or acpi parameter 
>>>>>>>> passing, So
>>>>>>>> clock-input
>>>>>>>> and clock-div attributes are defined to describe input clock of 
>>>>>>>> i2c
>>>>>>>> controller and
>>>>>>>> divisor of input clock. It can be used on both 2K and 3A+7A 
>>>>>>>> platform.
>>>>>>> And you cannot use them in DTS.
>>>>> OK
>>>>>> I need to keep guessing what you want to achieve, because neither 
>>>>>> your
>>>>>> message nor commit text was explicit
>>>>> What I want to achieve is to describe the input clock and divisor 
>>>>> of I2C
>>>>> controller
>>>> Input clocks are defined as clock inputs obviously in DT, not as
>>>> integers. Bindings need to describe the hardware, so start with that.
>>> I can describe the hardware in loongson,ls2x-i2c.yaml, and I would 
>>> like to
>>> confirm with you what final implementation plan you agree to? clock
>>> framework
>>> or custom clock-input an clock-div attributes? if clock framework, how
>>> can it
>>> also be used for ACPI?
>> And you ask DT maintainer for that? It's not relevant. You sent DT
>> bindings patch, so this patch must be correct and we discuss this patch
>> here.
> I don't. My idea is that if the clock input attribute can't be used 
> for both
> dts and acpi, then clock framework will be used for dts and new define 
> attribute
> will be used for acpi. I will first implement the hardware description 
> and clock
> framework in Bindings.
>> Best regards,
>> Krzysztof
>
> Best regards,
> Hongliang Wang
>

I have a question, the input clock of i2c controller can be described by 
"clocks",
but there is no existing attribute can describe the divisor of the input 
clock,
Can I define a new attribute named "clock-div" to describe it in DT 
bindings?
or do you have any standard solutions for the divisor problem? Thank you.

Best regards,
Hongliang Wang


