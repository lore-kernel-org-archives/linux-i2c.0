Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABCD332EBC;
	Fri,  8 May 2026 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226018; cv=none; b=px58NdToRJRqq6sjefWRqMq0V4XRMrxFgJPbdx37QajEVxv70GSg/3xVcl0Jbr2hOMmRpcmF0Dhrn5dcqkJ3F6h1j4NRn5ZjmLqHf9uwXhRfRZQbMCGT0pkYn7h112Geo5iT5IW4yad676Rt/S7YXaN9STu+OxiBJFCHPiXQIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226018; c=relaxed/simple;
	bh=qGk9d8Z1VrjgcXudsrd+torirjSVmgBPM3a7xCDLKZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4k8dKxbMXHEI3yv25+fVYrbgzo5XliwNT/5RLhKO/oHFEwIlhM0EgOBlD7PHqdGpAT2naeocY+QkpUm8UvMwL3w9Ds/wxKVuy8fYyD9XLP335/X7zw10xIWVcRLuOctkIffIRSjlyVb+68I6Wsc6QOF4P6hr1vPKJtWUBIaJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.8])
	by gateway (Coremail) with SMTP id _____8DxBOlck_1pY88HAA--.19033S3;
	Fri, 08 May 2026 15:40:13 +0800 (CST)
Received: from [10.161.0.102] (unknown [223.64.68.8])
	by front1 (Coremail) with SMTP id qMiowJCxNMBZk_1pf8d8AA--.7809S2;
	Fri, 08 May 2026 15:40:11 +0800 (CST)
Message-ID: <def047ed-5be6-4968-950d-ddb6ddbfa6df@loongson.cn>
Date: Fri, 8 May 2026 15:40:08 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: ls2x-v2: return IRQ_HANDLED after servicing an
 error
To: David Carlier <devnexen@gmail.com>
Cc: andi.shyti@kernel.org, chenhuacai@kernel.org,
 andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260506044818.19842-1-devnexen@gmail.com>
 <20260506154015.94815-1-devnexen@gmail.com>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20260506154015.94815-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJCxNMBZk_1pf8d8AA--.7809S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEBCGn9eyoBwQAAsP
X-Coremail-Antispam: 1Uk129KBj93XoW7KF13JF48Jr1DKw1UWF1fKrX_yoW8uFy3pr
	W5tanYkr1DKry2vFn0qry7ZFy5ZrWfK3y7WF4Dtan8Zan8Xr1Uur4ftFWY9rykury8JF42
	v3yDWw4xCa98ArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU88Ma5UUUUU==

Hi David:

Thanks for your patch.

On 2026/5/6 23:40, David Carlier wrote:
> The event ISR reads SR1 and, when an error flag (ARLO/AF/BERR) is set,
> calls loongson2_i2c_isr_error() which clears the offending flag, issues
> STOP for the AF case, records msg->result, masks every CR2 interrupt
> enable and completes the waiter. The handler then returns IRQ_NONE,
> declaring to the IRQ core that the device did not interrupt.
> 
> That report is wrong. The device did interrupt and the handler fully
> serviced it. Because the IRQ is requested with IRQF_SHARED, the genirq
> spurious-IRQ tracker counts each error as unhandled. A bus that emits
> sporadic NACKs, arbitration losses or bus errors will therefore march
> toward the spurious-IRQ threshold and the line can end up disabled,
> wedging the controller.
> 
> Return IRQ_HANDLED on this path. The other IRQ_NONE site, taken when
> neither an event nor an error bit is set, remains correct.
> 
> Fixes: 6d1b0785f6d5 ("i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller")
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: David Carlier <devnexen@gmail.com>

I tested the above boundary conditions on the Loongson-2K0300 platform, 
and the issue does indeed exist.

Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>
Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
> v2:
>   - Add Assisted-by: Codex:GPT-5.5 trailer (no code change).
> 
>   drivers/i2c/busses/i2c-ls2x-v2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ls2x-v2.c b/drivers/i2c/busses/i2c-ls2x-v2.c
> index 517760d70169..9df73557ecc4 100644
> --- a/drivers/i2c/busses/i2c-ls2x-v2.c
> +++ b/drivers/i2c/busses/i2c-ls2x-v2.c
> @@ -304,7 +304,7 @@ static irqreturn_t loongson2_i2c_isr_event(int irq, void *data)
>   	regmap_read(priv->regmap, LOONGSON2_I2C_SR1, &status);
>   	if (status & LOONGSON2_I2C_SR1_ITERREN_MASK) {
>   		loongson2_i2c_isr_error(status, data);
> -		return IRQ_NONE;
> +		return IRQ_HANDLED;
>   	}
>   
>   	regmap_read(priv->regmap, LOONGSON2_I2C_CR2, &cr2);

-- 
Thanks.
Binbin

