Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC554229B9;
	Thu,  9 Jul 2026 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600557; cv=none; b=fqjQ2iScl//s1iGuxxV/oqbuR/wt9UZhZ/UyPC0ipmLf4FNnmNnU1h5PcBWkCszhMzf4KTunFUg96GEzL77kzapc9o8zZFZVtYeqfagR+bSDaB1AqoZ9zyRpBi1fp7knffv6KyfqdWINQyf7KYN+5vHwRW62gj68kC3Lgp8lpDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600557; c=relaxed/simple;
	bh=Wppfbnj881WSgNJYSf89PmL0u3y+RW4UCa78fZI6H30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJW7xWoOkL0kHrKluY9xB9jD6L5tj9DU9WleqWBlWfFwPpzc1rAxxzem3AlazTaevNr+7Qv+kGXxRxnhf8dhg7pRdg1HSUK5AlxRIPq5z8VvdFBcWbIcktcx+NGNYpsE3EdNtFFEHMQPL56mjj7sYAOpAAvQF6DGWc0nTuL9lgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ma11lkQL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ma11lkQL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783600553;
	bh=Wppfbnj881WSgNJYSf89PmL0u3y+RW4UCa78fZI6H30=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ma11lkQLksFyB/jDWmVFChDw5KJqE7xRFNLDg3q1xg0mDwIG/uugMecMUb4puQOB6
	 SisVmPveMDSxB7kl1cZQygHkzwSCi7q0wALvQDH+T+oZ0KSApYzRp4ELe1EEvRr9Xj
	 biJ7oYeNkCyeFVTPkJRU02TGIIcYPJ/4zC9XXgZ/s9nMQ9oHpZnbyMl05xmplTMLyr
	 PWAfMTCiNU60g+jmAf4f/mB7Y4weKzH8jI2I5QCaWVk6281nKFVX6u6H9TtDaVcTc8
	 XaBtI9nI2xkpZlrlG3sORkTvZnHkK1i9BL6C/hplorzxK91MQNO97A0Ha/rqu6J78z
	 f296JdGm6V2gw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 71A6817E079B;
	Thu, 09 Jul 2026 14:35:53 +0200 (CEST)
Message-ID: <1b27eabe-1709-4345-b2ba-50b528761683@collabora.com>
Date: Thu, 9 Jul 2026 14:35:52 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: mediatek: fix WRRD for SoCs without auto_restart
 option
To: Roman Vivchar <rva333@protonmail.com>
Cc: Qii Wang <qii.wang@mediatek.com>, Andi Shyti <andi.shyti@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260624-6572-6595-i2c-v1-1-9155cebaae20@protonmail.com>
 <0eb85793-5995-4177-9b04-338246d6979e@collabora.com>
 <GOZtJ6Ys4Syt4VaGQyJvmYEIe6dx97flmTygat-nc_gMwsKVrDaDOQjP2ZbX1Qqwx5PYjWo6rJwo-8H32NQQAQi4Z7x6y9wpBNyYea9liZA=@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <GOZtJ6Ys4Syt4VaGQyJvmYEIe6dx97flmTygat-nc_gMwsKVrDaDOQjP2ZbX1Qqwx5PYjWo6rJwo-8H32NQQAQi4Z7x6y9wpBNyYea9liZA=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 14:12, Roman Vivchar wrote:
> Hi AngeloGioacchino,
> 
> On Thursday, July 9th, 2026 at 2:46 PM, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
> 
>> On 6/23/26 23:40, Roman Vivchar via B4 Relay wrote:
>>> From: Roman Vivchar <rva333@protonmail.com>
>>>
>>> MediaTek mt65xx family SoCs have no auto restart, however, they still
>>> support the WRRD mode in the hardware. Because auto_restart is set to 0,
>>> the WRRD mode will be never enabled, leading to read errors.
>>>
>>> Fix this by removing auto_restart check from the WRRD enable path.
>>>
>>
>> Are you sure that MT6577 and MT6589 do support WRRD?
> 
> Yes, I have checked their downstream kernels[1][2] and they both mention
> WRRD.
> 
> We also tested mt6589 (privately) and the i2c was working. To be fair,
> it had some other fixes, but at worst this patch is no-op.
> 
> mt6577 is a tough one... I don't think there's any recent kernel with
> it. I plan to make it work with upstream, but that's a TODO. Either way,
> vendor code has WRRD support.
> 
>> If you're not 100% sure, or you want to be careful (which I would, in this case),
>> please add a `unsigned char wrrd_supported:1` to struct mtk_i2c_compatible, set
>> it to `1` on *all* of the SoCs that support auto_restart (as that's effectively
>> a different feature - it just happens that all the ones supporting this also do
>> support that, up until today), and add a new one for your MT6572, declaring no
>> auto_restart but wrrd_supported.
>>
>> That would make me sure that you're not breaking anything, and would guarantee
>> you a R-b.
>>
> 
> As far as I know, there's no SoC without both auto restart and WRRD.
> Adding wrrd_supported that always equals to true sounds redundant to
> me.

I have just verified on datasheets.
You're right, both MT6577 and MT6589 do support WRRD, hence your change is good.

With this commit, you're fixing a fix... Leilk from MediaTek was indeed wrong, as
in the commit description he says "the old IC does not support I2C_MASTER_WRRD",
and that's *very* wrong.

I can see though what he did, as he inadvertently also fixed the WRRD algo because
the fix was to increment msgs by 2 instead of 1 when op==WRRD.


Please, resend your commit as a v2, and add:

Fixes: b49218365280 ("i2c: mediatek: fix potential incorrect use of I2C_MASTER_WRRD")

and also
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers!

> 
> [1]: https://github.com/GoldRenard/lenovo_A390_mt6577_uboot_kernel/blob/38ea59263984e26c0dd8e5891b22a35f61e60ed5/mediatek/platform/mt6577/kernel/drivers/i2c/i2c.c#L963-L975
> [2]: https://github.com/bq/aquaris-5/blob/bc1d0d0e35c969670e2d869001be944ad0c9c5e5/mediatek/platform/mt6589/kernel/drivers/i2c/i2c.c#L728
> 
> Best regards,
> Roman
