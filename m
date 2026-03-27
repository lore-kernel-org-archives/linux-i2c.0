Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1941431A7E2;
	Fri, 27 Mar 2026 02:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577230; cv=none; b=uDcudvuy1tUAW+iG5elK1zNLLreSjXHhkLfXGsidzYRDOlSAWmznroWC/QNqkJBwAnyuY+zCZL/5JzE1UatJnLiatHlkFjiTyX+yw/v+XrxjlKnEqa6BmlxK6Kzu1AlFfXN11UbMYK2bzSslKE417VXhMVKHHbIYG8FYOzzby/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577230; c=relaxed/simple;
	bh=x8Wmql+jTwZt0fbMLHFN0Dqp6gLv6Ey2QuwiAnQ1noY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f64qPL2Hk1C7EALUKReghRFBieOwrhhhBbQL9piVAQUfPNUKC5kS5FBcLEdjp0m3pdrSLGiRypXH4cVulK8ZuOylQPVn8krkyMXesNJ9SalMgWn28NOfa5VhX+yHaMNkv5nODfMLEBvBvvz5tVJc6uWsiVPllcF2JMoUTfk63lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8CxH6pD5sVpzCQfAA--.29517S3;
	Fri, 27 Mar 2026 10:06:59 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJDxTMJA5sVpSHVeAA--.47062S3;
	Fri, 27 Mar 2026 10:06:59 +0800 (CST)
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
 <2d032399-d3fd-92b3-6dd4-28e0c78f199d@loongson.cn>
 <4516aba8-e776-41e1-ad26-c6f817b11b58@kernel.org>
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <ccd2fc40-b6c7-66ef-8bf5-a7ceb8151195@loongson.cn>
Date: Fri, 27 Mar 2026 10:06:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4516aba8-e776-41e1-ad26-c6f817b11b58@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDxTMJA5sVpSHVeAA--.47062S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruF43WF43GF1DKryxKr18tFc_yoWxKwb_ur
	Wqyan7Zr1xAFZxKFsIqFZayry5K3y7Kr1UAr1rXr13GFy3XFWxuwsFvw1fXr1rKay2gr13
	G3sYkw4fGa4a9osvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUU
	U


On 2026/3/26 下午8:23, Krzysztof Kozlowski wrote:
> On 26/03/2026 12:48, Hongliang Wang wrote:
>> Hi Krzysztof and Andi,
>>
>> Sorry, I didn't express myself clearly. The purpose of defining clock-input and
>> clock-div properties is to use them in both acpi and dts. If these properties
>> cannot be used in dts, can I first use them in acpi? and second, use clock
>> framework in dts.
> I already asked you:
> 1. Stop requesting read receipts on your email
OK, I have set my email and removed the read receipts.
> 2. Don't top post.
OK
>
> I already told you also why these cannot be in DTS. Respond to technical
> arguments, not top-post of what you want.
OK
>
> Best regards,
> Krzysztof
Best regards,
Hongliang Wang


