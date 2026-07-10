Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C754A3DB330;
	Fri, 10 Jul 2026 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675132; cv=none; b=sgpGsRGB6C3Sl0pytkKacuxIqGRiLHq0XUwr58UNKCVqIGfcsgBlwuqAXHPBEueHPdaljRLIvDx9UluJra2cOd+h+yl6ezAiwDDGX6YVcbN9ZwgmMoaM/2678NJHRLFdpHzxWLi2u8r+5skIqwcN36S1D24xAP3oQPOeNn4X2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675132; c=relaxed/simple;
	bh=1Y5fSKwcvi4guzBFLEvP6gjifkMS7RboXBKrRfK2Skg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6y8Eu8XNBBMC1LZ/DkavIq1tPBxMEV+ETS+oppdxPG3JWt7MnSkjDs4rcCnj+k8Xmdj+aL38anrNgmbtTXr8cpoPxiLBI7uAWJCo3dDAcy/CLQTDgF6N0k70zKtymuWGid0xPB2LofmvU8L4sFzFHSkdNCBQrObdjU7vPyJqyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 59324fb67c4011f1aa26b74ffac11d73-20260710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:145b6373-83f6-4a8e-b0c1-ee32eda38774,IP:0,U
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
X-UUID: 59324fb67c4011f1aa26b74ffac11d73-20260710
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1856676913; Fri, 10 Jul 2026 17:18:44 +0800
Message-ID: <e453a825-4d73-4d35-a699-a495b0ca1058@kylinos.cn>
Date: Fri, 10 Jul 2026 17:18:41 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: spacemit: fix spurious IRQ handling returning
 IRQ_HANDLED
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev
References: <ef8b623f45d4e430721e46572c2598d882044aed.1783667603.git.xiaopei01@kylinos.cn>
 <ef8b623f45d4e430721e46572c2598d882044aed.1783667875.git.xiaopei01@kylinos.cn>
 <DJUQ3TZHM7OO.34ULEC76Z2BDY@linux.spacemit.com>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <DJUQ3TZHM7OO.34ULEC76Z2BDY@linux.spacemit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/7/10 15:46, Troy Mitchell 写道:
> On Fri Jul 10, 2026 at 12:21 AM PDT, Pei Xiao wrote:
>> When the interrupt status register reads zero, the handler should
>> return IRQ_NONE instead of IRQ_HANDLED. What the return value
>> actually feeds into is the spurious interrupt accounting in
>> note_interrupt(): falsely claiming IRQ_HANDLED defeats the "irq XX:
>> nobody cared" detection, so a stuck interrupt source would never be
>> caught.
>>
>> Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> The commit message now describes the actual mechanism correctly,
> thanks for reworking it:
>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>
> One process note, though: please don't repost new versions this
> quickly. v2 followed the review comments almost immediately, which
> means other reviewers who were still looking at v1 never got a
> chance to chime in before the thread moved on, and the discussion
> gets fragmented across versions.
Because I noticed a simple mistake right after sending v1
—I forgot to include the version number and changelog for v2—
so I thought that by fixing it without waiting for reviewers to point it
out, 
I could save reviewers' time and get the patch merged more quickly.
 I may have been wrong about that. Sorry.

Pei.
> Documentation/process/submitting-patches.rst ("Don't get
> discouraged - or impatient") asks submitters to wait a minimum of
> one week before reposting; the same courtesy applies to new
> versions while review is still ongoing. Collecting all the feedback
> on one version and then sending a single respin saves everyone
> time.
>
>                                 - Troy
>

