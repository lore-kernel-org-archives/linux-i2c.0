Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB683F660E
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785227583; cv=none; b=PNEcOvIzujF9Pob7pii9A5q/sIGlYdwid7m5jV4be5PpPnMhLCmOF9nU2U8UDHPSWy8iJM+T9BwzfL8BNOki39y07I9ZhrJ2X3xr3niaoQ91dtaJqvaNQLKFQODWKVfeowEDvVwFGJFz8gvvt+GAIttwOxmIJI+fkoJp9l0n3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785227583; c=relaxed/simple;
	bh=sSrS7WKeRXOkk6/tjHzPzHLzPxTO5IjaD/xLOAFZ2to=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hedYtd9gBjsKjc4oVsfv5h1MpVDH01Di4JQIGaOjKZJgsqdsKXsjAJoV0Dw6xIo6pKGaZ1syG9VoUgxcoA7Xis8hUeBw+ng2+wuxoPTmosM7SxYhUOcoPXYK9VQvuPLgzeZCAc/CETn46BzfAalCAamF1nN5uHk91Gg1n/y9epw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U54jyQxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U54jyQxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909E51F000E9
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 08:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785227575;
	bh=hFeUlNnmI/tjgBenS9p+P2H+Y40iYbX7BhHpOnXtIIg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=U54jyQxCh/Gt6nJfUVMrhEcpMMDrUZEtllDpVWJ2qurZaqGdHAavol67UJYPEuZKf
	 I1fSDZcoJ3OCxN1xISQzAHLQNMXxP1Zc1Fz4SNMtCk1gYsbw7MiHfPWbdgXgTAwlkr
	 wjor7SfXH9QKJjAGE331VPm6YCk4yhQhejEg16O6nasE9hCccgqkVHeQB9aBC0h7Eb
	 9+AXE+Dr10hV4tUjPFgLz6Qlg/ZgmqUZHeOHlzieIj/g2c4GGJDA8ziifY5egq7xIz
	 GSEvWoUB1ldh0C5y1wFJrcPkHXOuX8AHLaEqc2E8KTcMKcgRTzLH+6FAm0QSY5g5aQ
	 UyFidxWYqwiuQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b00d083818so616179e87.1
        for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 01:32:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw3nc1mMoT98G+ANMy776eQd5dc4qRBI/gdaIfQkOU+VeTJzCVT
	laXnIq3+UNCcG38S+5cm/mKOJwRGwMFXpusEF6E9+DQMs+8JY3fECJkqN8DYsgXN06YlIRYCsC6
	5+BJ1Y5PyYCF7+A1NJMq7VhgpYfGUmxAFX6HIm7dVTw==
X-Received: by 2002:a05:6512:1351:b0:5b2:b02c:e8ce with SMTP id
 2adb3069b0e04-5b2d025e1bcmr237773e87.30.1785227574320; Tue, 28 Jul 2026
 01:32:54 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 01:32:52 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 01:32:52 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <6b7f6317-97bf-420a-84b1-6338ad236d13@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511163518.51104-1-marex@nabladev.com> <CAMRc=Mdqxen+8rd-5yR+_cvtFkM=qeAG78uqG+ZHWR3CQsa1Ow@mail.gmail.com>
 <46051025-8b50-47de-839a-a901615b8227@nabladev.com> <CAMRc=MfgsjFO9R3bzSQiWmA6tvHGWcprhWMLSDTMML60-NfhCg@mail.gmail.com>
 <8a5838f6-8582-4ce2-b80d-cd05bb984a4f@nabladev.com> <CAMRc=Mfm1R+CNt5nRY=A29TqTxHFZCHzZsWYd-WpE1yGrwt3Vw@mail.gmail.com>
 <6b7f6317-97bf-420a-84b1-6338ad236d13@nabladev.com>
Date: Tue, 28 Jul 2026 01:32:52 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfJz1ma5efcxm7_pf051FkxtgGN6EY6kJFY3350dHtjRQ@mail.gmail.com>
X-Gm-Features: AUfX_myR2Gx5wKcH9mLWEnkk32RT-BDJJNjSkfCmsXHQJCa5S1ZiJZBGlOBi--I
Message-ID: <CAMRc=MfJz1ma5efcxm7_pf051FkxtgGN6EY6kJFY3350dHtjRQ@mail.gmail.com>
Subject: Re: [PATCH] nvmem: core: Mark nWP GPIO as non-exclusive
To: Marek Vasut <marex@nabladev.com>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla <srini@kernel.org>, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jul 2026 15:24:11 +0200, Marek Vasut <marex@nabladev.com> said:
> On 7/27/26 3:10 PM, Bartosz Golaszewski wrote:
>
> Hello Bartosz,
>
>>>> No, this is literally how you do it. If you enable HAVE_SHARED_GPIOs and
>>>> DEBUG_GPIO, you should see it being picked up in the kernel log.
>>> Ah, HAVE_SHARED_GPIOS is what I did not have enabled. Is there any
>>> reason why this is not enabled by default ?
>>>
>>
>> It will be. I'm doing it gradually. It's enabled for Qualcomm platforms by
>> default and - by extension - in arm64 defconfig. I plan to enable it for other
>> platforms and architectures too, I just don't want to rush it. Enabling it for
>> arm64 defconfig had caused quite a lot of regressions a few months ago so I
>> prefer to be careful.
>>
>> What platform are you running this on?
> NXP i.MX8M Nano (arm64)
>

Just consider sending the following once you can make this work for you?

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d2acfac730037..a02b37c752887 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -281,6 +281,7 @@ config ARCH_MXC
 	select PM_GENERIC_DOMAINS
 	select SOC_BUS
 	select TIMER_IMX_SYS_CTR
+	select HAVE_SHARED_GPIOS
 	help
 	  This enables support for the ARMv8 based SoCs in the
 	  NXP i.MX family.


Thanks,
Bartosz
