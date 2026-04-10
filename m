Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24979A932;
	Fri, 10 Apr 2026 03:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775790380; cv=none; b=m9c7NHZmyEawj9BpmFWshbyeI+Zd2zXidnF9knP9HPkEzxxaPhEVnyhj/0ojHbRThkbRJe5bl2qZkt0pO11y/8Imlqmz8LlgHjOpIk7XAjSztPctWpKyRtbsZWsczHNTUUQL46V1RJzPjE8vhHiU+lJs7/ZqmRW+LK7JnwJzJu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775790380; c=relaxed/simple;
	bh=Ta1dGj9Uk90qAxgKt8w/tcpneI6cqiDPS95714G+5yw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=U9tRGGhk1VK5Bx3B3aUaP1Lx3cBUdtzX14ynPet2xf0Lma2lg8MnVgQSDfW/lfOb/0EECjiUve3fwhXFi3bc9dIXyG1Q5UTxPr0u4btxF13Lwdm3TB+VXC2UcfsLwAvThdpkRNkDtAU0bATHPlBRGr1OGiEmrX3spp51muw/a/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8CxKMInadhpydojAA--.1001S3;
	Fri, 10 Apr 2026 11:06:15 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJAxXcImadhp+xBqAA--.2537S3;
	Fri, 10 Apr 2026 11:06:14 +0800 (CST)
Subject: Re: [PATCH v1 1/2] dt-bindings: i2c: ls2x-i2c: Add clock- related
 properties
To: Yao Zi <me@ziyao.cc>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20260325-outstanding-weasel-of-fruition-89db37@quoll>
 <1b5283d8-294c-86de-c3d8-bf205ac24216@loongson.cn>
 <0d7dfe5b-5e2d-4850-8922-16eb6bd9bcae@kernel.org>
 <900dc1a4-66ab-411f-8a32-4c6cf339e8ec@kernel.org>
 <bc22bad4-9825-829d-1df0-a801ebd933d6@loongson.cn>
 <ca984be0-e7a6-4897-bf9f-db9465942c6e@kernel.org>
 <ac62e280-1099-c0bc-f322-ba8b65307053@loongson.cn>
 <2388acbc-a927-4727-a23c-5ecd7c33a926@kernel.org>
 <a08ac3f9-a770-df48-a95b-4b07cd2c0d58@loongson.cn>
 <e10017ce-cda0-5b5e-8cd8-3488aef4cdb0@loongson.cn> <adfF4y8_GhtExZMf@pie>
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <815c5f0f-5dbb-677a-9fb2-9cf49d71408f@loongson.cn>
Date: Fri, 10 Apr 2026 11:06:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <adfF4y8_GhtExZMf@pie>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJAxXcImadhp+xBqAA--.2537S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF18WF47Jw13CFW7XF4fZwc_yoWrXr15pF
	Z3KF97JFWDJr1Svr1Iqw1xXF1jva15JF45Xry8Wr13Wws0vw1SvF1fJrWUWFyDWr15C3yj
	yF1Uta97ZrW7ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07j83kZUUUUU=

Hi, Yao Zi

On 2026/4/9 下午11:29, Yao Zi wrote:
> On Thu, Apr 09, 2026 at 08:03:47PM +0800, Hongliang Wang wrote:
>> Hi, Krzysztof
>>
>> On 2026/3/31 下午3:11, Hongliang Wang wrote:
>>> On 2026/3/30 下午3:23, Krzysztof Kozlowski wrote:
>>>> On 30/03/2026 09:18, Hongliang Wang wrote:
>>>>> On 2026/3/27 下午2:39, Krzysztof Kozlowski wrote:
>>>>>> On 27/03/2026 04:09, Hongliang Wang wrote:
>>>>>>> The initial idea was that this patch could be used for
>>>>>>> both ACPI and DTS.
>>>>>>>>>> The i2c-ls2x driver is compatible with both Loongson 2K and 3A+7A
>>>>>>>>>> platform, parse
>>>>>>>>>> the same parameters regardless of dts or
>>>>>>>>>> acpi parameter passing, So
>>>>>>>>>> clock-input
>>>>>>>>>> and clock-div attributes are defined to
>>>>>>>>>> describe input clock of i2c
>>>>>>>>>> controller and
>>>>>>>>>> divisor of input clock. It can be used on
>>>>>>>>>> both 2K and 3A+7A platform.
>>>>>>>>> And you cannot use them in DTS.
>>>>>>> OK
>>>>>>>> I need to keep guessing what you want to achieve,
>>>>>>>> because neither your
>>>>>>>> message nor commit text was explicit
>>>>>>> What I want to achieve is to describe the input clock
>>>>>>> and divisor of I2C
>>>>>>> controller
>>>>>> Input clocks are defined as clock inputs obviously in DT, not as
>>>>>> integers. Bindings need to describe the hardware, so start with that.
>>>>> I can describe the hardware in loongson,ls2x-i2c.yaml, and I
>>>>> would like to
>>>>> confirm with you what final implementation plan you agree to? clock
>>>>> framework
>>>>> or custom clock-input an clock-div attributes? if clock framework, how
>>>>> can it
>>>>> also be used for ACPI?
>>>> And you ask DT maintainer for that? It's not relevant. You sent DT
>>>> bindings patch, so this patch must be correct and we discuss this patch
>>>> here.
>>> I don't. My idea is that if the clock input attribute can't be used for
>>> both
>>> dts and acpi, then clock framework will be used for dts and new define
>>> attribute
>>> will be used for acpi. I will first implement the hardware description
>>> and clock
>>> framework in Bindings.
>>>> Best regards,
>>>> Krzysztof
>>> Best regards,
>>> Hongliang Wang
>>>
>> I have a question, the input clock of i2c controller can be described by
>> "clocks",
>> but there is no existing attribute can describe the divisor of the input
>> clock,
>  From the description of 7A1000's user manual (section 2.3
> "时钟功能描述"), it seems the divider isn't part of the I2C controller,
> but instead is an on-chip divider with fixed 1/2 factor, feeding both
> "MISC" block (including I2C) and SPI.
>
>> Can I define a new attribute named "clock-div" to describe it in DT
>> bindings?
>> or do you have any standard solutions for the divisor problem? Thank you.
> If these devicetree-based Loongson platforms follow a similar pattern as
> the bridge chip, then the divisor shouldn't be described in the I2C
> controller node. You may want to include a "fixed-factor-clock" node to
> match the hardware.
>
Sorry, I didn't describe it clearly, The divisor I described doesn't 
refer to
the fixed 1/2 factor feeding MISC block(including I2C). What I have 
described
is included in the formula in section 10.2 of the 7a1000 user manual.

Prcescale = clock_a/(clock_div*clock_s)-1

clock_a represents the input clock(it is the fixed 1/2 factor feeding 
MISC block
(including I2C), 50M on 7a1000), which is described by "clocks",
clock_s represents the i2c bus frequency, which is described by 
"clock-frequency",
The divisor I described is clock_div in formula. which has different 
value on
different platform. for example, it is 5 on 7a1000/7a2000, 4 on 
2K1000/2K2000,
5.5 on 2K3000. I need a property to describe clock_div in this formula.
>> Best regards,
>> Hongliang Wang
>>
>>
>>
> Regards,
> Yao Zi
Best regards,
Hongliang Wang

