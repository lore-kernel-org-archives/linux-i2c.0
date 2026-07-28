Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9F380FC9;
	Wed, 29 Jul 2026 05:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301405; cv=none; b=jEbGETHVe7PL3fPB3VWNu2CmsI+euniE2DED8YMQR5L09Ncb8i7DWinhEd5tOA91xrVyT8K8hFe/52l3/GQm+SHpDtcy2RHKTRV+Y2ofgyfKC8xw4Go59LUy7MQrNPxMSX/5YToycJmOSLUl/mtfJBB49RNoJ7olrI3PWsFn5R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301405; c=relaxed/simple;
	bh=bD6VP+sVAr4du614X0QPDOeoATQKRkvnWGlWpbuRQD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oyfr7Bs2GAl+g13xw4zJz3AThkciXidIckKYUl8SeIQR7/n4c4yeuIhJojF91Xf2rQPXxJk0ez//4GMp4l3/IhxcrATgwxHuyAgFrv1gNrCQC9PR6TVY7xTrzhRr8cq4eNeLIXna1XoZCBSISuj5WtjBp4FBrblfOY0VDflWOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=TIi3cogr; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="TIi3cogr"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 369A211B56D;
	Wed, 29 Jul 2026 07:03:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785301390;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=aoBdzD7ZGM/ZAoh9BSTUbAg/eppEtmMYRivX71EhxZo=;
	b=TIi3cogrKU9LX15vhgHSOM5VuDKYR2p+ixlqGG/eU9W1583VXJS1M7g6Hf07vyJYGVJFtE
	iNYJWPFEeb2vR4cmvvGi3p4PKhDhxipQFV5hCbfKLtBr1bq7D7F8v7cifOA6cRcyROcSFx
	IBjQjiTVy6SRIY2L4XfO97vlcdOZMa6AiQVS0kW1kH8MRaeIw7dKMnZeTbWZe8X7fbx3GX
	oIBc5gkHka4LX4uK+T4peTMxxgj/zcFMp/qeTDkTrscOH978qsc/GXIPWrxqDedgjuGtx2
	Wc/W0d5xSPJDZ8k24oTTGHDCDwuM7XEQWtlLEuVIMiEY7gjRJQ22R5+NYaDgvQ==
Message-ID: <3ae60c13-f56b-432d-81b0-0c2b9788945f@nabladev.com>
Date: Tue, 28 Jul 2026 13:21:49 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: core: Mark nWP GPIO as non-exclusive
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivas Kandagatla <srini@kernel.org>, linux-kernel@vger.kernel.org
References: <20260511163518.51104-1-marex@nabladev.com>
 <CAMRc=Mdqxen+8rd-5yR+_cvtFkM=qeAG78uqG+ZHWR3CQsa1Ow@mail.gmail.com>
 <46051025-8b50-47de-839a-a901615b8227@nabladev.com>
 <CAMRc=MfgsjFO9R3bzSQiWmA6tvHGWcprhWMLSDTMML60-NfhCg@mail.gmail.com>
 <8a5838f6-8582-4ce2-b80d-cd05bb984a4f@nabladev.com>
 <CAMRc=Mfm1R+CNt5nRY=A29TqTxHFZCHzZsWYd-WpE1yGrwt3Vw@mail.gmail.com>
 <6b7f6317-97bf-420a-84b1-6338ad236d13@nabladev.com>
 <CAMRc=MfJz1ma5efcxm7_pf051FkxtgGN6EY6kJFY3350dHtjRQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAMRc=MfJz1ma5efcxm7_pf051FkxtgGN6EY6kJFY3350dHtjRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 7/28/26 10:32 AM, Bartosz Golaszewski wrote:

Hello Bartosz,

>>> It will be. I'm doing it gradually. It's enabled for Qualcomm platforms by
>>> default and - by extension - in arm64 defconfig. I plan to enable it for other
>>> platforms and architectures too, I just don't want to rush it. Enabling it for
>>> arm64 defconfig had caused quite a lot of regressions a few months ago so I
>>> prefer to be careful.
>>>
>>> What platform are you running this on?
>> NXP i.MX8M Nano (arm64)
>>
> 
> Just consider sending the following once you can make this work for you?
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index d2acfac730037..a02b37c752887 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -281,6 +281,7 @@ config ARCH_MXC
>   	select PM_GENERIC_DOMAINS
>   	select SOC_BUS
>   	select TIMER_IMX_SYS_CTR
> +	select HAVE_SHARED_GPIOS
>   	help
>   	  This enables support for the ARMv8 based SoCs in the
>   	  NXP i.MX family.
Will do (sorted alphabetically).

Thank you !
