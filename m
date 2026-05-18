Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC102D0605;
	Tue, 19 May 2026 03:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779163187; cv=none; b=IzO/zbMs8qByExcmOw426Se+3PCva6QPlURPC1lVoDKQAYRJlVGzkzNnzzeXajaYG/05CKUc/R3th23+B91Q8Hi6Bc6NCmD8FSicznN9oqaaN73n7ykXn7D2LK3IW1hGIbsXMXtSo/Nf3wqKN4WAB4KJ4GIVvfv4q4DhyC7nenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779163187; c=relaxed/simple;
	bh=0jbcHV23EDMekcl9xBCbod42hECqcDlD1LifYufLCuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fL8aIOVHEOmifLfIrR/y47+dwH7Il4QDiAwaWFvU5eWwZT06ua/LdfqBzoYCupyspSYHqEK/FDkLaeHBFuQd0ZpO5e4EZ+zhZyjx2Osn/7vPARjyHvVCoxNisITTkfv/dG63GelM98rhD7QrtH60uj6hE8gCFph2KlpBHizPYo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=UI6hLR9r; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="UI6hLR9r"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1D9D114D57;
	Tue, 19 May 2026 05:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779163178;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=j0GXd8MRvGlnwGU93Yoi54Bqyc77kEwE8txX6oiXTe8=;
	b=UI6hLR9rBP/+3JBeblcyyOzOw/26DAaf22/WP3c/kf6o2Lj7Ti5H8R6auP3LhRIEjk/3cG
	dcTC5mZaWB4nxahIX4oDo5CoWLrQM/yROtVpDy5yxOVpbwJDt7p42hUguYN51WD3wnEhlv
	lGlN3N/BYmFVt8SA2NOIhEQcKYuXGO+DYuIDzHyKH/GTXtCT8FOMRvIU183UpNs3mN4K2e
	AYtLbdUAxvEqUw5zhz/nEreqConVtCMWQurz/HgN59k40YVX7z1Jtz3GmHEGwVUSInQlBK
	o4D56k41EYHeqbfdWUhY/JHe5FxeqZoFRnChE41tXuIXwuHGUJFA7kxR004wrA==
Message-ID: <49b658d0-6a03-44a0-ae57-1ccad8094486@nabladev.com>
Date: Mon, 18 May 2026 21:22:35 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAMRc=Mdqxen+8rd-5yR+_cvtFkM=qeAG78uqG+ZHWR3CQsa1Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 5/12/26 12:04 PM, Bartosz Golaszewski wrote:
> On Mon, May 11, 2026 at 6:35 PM Marek Vasut <marex@nabladev.com> wrote:
>>
>> Mark the nWP GPIO as non-exclusive, because there is hardware in the
>> field which has multiple AT24 EEPROMs with nWP GPIO line tied to a
>> single GPIO. This allows such hardware to be described in DT and the
>> nWP GPIO operated via NVMEM force_ro sysfs attribute.
>>
>> Note that GPIOD_FLAGS_BIT_NONEXCLUSIVE is a deprecated flag and should
>> not be used, but thus far there seems to be no replacement.
>>
> 
> There is a replacement now. It lives under
> drivers/gpio/gpiolib-shared.c and drivers/gpio/gpio-shared-proxy.c.
> Though the voting mechanism I implemented is hard-coded to drive the
> line high if there's at least one consumer sharing the line that votes
> high. I'm now thinking that this may be too rigid as yesterday, within
> two hours I had two submissions wanting to do it the other way around
> - drive the line low if there's at least one consumer that wants it
> low.
> 
> I'll try to modify the gpio-shared-proxy driver to take into account
> the value set when the line is first requested and treat it as the
> "default" in the voting mechanism. IOW: when the first user requests
> it out-high, we'll drive it low on the first user that votes for low
> and drive it high again when the last user drivers it high. This
> should work for both the Qualcomm shared GPIOs for audio use-cases and
> the WP pin here as well as the SCL recovery shared GPIO we have in
> I2C.
Shouldn't the polarity inversion be handled by DT GPIO_ACTIVE_* flags 
instead ?
