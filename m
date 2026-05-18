Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F44480952
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114426; cv=none; b=Ql3yH2F53A+ZTi5G4ZK40j7K1oozxsHJqpuzzdvD/J9JgnthHkZtxL6ZVeAM7NjOgu52M8J/PxsNJMQNZwaIFBHLUgCWMi9EIN9tLLdCTbmIxUZWlxMvDyT3/RFbLzRe8RWaVznO3FrV/CazwMax4qlteT0DIghcvm7M2F9bg5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114426; c=relaxed/simple;
	bh=QFKCRBkw6wyk32g7EcU/VvBElanIT53QeKHnqAjjJ1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOaQS1Xcrkw6w12fPHRrVlwQBlw5CxhindmdmkN+Lv22HU+EgJcgKkD48pOzBUDyJlTlfFmBxOoh5xMY9SCqkq35tOEXfbNO+zWFp5DsFk1BxgS7sYw7TqioXJUzx6HHi5dijkLcKLSI96saACdnkLhAShNLS2Gvpyul+XN/PWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urjjru7W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urjjru7W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025BFC2BCF7
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 14:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779114426;
	bh=QFKCRBkw6wyk32g7EcU/VvBElanIT53QeKHnqAjjJ1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=urjjru7WKCDeb2un5oJGa33j99Vlde+4JibogJyGcZ5flAXSmjzJL6S9yxNe/EFpm
	 5ninws2FqUgdIa/3Tr25KM/SSbcJym4ROiMAUeHXWhH7zLxdmRgYRTsSiFFAxI+3fr
	 xXU/Cbl9QpA4eV/Ih8UyKjPlTcTDL7i6iNAJliBAtIgtPyGETnyGi7NCzA1MnBZuTH
	 RQmzsXDQwAR3nwKitOfBW7we0G99m9mpUytTtz6+vquKckFbm9bo+BqZrYJYUxgloT
	 T2mQ9yfXRyB2okW+GKcdemzUsc9nEarK55uRGcVeMi62eNArEXLCQrI/wZgih9s+AH
	 kACre4472yyFA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3922b35e69cso21983661fa.0
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 07:27:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+SmhmHN9QtjoVlIOyyKdffzWuyfeXmkLytRwVkxKtutCZoRrm/k/odoF7j4Li/the+8qP4gw7e5GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLlO4U4RuoT/4Yw2Vi3Z2EaSEpYCKvCC+eMnzE37PnZ8Oe0JtO
	mw0c6bm7vUO+ydIhi09/xUnvLIvd8ebQ1lRX5bVCCXLCNClWK81SXsuK1M9BkOJaH0fCU9LwETC
	LdITSKBNIQI+cdKRaakSvQbUdflntzbsPwE5wOXPWLw==
X-Received: by 2002:a2e:a995:0:b0:394:184:f7a7 with SMTP id
 38308e7fff4ca-39561ae222dmr48221411fa.6.1779114424599; Mon, 18 May 2026
 07:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518122814.8975-1-hardikprakash.official@gmail.com>
 <d57dd297-6be1-43a9-a38d-e40c8949e23a@amd.com> <CANTFpSWGC7GsAY-3UvPtBZzqjNek-T5haiDb59QYRoRgwuQf1w@mail.gmail.com>
 <7d0f0cf9-1936-4cf6-a425-228a37f83137@amd.com> <CAMRc=MdS_BVKb=FQLhky=8dpghBSoHeBhUk0LM5hROFxmJeyGQ@mail.gmail.com>
 <9d5da93e-bbe0-4359-9f17-e3c6b3a5cb34@amd.com> <CAMRc=MfT_WVMxPnYZW=mg52PHew0O4VQMGFrfo6G9vxZDDoArw@mail.gmail.com>
 <CANTFpSUX5rYhuTQH3dTTvzW+_yhW8Gs0U=A1t_8LDzKz4dzzAw@mail.gmail.com>
In-Reply-To: <CANTFpSUX5rYhuTQH3dTTvzW+_yhW8Gs0U=A1t_8LDzKz4dzzAw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 18 May 2026 16:26:52 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mewi_cbvpZOgYy3RL2rxuekRhVXD8BeCFUuNSKipTYA9g@mail.gmail.com>
X-Gm-Features: AVHnY4JRGrxRfCAxcwWRlWUHU9yFELT3JlosqIIXUMuAWvUX4l5rrYsRQod8Grg
Message-ID: <CAMRc=Mewi_cbvpZOgYy3RL2rxuekRhVXD8BeCFUuNSKipTYA9g@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, wsa@kernel.org, andriy.shevchenko@intel.com, 
	basavaraj.natikar@amd.com, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 4:23=E2=80=AFPM Hardik Prakash
<hardikprakash.official@gmail.com> wrote:
>
> On Mon, May 18, 2026 at 19:35, Bartosz Golaszewski wrote:
> > What is blocking the pinctrl driver from probing? Does it return
> > -EPROBE_DEFER for some reason? Pin control core is ready at
> > core_initcall() so it should work in theory.
>
> On Mon, May 18, 2026 at 19:16, Mario Limonciello wrote:
> > Please try arch_initcall instead.
>
> Tested arch_initcall + patch 1. GPIO 157 now fires at 0.255s (earlier
> than any previous boot), but arbitration errors still occur at 2.309s:
>
>   subsys_initcall + patch 1:   GPIO 157 at ~0.310s, arbitration errors
>   arch_initcall + patch 1:     GPIO 157 at ~0.255s, arbitration errors
>   patch 1 + patch 2 (v5):     no arbitration errors, touchscreen works
>
> The driver is not returning -EPROBE_DEFER. The problem is that
> amd_gpio_probe() hasn't completed by the time i2c_designware fires,
> even with arch_initcall. Promoting the initcall level gets the driver
> registered earlier, but probe itself takes time, and i2c_designware
> catches it mid-probe regardless of registration timing.
>
> This is why device_is_bound() works where initcall promotion does not
> =E2=80=94 it waits for probe completion, not just driver registration.
>

If you added wait_for_device_probe() right before requesting the
interrupt, does it help?

Bartosz
