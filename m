Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78663F7AB6;
	Wed,  6 May 2026 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061609; cv=none; b=mAeP210rb5oetJy4xIzfckf68pAMJROVL5MEXTqy3ywkQIgbuhVdhvubgHAwK+OcFKFrGmYdeqgGvcrcT8UnP7pbFdlu2BT5D3S0Rrxzp0bDkyZUst2kcYoU8Pg1EFbyhFguZ5wM3faTXgX5EMnyffAr2EJRYWXu/8pu39bbuc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061609; c=relaxed/simple;
	bh=LC9IZjPs4F1XYlSFHNbct3PIvy/2QKy+slb/zmI+e/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPXsQ+KaYnJPaWh7YV0TEKZm5VQf5ampuSCYnfXt39zYFKQYFQPQXWgXsfcUnZie/kGCkIaGoIqyZs+EE2IEa7yYLxMhC8XDLCh08QZhQurSxgLqks9gLp+ETek408a6HrME/k+glwAnCgkQqF7qlEUUW4Yr9yNA+qkOaQ5g+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.8])
	by gateway (Coremail) with SMTP id _____8Cx3ekcEftpDxMHAA--.22778S3;
	Wed, 06 May 2026 17:59:56 +0800 (CST)
Received: from [10.161.0.102] (unknown [223.64.68.8])
	by front1 (Coremail) with SMTP id qMiowJAxVcAZEftpSZd7AA--.45438S2;
	Wed, 06 May 2026 17:59:55 +0800 (CST)
Message-ID: <d6127cff-b8fa-4a03-a74f-5afa178cb39d@loongson.cn>
Date: Wed, 6 May 2026 17:59:53 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: ls2x-v2: return IRQ_HANDLED after servicing an error
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 David Carlier <devnexen@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhoubb.aaron@gmail.com
References: <20260506044818.19842-1-devnexen@gmail.com>
 <afsF2y0_oe2IloXT@ashevche-desk.local>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <afsF2y0_oe2IloXT@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJAxVcAZEftpSZd7AA--.45438S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgETCGn62CoEzAAAsx
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar45CryUCw4rur18XFW7ZFc_yoW8ZFy8pr
	W5GFnYkF1qgr1avFnIqry3Xa4YvrZxGFWUCF18Ka15Zan8tryUWr4xtFWY9r95ury8Jr42
	v3yDWw1fuas5ArXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=

Hi all:

On 2026/5/6 17:11, Andy Shevchenko wrote:
> On Wed, May 06, 2026 at 05:48:18AM +0100, David Carlier wrote:
>> The event ISR reads SR1 and, when an error flag (ARLO/AF/BERR) is set,
>> calls loongson2_i2c_isr_error() which clears the offending flag, issues
>> STOP for the AF case, records msg->result, masks every CR2 interrupt
>> enable and completes the waiter. The handler then returns IRQ_NONE,
>> declaring to the IRQ core that the device did not interrupt.
>>
>> That report is wrong. The device did interrupt and the handler fully
>> serviced it. Because the IRQ is requested with IRQF_SHARED, the genirq
>> spurious-IRQ tracker counts each error as unhandled. A bus that emits
>> sporadic NACKs, arbitration losses or bus errors will therefore march
>> toward the spurious-IRQ threshold and the line can end up disabled,
>> wedging the controller.
> Have you exhibited this on a real HW?
>
>> Return IRQ_HANDLED on this path. The other IRQ_NONE site, taken when
>> neither an event nor an error bit is set, remains correct.
> Hmm... This sounds logical, but we need the Loongson folks to confirm as this
> is sensitive code and changes like this may affect existing work flows.

I will try to test this boundary case in the next couple of days.

>
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-ls2x-v2.c b/drivers/i2c/busses/i2c-ls2x-v2.c
>> index 517760d70169..9df73557ecc4 100644
>> --- a/drivers/i2c/busses/i2c-ls2x-v2.c
>> +++ b/drivers/i2c/busses/i2c-ls2x-v2.c
>> @@ -304,7 +304,7 @@ static irqreturn_t loongson2_i2c_isr_event(int irq, void *data)
>>   	regmap_read(priv->regmap, LOONGSON2_I2C_SR1, &status);
>>   	if (status & LOONGSON2_I2C_SR1_ITERREN_MASK) {
>>   		loongson2_i2c_isr_error(status, data);
>> -		return IRQ_NONE;
>> +		return IRQ_HANDLED;
>>   	}
>>   
>>   	regmap_read(priv->regmap, LOONGSON2_I2C_CR2, &cr2);
> P.S.
> Is the analysis and/or commit message AI assisted?
Thanks.
Binbin
>

