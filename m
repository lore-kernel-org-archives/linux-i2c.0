Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED813BFAE2;
	Fri, 10 Jul 2026 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675737; cv=none; b=FFV8TqxsnFERlV+8DoikDsFX+4MuQmvLuA9rBYrgDAWQB9kvXVheZM/JN02v+bWdXwg0MuDOQ6iq0LHZiR1ykeSwrRsvRT5xBB4/1dwIoHWtxCNjFQ/gfMValqAY5DC5ieMmbPrG2UHSnf1a4fTDUC/SKQ20gbHwDsuaMKScQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675737; c=relaxed/simple;
	bh=T+cJ+gvOtj2VWeehJN93IAHjOkQMfIaxHa9V02dDf2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=havOFjr+4NQzZReut4gKPushHyTDOgiDBTrK1g1tp/twTA81bKTuOUq4kAQe2j/TdYZjVk0bgM7OnuAOYl683VrVP0sI5oapDQyw74Z7Bu7i9j1dGsjZCOQHkOIGMkv+uLHw+nXn42lE0F+/gZjo6lER/jFGmCC/C2SGSJGcDEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c1107e9a7c4111f1aa26b74ffac11d73-20260710
X-CID-CACHE: Type:Local,Time:202607101718+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:af1b9d85-80da-486c-8882-358161c4481b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:cd795b6054e965ba326532fc26a42d67,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c1107e9a7c4111f1aa26b74ffac11d73-20260710
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1414417490; Fri, 10 Jul 2026 17:28:47 +0800
Message-ID: <d047f823-feff-414c-b1b4-54f6ccea6b66@kylinos.cn>
Date: Fri, 10 Jul 2026 17:28:45 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: spacemit: fix spurious IRQ handling returning
 IRQ_HANDLED
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, troy.mitchell@linux.spacemit.com
References: <ef8b623f45d4e430721e46572c2598d882044aed.1783667603.git.xiaopei01@kylinos.cn>
 <ef8b623f45d4e430721e46572c2598d882044aed.1783667875.git.xiaopei01@kylinos.cn>
 <76c5567a-cc93-422c-a18f-a32dcb101428@oss.qualcomm.com>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <76c5567a-cc93-422c-a18f-a32dcb101428@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/7/10 16:50, Mukesh Savaliya 写道:
>
>
> On 7/10/2026 12:51 PM, Pei Xiao wrote:
>> When the interrupt status register reads zero, the handler should
>> return IRQ_NONE instead of IRQ_HANDLED. What the return value
>> actually feeds into is the spurious interrupt accounting in
>> note_interrupt(): falsely claiming IRQ_HANDLED defeats the "irq XX:
> note_interrupt() ? You mean to say No interrupt OR invalid interrupt
> here ? I could not understand function name. 
https://elixir.bootlin.com/linux/v7.2-rc1/source/kernel/irq/spurious.c#L222

if(unlikely
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/unlikely>(action_ret==IRQ_NONE
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/IRQ_NONE>)){ /* * If
we are seeing only the odd spurious IRQ caused by * bus asynchronicity
then don't eventually trigger an error, * otherwise the counter becomes
a doomsday timer for otherwise * working systems */ if(time_after
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/time_after>(jiffies
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/jiffies>,desc->last_unhandled
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/last_unhandled>+HZ
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/HZ>/10))
desc->irqs_unhandled
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/irqs_unhandled>=1;
else desc->irqs_unhandled
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/irqs_unhandled>++;
desc->last_unhandled
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/last_unhandled>=jiffies
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/jiffies>; } ...

if(unlikely
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/unlikely>(desc->irqs_unhandled
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/irqs_unhandled>>99900)){
/* * The interrupt is stuck */ __report_bad_irq
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/__report_bad_irq>(desc,action_ret);
/* * Now kill the IRQ */ pr_emerg
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/pr_emerg>("Disabling
IRQ #%d\n",irq); desc->istate
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/istate>|=IRQS_SPURIOUS_DISABLED
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/IRQS_SPURIOUS_DISABLED>;
desc->depth <https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/depth>++;
irq_disable
<https://elixir.bootlin.com/linux/v7.2-rc1/C/ident/irq_disable>(desc) a
stuck interrupt source would catch here.


>> nobody cared" detection, so a stuck interrupt source would never be
>> caught.
>>
>> Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>> changlog in v2:
>> modify gitlog for Modify the incorrect Git commit message to match
>> the reason for the modification.
>> ---
>>   drivers/i2c/busses/i2c-k1.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
>> index c2d090f6ba80..487f23fde725 100644
>> --- a/drivers/i2c/busses/i2c-k1.c
>> +++ b/drivers/i2c/busses/i2c-k1.c
>> @@ -728,7 +728,7 @@ static irqreturn_t spacemit_i2c_irq_handler(int
>> irq, void *devid)
>>         status = readl(i2c->base + SPACEMIT_ISR);
>>       if (!status)
>> -        return IRQ_HANDLED;
>> +        return IRQ_NONE;
>>         i2c->status = status;
>>   
>
>

