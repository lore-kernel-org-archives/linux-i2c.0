Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C50030AAD8;
	Wed, 27 May 2026 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779862506; cv=none; b=CQMRrZJ3p/KOm4DqNEYeTEeHAKUxBDz0fc5+4N2nMt52kHW9P9bM8gam7xcljT2WUclduEg71t1ZZG89oV5dXKMry/TgtIjuYc6AYOqcOz7nxFBkW4xGOr3vTXCup1ATP7pN47pUOAPE9cTBIfqMhPmODUK9wWKThuO3gDSb58o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779862506; c=relaxed/simple;
	bh=YiFPYRDMN91GJeH0MRR4xomTzcDL9Jdeh4UjlW+B/04=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PmQQgytUmLficJW2JQgiI47t4pWnylWlqtmchM/C3IQEBG9J2V2LO+loAerpBXy8osnZCmOmHUTds6q0sa2mcqVWmegp7M5PyjbpW2ZFMkdBZIIuOFMl0azGxryfmM91b0eVloFAzUulJFWOMU6PvKAzK00b7QBMmZie5k91RL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8AxZnjeixZqdasNAA--.14189S3;
	Wed, 27 May 2026 14:14:54 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJDxD8PUixZq7nqSAA--.15419S3;
	Wed, 27 May 2026 14:14:53 +0800 (CST)
Subject: Re: [PATCH v4 1/2] dt-bindings: i2c: ls2x-i2c: Add clocks and
 clock-frequency properties
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20260526031021.32662-1-wanghongliang@loongson.cn>
 <20260526031021.32662-2-wanghongliang@loongson.cn>
 <20260526-inquisitive-sambar-of-wholeness-22f99d@quoll>
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <bdbabe6f-1756-c812-fe1e-2aaedf925796@loongson.cn>
Date: Wed, 27 May 2026 14:13:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260526-inquisitive-sambar-of-wholeness-22f99d@quoll>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDxD8PUixZq7nqSAA--.15419S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZrWUZFyrKrW8Jw1rKFykJFc_yoWfKrc_JF
	Wjyr409r9ayFn5u3s8tF1UZrW2q34DCr4UZF1xAF1SkF98tas8AF9rW3Z5Zw47ZFW2g34f
	WrnYyw1rC343uosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkU
	UUUU=

Hi, Krzysztof

On 2026/5/26 下午11:03, Krzysztof Kozlowski wrote:
> On Tue, May 26, 2026 at 11:10:20AM +0800, Hongliang Wang wrote:
>> From: wanghongliang <wanghongliang@loongson.cn>
>>
>> clocks property describes the i2c bus reference clock from APB clock.
>> clock-frequency property describes i2c bus speed.
> Not rally relevant to your code. We know what clocks and clock-frequency
> are.

OK, I will delete these irrelevant descriptions and add appropriate ones.

The modify is as below:

add clocks and clock-frequency properties to examples.

>> Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
> Please do not use login name as actual name. Your email has different
> Latin transcription than above.
OK, I will modify this issue.
>> ---
>>   Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
> Best regards,
> Krzysztof

Best regards,

Hongliang Wang

