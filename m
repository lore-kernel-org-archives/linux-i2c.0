Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969B7224234;
	Tue, 28 Jul 2026 03:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209390; cv=none; b=EqRm4U8WzWbnYKKv1eJpfx21NiyhLImuB5OKYHPmb0RLHusXo3AnO73uMim/zgbobgvr+mPAfFo/2IKfNl7PObiulEJ3lBK6PvaeC23JDmBepv1qoYk9R3hwlL0GuJn8BqwJXoSznlxB4xYR5XYq/ly6gDWcQrVhfQIMrCG4rx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209390; c=relaxed/simple;
	bh=5Vlosz0bqS0SgkPJqOUlF2YX68S8aYCbz+TUKqq3SV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btOGG95xzLjIroJytHAmIHUBDiNf8BdixqE/GuROjN+wAr1JXEjf8GDARD47LAyCDDw9UO0QID1FXwf0jooQDqUu8ybjN3pN9u/DrVOBM8/Wlmib7iVuxhFJd5tEh6fuexUGrbQL47QAs4F3yB3BjvDjw6HH5iz04kdQfkt86ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=GTkWLCR4; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="GTkWLCR4"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31E471189C8;
	Tue, 28 Jul 2026 05:29:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785209382;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=pdKoxXbF/nFF5vgavbEMb9NhmAnaYq7CksgwlMxSPXM=;
	b=GTkWLCR4nLoJfmF78vKBwt5yfljUQ3pSbQkrM/okCRNBN8mQtN1Nm/opRGGkTcq8kHh/Jl
	WKs/2W4Z6tN7Ww2zzUjRLBjqXjBh+j6wUBBSpKRjzQDJ4w8wGBbkSh7JyXt7d/E0c7dMMD
	UbLNCWxgs7DqekEeRlopex3WYGbKpBqGTgRewIIDYO7PkxaMcp+dI8Dvbm8yBEiQ43XHll
	M5/a0RpweTsKAAkPyMtpQRHzLZVoXggT8wx4Ds63r6xLPePjlx/bebeMDlRD6ehPP15nUB
	dUbJNBA0z78IObkPpvhHQXfJ9OIA5xdNtRF79Cs9jHG4GQ1uIlVUzJnvOiBLkw==
Message-ID: <6b7f6317-97bf-420a-84b1-6338ad236d13@nabladev.com>
Date: Mon, 27 Jul 2026 15:24:11 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAMRc=Mfm1R+CNt5nRY=A29TqTxHFZCHzZsWYd-WpE1yGrwt3Vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 7/27/26 3:10 PM, Bartosz Golaszewski wrote:

Hello Bartosz,

>>> No, this is literally how you do it. If you enable HAVE_SHARED_GPIOs and
>>> DEBUG_GPIO, you should see it being picked up in the kernel log.
>> Ah, HAVE_SHARED_GPIOS is what I did not have enabled. Is there any
>> reason why this is not enabled by default ?
>>
> 
> It will be. I'm doing it gradually. It's enabled for Qualcomm platforms by
> default and - by extension - in arm64 defconfig. I plan to enable it for other
> platforms and architectures too, I just don't want to rush it. Enabling it for
> arm64 defconfig had caused quite a lot of regressions a few months ago so I
> prefer to be careful.
> 
> What platform are you running this on?
NXP i.MX8M Nano (arm64)
