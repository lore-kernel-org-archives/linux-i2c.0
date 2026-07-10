Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B45199949;
	Fri, 10 Jul 2026 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783645869; cv=none; b=VlHZ9dDlYrt8ih2SnLV1nrswMWshJ9Ad1zF0KCyGbjtzNC8JC7p/Kb6OQkuUKsvvEGOaUbPUEYoHy8Y6pumFgPKRFiuzXIDjQ20aFkFxiLkYjZrZdpjlU+cIF/eSzgITOm+2OhSIa82scKhlSHs1OsLls7A3K9HSo1uo9dCDI2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783645869; c=relaxed/simple;
	bh=JjimjXLz0geanlqiGV0T5dHdjg1zzxc/ft8xXzbcsg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L+sSZwS4rzFXfP/915UD1Zeak0nXR6+jJkM5t6XsAJ1N920FKbXZNxsNUTIXYYzgk6obR5tM24ua8BS+vzdJpQw+Pc3tHX1nU/aiEkgZPEBXkFjed+WxSO0JZapNQrPimOO7hEspJaC7j8BkuU1JzBa5XNJ/jIRSYKA/ShpmjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 35ec4dac7bfc11f1aa26b74ffac11d73-20260710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:71b5238d-519d-42c1-96c0-3c245c376d54,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:1237003babe3a477118e7027bc06823f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 35ec4dac7bfc11f1aa26b74ffac11d73-20260710
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1339851726; Fri, 10 Jul 2026 09:10:59 +0800
Message-ID: <53a8635f-3215-40eb-b48f-f46df0e6cf1c@kylinos.cn>
Date: Fri, 10 Jul 2026 09:10:56 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: spacemit: fix spurious IRQ handling returning
 IRQ_HANDLED
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>, andi.shyti@kernel.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org
References: <aaba8ba228a99f580050004c5b7e262d855de44c.1783590752.git.xiaopei01@kylinos.cn>
 <1783645601561936.18899.seg@mailgw.kylinos.cn>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <1783645601561936.18899.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/7/9 18:16, Troy Mitchell 写道:
> On Thu Jul 9, 2026 at 2:54 AM PDT, Pei Xiao wrote:
>> When the interrupt status register reads zero (no interrupt pending
>> from this device), the handler should return IRQ_NONE. Returning
>> IRQ_HANDLED incorrectly claims the interrupt was serviced, which can
>> prevent other devices sharing the same IRQ line from receiving their
>> interrupts.
>>
>> Fix this by returning IRQ_NONE instead of IRQ_HANDLED when the
>> status register is zero.
> The change goes in the right direction, but the rationale in the
> commit message doesn't hold, and I think the check itself can be
> improved.
>
> This driver requests its IRQ without IRQF_SHARED (see
> spacemit_i2c_probe(), which passes only IRQF_NO_SUSPEND), so there
> are no "other devices sharing the same IRQ line" to begin with.
> Even on a genuinely shared line, the kernel invokes every handler
> registered on the line regardless of what previous handlers return,
> so IRQ_HANDLED cannot prevent other handlers from running.
Thanks for pointing out！
>
> What the return value actually feeds into is the spurious interrupt
> accounting in note_interrupt(): falsely claiming IRQ_HANDLED defeats
> the "irq XX: nobody cared" detection, so a stuck interrupt source
> would never be caught. That applies to dedicated lines as well, and
> is the real justification for this change.
>
> Could you rework the check and the commit message and send a v2?
yes, I will check again and send a v2.

Thanks! 
Pei.
>                                   - Troy

