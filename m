Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB971408018
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157838; cv=none; b=lUcilAM5eav+ClaMiM5mThg8umIODpNXXO2ejxAEpohd+y2Ngc8dqCh/AIkO5hWM7nvVzkiLfSwa6jRo45gWlg4rN/dLFvudtTbCODT0olBpLfIhymgIJfHCSSJzkDQl7mJHklvXLDWgjPobFMomTn36JeA0HgzHcGjsuJ97A2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157838; c=relaxed/simple;
	bh=taYqXJ0itQ9Mxk/QrTo9EWP8/s0FDZKASNndl33CfPM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALjSSGuwp/ja7J0Tv1XivaeAORzWDiHfDMTngCHWJccr8wPup9zJFciSDVDN1zmcdi+1gP3bwIDQHsb9+zGjfLMRG8aFrpKveKa1UfWTPh5GFhhIvD5lj+OPVNQpaPVwgVEHPM7jibNFLXdgaid5DQUpISytt7p2Edi0EIkd9Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdhcNyXP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdhcNyXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC601F00A3E
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 13:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785157837;
	bh=sECbKSCQRMXxH3Z7bRIUP7zfW7FGJpE+ue9ODAkLRzg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=LdhcNyXP+paz9PqO5m4QPlqeWkVXXwJVUFZ8NZT69z+jLG1x+M4uTOG6htvcXaTvn
	 SiAKB6MSDZScG4WnOZkUPqbIOpWTwNF3EEJRlktH2zzbE+S3KXTMPL+SdAzYJBu5EJ
	 x7RPzTmZCaIjAN8H4OoPQ4MPV6ZIyTqqpP9nJKOaZbfvNUXfCcQAnsHPhs+fxRh9/9
	 m4ioEif/88mOWTzF3N6miTxX2yYFBaeGwl/1IeFtDWcnzIKkl+kvv7QJ4FwPiGZNzk
	 CEt7cdaGcG1yap8dmYvOJjiJ5Drda8C2JNIk2j+kWwbJ86KRffW4DpvCI73rWv5lEM
	 ZrRo129eBz1YQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so1848699e87.0
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 06:10:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpWJXd8WPr/4sf/ZCG5Y8aRSC49dVeKohjvOZUMz59BOBgIGRq+skAmImp8D28RDojddVDj/yXpZjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz800stdLQoAAxg8hPEw4h77iNzAbM/NVasAjL3SZ0ZNvB3CNaX
	bj5uOsY4F9UhEwnCLM/bV21K+czVeTvPSPB7696gYMHseFjpXOIKbx0otZJXy3wDX/ptq3I8MzQ
	6vej3Q8eCpP/KOeblIlkUM1b3mey8ydcmO51dVXWADw==
X-Received: by 2002:a05:6512:3d8d:b0:5b0:1aa5:b869 with SMTP id
 2adb3069b0e04-5b2c1b1391bmr1610732e87.25.1785157836315; Mon, 27 Jul 2026
 06:10:36 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 06:10:35 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 06:10:35 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <8a5838f6-8582-4ce2-b80d-cd05bb984a4f@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511163518.51104-1-marex@nabladev.com> <CAMRc=Mdqxen+8rd-5yR+_cvtFkM=qeAG78uqG+ZHWR3CQsa1Ow@mail.gmail.com>
 <46051025-8b50-47de-839a-a901615b8227@nabladev.com> <CAMRc=MfgsjFO9R3bzSQiWmA6tvHGWcprhWMLSDTMML60-NfhCg@mail.gmail.com>
 <8a5838f6-8582-4ce2-b80d-cd05bb984a4f@nabladev.com>
Date: Mon, 27 Jul 2026 06:10:35 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mfm1R+CNt5nRY=A29TqTxHFZCHzZsWYd-WpE1yGrwt3Vw@mail.gmail.com>
X-Gm-Features: AUfX_mwkPvBZh2JcnFzOW8TV_6rxIUkVRPsJ7Kei6a5DJ7YMhYcfSd8SinQPiFs
Message-ID: <CAMRc=Mfm1R+CNt5nRY=A29TqTxHFZCHzZsWYd-WpE1yGrwt3Vw@mail.gmail.com>
Subject: Re: [PATCH] nvmem: core: Mark nWP GPIO as non-exclusive
To: Marek Vasut <marex@nabladev.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Srinivas Kandagatla <srini@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Jul 2026 14:51:08 +0200, Marek Vasut <marex@nabladev.com> said:
> On 7/24/26 9:30 AM, Bartosz Golaszewski wrote:
>
> Hello Bartosz,
>
>>> I tried to look into the gpio-shared* , but I couldn't figure out how to
>>> describe it in DT. Do you have any examples?
>>>
>>> Take for example this DT snippet:
>>>
>>> gpio: gpio-controller { ... };
>>>
>>> i2c {
>>>     eeprom@0 {
>>>       wp-gpios = <&gpio 0 0>;
>>>       ...
>>>     };
>>>
>>>     eeprom@1 {
>>>       wp-gpios = <&gpio 0 0>;
>>>       ...
>>>     };
>>> };
>>>
>>> I assume there has to be some new glue node between the eeproms and the
>>> GPIO controller somewhere ?
>>>
>>> Thank you for your help !
>>>
>>
>> No, this is literally how you do it. If you enable HAVE_SHARED_GPIOs and
>> DEBUG_GPIO, you should see it being picked up in the kernel log.
> Ah, HAVE_SHARED_GPIOS is what I did not have enabled. Is there any
> reason why this is not enabled by default ?
>

It will be. I'm doing it gradually. It's enabled for Qualcomm platforms by
default and - by extension - in arm64 defconfig. I plan to enable it for other
platforms and architectures too, I just don't want to rush it. Enabling it for
arm64 defconfig had caused quite a lot of regressions a few months ago so I
prefer to be careful.

What platform are you running this on?

Bart
