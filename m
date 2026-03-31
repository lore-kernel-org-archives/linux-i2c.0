Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333140DFCA;
	Tue, 31 Mar 2026 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941106; cv=none; b=cMo0bJBVhSW0KjLQUjApB/HpbdY/ybBmuXYJMuOqoYRUAZTls2bPjzF+Y4MwqOMmgTPqODxLcZsD8UlTk+dr5BGbrpP1ikkiHXFIVYhOArzuCJbHT5iy0jrjgNt+fNzbqAhuUCEQHINLFV9+4FC6Uafv2CtUFjLvXLqioekABvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941106; c=relaxed/simple;
	bh=/olNEsyp/3XMYWJRpZWybhj9UGgkwmIqEbuk267+N+I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KOancPcnUd9HIWs/nOHQsaIGpDQG1omb7xj3WlSSAS4bC9Ndg+Z0mzd1vC4K/+idxdaQRBT6tnarcPpQhM5kn7ME5zS7F0kKF7omiL18tGSMu4G2GPOnxBpm5CHQSo8z+aoQwZz9JWUJ2/QANlrjE7aK5SG1o6HzAOmB9HF6V0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8Bx08Cec8tpTlUgAA--.32732S3;
	Tue, 31 Mar 2026 15:11:26 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJAxHMKbc8tptnNhAA--.53830S3;
	Tue, 31 Mar 2026 15:11:25 +0800 (CST)
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
 <ac62e280-1099-c0bc-f322-ba8b65307053@loongson.cn>
 <2388acbc-a927-4727-a23c-5ecd7c33a926@kernel.org>
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <a08ac3f9-a770-df48-a95b-4b07cd2c0d58@loongson.cn>
Date: Tue, 31 Mar 2026 15:11:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2388acbc-a927-4727-a23c-5ecd7c33a926@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJAxHMKbc8tptnNhAA--.53830S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFWfWFyUCF15GFy5WF4rZwc_yoW8Aw47pF
	Z3KFyDtF4DJr4Sqw1Ivw1xXF1Yvw45Jr15Wr48WFn0qws09w1SkFs3JrWUu398Ww4fC3yj
	yF4UKa97XrZrZacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70Pf
	DUUUU


On 2026/3/30 下午3:23, Krzysztof Kozlowski wrote:
> On 30/03/2026 09:18, Hongliang Wang wrote:
>> On 2026/3/27 下午2:39, Krzysztof Kozlowski wrote:
>>> On 27/03/2026 04:09, Hongliang Wang wrote:
>>>> The initial idea was that this patch could be used for both ACPI and DTS.
>>>>>>> The i2c-ls2x driver is compatible with both Loongson 2K and 3A+7A
>>>>>>> platform, parse
>>>>>>> the same parameters regardless of dts or acpi parameter passing, So
>>>>>>> clock-input
>>>>>>> and clock-div attributes are defined to describe input clock of i2c
>>>>>>> controller and
>>>>>>> divisor of input clock. It can be used on both 2K and 3A+7A platform.
>>>>>> And you cannot use them in DTS.
>>>> OK
>>>>> I need to keep guessing what you want to achieve, because neither your
>>>>> message nor commit text was explicit
>>>> What I want to achieve is to describe the input clock and divisor of I2C
>>>> controller
>>> Input clocks are defined as clock inputs obviously in DT, not as
>>> integers. Bindings need to describe the hardware, so start with that.
>> I can describe the hardware in loongson,ls2x-i2c.yaml, and I would like to
>> confirm with you what final implementation plan you agree to? clock
>> framework
>> or custom clock-input an clock-div attributes? if clock framework, how
>> can it
>> also be used for ACPI?
> And you ask DT maintainer for that? It's not relevant. You sent DT
> bindings patch, so this patch must be correct and we discuss this patch
> here.
I don't. My idea is that if the clock input attribute can't be used for both
dts and acpi, then clock framework will be used for dts and new define 
attribute
will be used for acpi. I will first implement the hardware description 
and clock
framework in Bindings.
> Best regards,
> Krzysztof

Best regards,
Hongliang Wang

