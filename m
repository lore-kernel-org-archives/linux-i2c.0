Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87E51F2380;
	Thu, 26 Mar 2026 02:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491159; cv=none; b=JvJ/76cowg9Wt6Y0z+4qkn+ONQy6ADitB9bNDxeEB/dBJm7HCDoVOW1XxOTBGwyxuATawukZ3UHJmRjscYM7T9kAa2Gefakb+Un/etFK1+w3SJUKtNMK5qlthbnp3s7merYmFD2yam9xq9Whb8XX5QiMn35+VrI/tZZO8eerSqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491159; c=relaxed/simple;
	bh=dOfo0Atrong7Sgc1T7KnrLH7bcjyIUA8oVN9P0B0pEQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EaUMZc79lt1oknfp+4lpnDOnuj7RxzaFyeOhO286B0BcixMEhA8rXLvIXQX9V58b0vi3lIT6BR0QjDwIMYKbr6A5JHHKOjfYPkwjH3wzzMGvZgT02enrdIEANAGF8iUEwtCqgjG/8kCnVEAbtInz1Ph7xc7YNAf7zSYhB4AiDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8CxJMERlsRppMceAA--.41005S3;
	Thu, 26 Mar 2026 10:12:33 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJCxPMIPlsRpfY9dAA--.46396S3;
	Thu, 26 Mar 2026 10:12:32 +0800 (CST)
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
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <1b5283d8-294c-86de-c3d8-bf205ac24216@loongson.cn>
Date: Thu, 26 Mar 2026 10:12:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260325-outstanding-weasel-of-fruition-89db37@quoll>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJCxPMIPlsRpfY9dAA--.46396S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xw4rKry5WFWrWr45Gr13Jrc_yoWkurg_ZF
	yvy3WDt3s2kF9xGrnaqF45J3Waq34UG3yqgr1DAF1SgasxtF4Du3Z2vw1xWF4jqrWa9w1f
	Cw1vkw1xCr1avosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
	UUU==

Hi Krzysztof,

Consider the clock framework relies on the device tree, and can only be 
used on
Loongson 2K platform with dts parameter mechanism, It cannot be used on 
Loongson
3A+7A platform with the acpi parameter mechanism.
The i2c-ls2x driver is compatible with both Loongson 2K and 3A+7A 
platform, parse
the same parameters regardless of dts or acpi parameter passing, So 
clock-input
and clock-div attributes are defined to describe input clock of i2c 
controller and
divisor of input clock. It can be used on both 2K and 3A+7A platform.

Thanks

Hongliang Wang

On 2026/3/25 下午7:43, Krzysztof Kozlowski wrote:
> On Wed, Mar 25, 2026 at 09:18:51AM +0800, Hongliang Wang wrote:
>> From: wanghongliang <wanghongliang@loongson.cn>
>>
>> Add clock-input and clock-div properties.
>>
>> clock-input describes the input clock of i2c controller.
>> clock-div describes the clock divisor of the input clock
>> of i2c controller.
>>
>> Prcescale = (clock-input * 10) / (clock-div * t->bus_freq_hz) - 1
>>
>> Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
> Also, why are you using inconsistent identities?
>
> Best regards,
> Krzysztof

