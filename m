Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D439D6DA;
	Mon,  6 Apr 2026 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775512540; cv=none; b=F47JJ7yn4HnlSUi2lEQe+FVNwJ0zTDOVyMCXaOD6NySuHYyo2cNHvNaQCNqpXRA3pkr3BNNPkrot40fHJJ+IA+Id/tVB9AuFsrk6cNxoGlSuAX99zt5VaPYCclFEQwxf00lOY8fnrhl+TyvUeatn5+/KToEsxtUAcypZXMTshZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775512540; c=relaxed/simple;
	bh=DQ3TVMXfka0v3/HQEjsDoWEkg45LWDYRwo8w4T6N8IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=T4YieuPZVpv+tP/5mUouG/w9IOKFNzCtk3cTfIqE/RRz7/p9mHM1kDvfSjBxAOZwCWYAGiT5vVwbXnd6nwNvisz46NU9Wp5Hf0IyueEgZ1COo+OjqJ898cy6c+QjrKAZLBYhD19NMNPtkz+XbQ5pQpCgWyVoB02vwalo0TYUoGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr; spf=pass smtp.mailfrom=online.fr; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.fr
Received: from [10.0.0.2] (unknown [82.65.243.93])
	(Authenticated sender: legoll@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id D19895FFA3;
	Mon,  6 Apr 2026 23:55:25 +0200 (CEST)
Message-ID: <bbd2e57f-3107-46cc-a8a7-ee717e577d6e@online.fr>
Date: Mon, 6 Apr 2026 23:55:25 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v5] mfd: simple-mfd-i2c: add a reboot cell for the
 SpacemiT P1 chip
To: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
 Yixun Lan <dlan@kernel.org>, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev
References: <20260401165437.1048786-3-aurelien@aurel32.net>
 <b7e182f9-8bd8-40e6-acaa-dc6e556f2a53@online.fr>
 <adPUTRAlzGBs2wQG@aurel32.net>
Content-Language: en-US
From: Vincent Legoll <legoll@online.fr>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Andi Shyti <andi.shyti@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Aurelien Jarno <aurelien@aurel32.net>
In-Reply-To: <adPUTRAlzGBs2wQG@aurel32.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Aurelien,

On 4/6/26 17:42, Aurelien Jarno wrote:
> On 2026-04-06 11:46, Vincent Legoll wrote:
>> Tell me if there's a new iteration to test, and/or if you want me testing it
>> in a different way.
> Yes, as written in the original mail, this patchset depends on PIO
> support in the spacemit I2C driver:
> https://lore.kernel.org/lkml/20260207-b4-k3-i2c-pio-v7-2-626942d94d91@linux.spacemit.com/
>
> Without it, you might get this warning message and reboot is not 100%
> reliable. I still believe it's better than no reboot support at all.


OK, I tested a new stack: next-20260406, PIO patchset, reset patchset & 
USB patchset:


$ git log --oneline
5030369b32c4 (HEAD -> opirv2-pio-reset-usb) riscv: dts: spacemit: Enable 
USB3.0/PCIe on OrangePi RV2
73274ce37441 riscv: dts: spacemit: Define the P1 PMIC regulators for 
OrangePi RV2
cda12b8bdbfe riscv: dts: spacemit: Enable i2c8 adapter for OrangePi RV2
68ce409351c6 (opirv2-pio-reset) mfd: simple-mfd-i2c: add a reboot cell 
for the SpacemiT P1 chip
245e0b8e8a91 i2c: spacemit: introduce pio for k1
a588d756621d i2c: spacemit: move i2c_xfer_msg()
816f193dd0d9 (tag: next-20260406, next/master, next/HEAD) Add linux-next 
specific files for 20260406

This boots and reset properly without the previous WARN.

So if any of those those series need added T-Bs, then here's mine:

Tested-by: Vincent Legoll<legoll@online.fr> # OrangePi-RV2

I also believe this is better than nothing: reboot + (harmless) WARN instead of hang.

PS: I added recipients for the PIO patchset as CC here, for the T-B, hope this is not bothering.

Thanks


