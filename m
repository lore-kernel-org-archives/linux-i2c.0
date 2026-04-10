Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154D93AD518;
	Fri, 10 Apr 2026 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809259; cv=none; b=Hf2jKH6kTbazl0qEUlx4xRudxqhpxiWgi8+Pknnd3Iw0taDciTQEOX9mLiJ97I9S84K8cEFg0qSAESfNQFs6vXIfaNPdvbPTOHB6hfwNF2if38HPLQmk7PVylL/AjOm3Liz2VlDM6I9tXgRq7HK7RvD6JejZ4nCRmADdnMugzyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809259; c=relaxed/simple;
	bh=OFHEx486+doBb6U2ENiOcMTUx2zJFUWYJ5DRPbM5rb0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IJdXLKU22WC41Pd12PSF4/s/3MxqTHtJRAfi2mmY7C5oEA+DBYaCfhDzxvyP0W2kVdoo2SLfv25kjWBA4gKYRtEM4tFv1KmGjVb+B/QUcYVZSYyFkte4o2HFgcEb4vsfNbGjOuhsiOf2kv0BDD+z0GG5nSfAzrzWD3pseinYKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8BxWcLmsthpeOwjAA--.34410S3;
	Fri, 10 Apr 2026 16:20:54 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJCxHOHlsthp9zhqAA--.5473S3;
	Fri, 10 Apr 2026 16:20:53 +0800 (CST)
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
 <a08ac3f9-a770-df48-a95b-4b07cd2c0d58@loongson.cn>
 <e10017ce-cda0-5b5e-8cd8-3488aef4cdb0@loongson.cn>
 <dc1c0b6d-b6e6-4a88-8e50-e8316e3dcf5e@kernel.org>
 <0f560e80-3fbb-c24f-51f9-b4425db17867@loongson.cn>
 <3c57275e-0574-46e5-9893-053ae5cc22cb@kernel.org>
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <991204c6-6710-e62c-69ab-d7db91325013@loongson.cn>
Date: Fri, 10 Apr 2026 16:20:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3c57275e-0574-46e5-9893-053ae5cc22cb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJCxHOHlsthp9zhqAA--.5473S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw4rWFy5Wr1fXr1DXw4UWrX_yoW8Wr13pF
	Z3KF1qyrZ8Aryvv397Kw1xZr1Yyws8Cr4rJry8KryUZw45ZryrtF1fArZ5Wr9Y9r1fA3yj
	va1kGa4DurZxZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
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
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jU
	sqXUUUUU=


On 2026/4/10 下午2:42, Krzysztof Kozlowski wrote:
> On 10/04/2026 05:04, Hongliang Wang wrote:
>> Hi, Krzysztof
>>
>> On 2026/4/9 下午8:11, Krzysztof Kozlowski wrote:
>>> On 09/04/2026 14:03, Hongliang Wang wrote:
>>>> I have a question, the input clock of i2c controller can be described by
>>>> "clocks",
>>>> but there is no existing attribute can describe the divisor of the input
>>>> clock,
>>>> Can I define a new attribute named "clock-div" to describe it in DT
>>>> bindings?
>>>> or do you have any standard solutions for the divisor problem? Thank you.
>>>>
>>> You should determine/calculate the divisor in the driver code, depending
>>> on clocks and bus frequencies. You don't need a property for that, usually.
>> Not only clocks and bus frequencies, but also a third property is required.
>>
>> The frequency divison calculation formula of i2c is
>> Prcescale = clock_a/(clock_div*clock_s)-1
>>
>> There is three parameters in this formula:
>> clock_a represents the input clock, which is described by "clocks",
>> clock_s represents the i2c bus frequency, which is described by
>> "clock-frequency",
>> but there is no existing property to describe clock_div, which has
>> different value
>> on different platform (for example, it is 5 on 7a1000/7a2000, 4 on
>> 2K1000/2K2000,
>> 5.5 on 2K3000.), So I need a property to describe clock_div in this formula.
> So it is fixed per compatible? Then you do not need.
>
OK, I will fix the clock_div based on per compatible. thank you.
> Best regards,
> Krzysztof
Best regards,
Hongliang Wang

