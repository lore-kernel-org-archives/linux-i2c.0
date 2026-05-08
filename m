Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2B61C84A6;
	Fri,  8 May 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778203819; cv=none; b=DZE2d6R0V3CRJIPZ6B5BN3PyBSjgT3+CLBqZRQXwFQQhuSDnngRTVZc/O8j3rDUrZ/QjZMT5Mf8IJvolI9JybatYEzWo+siFzzanD1UKH4fvEDS1KBD8Nvrp8jjOxx4ta5oLicrD8KqVlcOrm6a7DaTzvgc5zqBx4JnbYKZtD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778203819; c=relaxed/simple;
	bh=T6A5vRZ8MOTTsYn5xOYgD4nkYbHCZB5sZBxvdYoiwpo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MJzPLAggD6b2hJxzpyQosXw2U0etT00M9nUPG9HI4vVGBPMRycZVZZtU7xffrrOKtJQ8JkQCRJqt6i2iyXhgwdmYHvC9iztdRFWE9Olh0dGcTbN6EwI8ScFzZU8Q7t3uw9TOe9W78lNcVwPBKzeEwZs+I55fBwIdU+gPLx6YiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8CxReikPP1pu70HAA--.18952S3;
	Fri, 08 May 2026 09:30:12 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJDxB8GePP1pIZ58AA--.26821S3;
	Fri, 08 May 2026 09:30:06 +0800 (CST)
Subject: Re: [PATCH v2] dt-bindings: i2c: ls2x-i2c: Add clocks and
 clock-frequency properties
To: Conor Dooley <conor@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20260507081010.12810-1-wanghongliang@loongson.cn>
 <20260507-idealize-occultist-916fd07fc235@spud>
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <84c37ac1-3a9c-b0d2-f86a-90712b45b806@loongson.cn>
Date: Fri, 8 May 2026 09:29:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260507-idealize-occultist-916fd07fc235@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDxB8GePP1pIZ58AA--.26821S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw4UXFW5Jr48JF48GFyUJwc_yoW8tr1DpF
	nrCF1UGF4jvF17W395ta4UCF1Fvr9xAws7GFZrJFy7KF9rXw1vqr1akFyDuF1rCr4rZFW2
	9FW0gw4j9FyDZabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOa93UUUUU=


On 2026/5/8 上午1:29, Conor Dooley wrote:
> On Thu, May 07, 2026 at 04:10:09PM +0800, Hongliang Wang wrote:
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
>>   
>>       i2c0: i2c@1fe21000 {
>>           compatible = "loongson,ls2k-i2c";
>>           reg = <0x1fe21000 0x8>;
>> +        clock-frequency = <100000>;
>> +        clocks = <&clk LOONGSON2_APB_CLK>;
> /stuff/linux-dt/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.example.dtb: i2c@1fe21000 (loongson,ls2k-i2c): Unevaluated properties are not allowed ('clocks' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/i2c/loongson,ls2x-i2c.yaml
>
>
> Please test your patches before sending them.
The error is becasue there is no clocks property in loongson,ls2x-i2c.yaml.
The patch is based on the following repository and uses the 
i2c-host-next branch.
I found the clocks property already exist in loongson,ls2x-i2c.yaml, so 
I didn't
add it in my patch

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git
>
> Does this device actually have a clock or not?
Yes,  the clock actually exists.
>
> Cheers,
> Conor.
>
>>           interrupt-parent = <&extioiic>;
>>           interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
>>           #address-cells = <1>;
>> -- 
>> 2.47.2
>>
Best regards,
Hongliang Wang

