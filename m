Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443CB29D281;
	Fri, 10 Apr 2026 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775790303; cv=none; b=ifXMMxV9FsmEzLvRJiN/IqmdbjSCbKnZIVjn7nb7P2WS14gKv6GO+96UdWKthh7Z2nTn0wMMXYk7ledvkEISv5sz5OsdcIE2r1edU9BHtjiWG6SbA5S1myeWIZafM4ClDb0j6xHrn4lhigp7P+bk9K0qvggc8xKV6Grl5gS8/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775790303; c=relaxed/simple;
	bh=fFjdo5gcncNh1m0SWjSi0AGX9tGnwpKuDWtH4ke/rNE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=m14LitMzic+4ec8fIyouxeuGW641IYbiXmGzHE1hpr9GKniH4VWYOM0nrAv1IIlp3WFbhmn146PVPGTcFrslMPcPH3GpV+UNUg9UZOsLjboQo8Z5F8ryXbQtj6ed0JFs3ge3Yu3v7XrgCewNbsFQsC6rsnD4Zf59GSLD5pQ6lNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8BxnsPWaNhpntojAA--.34422S3;
	Fri, 10 Apr 2026 11:04:55 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJDxTMLNaNhphRBqAA--.2983S3;
	Fri, 10 Apr 2026 11:04:45 +0800 (CST)
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
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <0f560e80-3fbb-c24f-51f9-b4425db17867@loongson.cn>
Date: Fri, 10 Apr 2026 11:04:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dc1c0b6d-b6e6-4a88-8e50-e8316e3dcf5e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDxTMLNaNhphRBqAA--.2983S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw47CF1fKFWUAw1ktr4DZFc_yoW8JFykpF
	Z3Kr1DA3yDZF92v397tw1xZrn0yws8Jr4rJry8Kr17Zw45Xr18tF1fArWkXrykZrnxA390
	yan8Wa4DZrZ8Z3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07URKZXUUUUU=

Hi, Krzysztof

On 2026/4/9 下午8:11, Krzysztof Kozlowski wrote:
> On 09/04/2026 14:03, Hongliang Wang wrote:
>> I have a question, the input clock of i2c controller can be described by
>> "clocks",
>> but there is no existing attribute can describe the divisor of the input
>> clock,
>> Can I define a new attribute named "clock-div" to describe it in DT
>> bindings?
>> or do you have any standard solutions for the divisor problem? Thank you.
>>
> You should determine/calculate the divisor in the driver code, depending
> on clocks and bus frequencies. You don't need a property for that, usually.

Not only clocks and bus frequencies, but also a third property is required.

The frequency divison calculation formula of i2c is
Prcescale = clock_a/(clock_div*clock_s)-1

There is three parameters in this formula:
clock_a represents the input clock, which is described by "clocks",
clock_s represents the i2c bus frequency, which is described by 
"clock-frequency",
but there is no existing property to describe clock_div, which has 
different value
on different platform (for example, it is 5 on 7a1000/7a2000, 4 on 
2K1000/2K2000,
5.5 on 2K3000.), So I need a property to describe clock_div in this formula.


> Best regards,
> Krzysztof
Best regards,
Hongliang Wang

