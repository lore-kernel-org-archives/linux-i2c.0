Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706833D811A
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788523; cv=none; b=WyOUtMNyMEfCmmRhzEbTXLxdHD4NK/I6asxrJoybP2GboHGGl1UaIBygMv3EDef2bu0g8TPnC4RpStH4I2y/SQ9iQWoKIqxAj1lJTFAzDst3okxVjYXODNDwwcJ7lCnlwE0sFLISZ2Jj90sJbP56G/Lh4mueXRaGkN/bw1pCKaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788523; c=relaxed/simple;
	bh=lVWG8wpF88rzua31SZfbyLCR0D86gKUBFRS5mdzn6Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5wUr5TkPRg6eV862lJ+kDtm28TSsLPJod3QRQy2YKnbvhW+xahzixJqp/JEjTvtShnhpRm4D0uKKIN7G/dTDXQ/iawjWVQ6l9Ly5L7zxajBtQIsR3z5eMyTo1Km8OS9tZJCEvwTxa5jGCQPFXDsuj0nLOY4ZuxucMY1MAPGK58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqy8BI/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqy8BI/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153181F00ADE
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788522;
	bh=BDbhs6Nfya6qOCkBAjSW0m3ctJeeRrl6BOwxR3bhJk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fqy8BI/BQ5q0hCT9FQ/GWGBkzS3Ru2+elqjWbvGsy/hmceANfPBtb2EwKvH+Zhgr5
	 gSEpShJzkBq8fw7eozUzJbaD7xi8nARLjvt86fG99ra76OKqD33cO8vqZGKxO3QrlS
	 Yc5suOf8U9yKrtC4ufaeE2tBWGbK5F4gz/ZSBpj9fcib1D01PjgVwGU7KHHr9Qd//l
	 +UVShZglZuNlMY/WQuvvuT5tZE2WRAd5K73rtiE+gLG+qWMsVq1ni/MwGoLPo2dSJh
	 w+dlKHJIQzwEw+K8o7KGVJa1fGoc1ZG/B4gY/jOofowXE/vukxEKhYmtumcVl2nBqP
	 9A/f32SqLLvaw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-394413a63d3so78521931fa.1
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 02:42:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YztxDmzUkb2txex1WQUd71N/V8A//FVS6T61z900+YjPQEpF6RV
	aV9DXwAeXiDVdFC/Eh4hPqjdnDZ2x8c1z5mnfLAoJzpg/NwrhAmsbEGj8YIAwlRp4b6oFQvAOlI
	f0F6mSBK2Zs4nv7pmZgj3/GI/hYjItTdd6e05hOmv4w==
X-Received: by 2002:a2e:bc01:0:b0:394:3e27:53d4 with SMTP id
 38308e7fff4ca-395d8bf3fc7mr61652911fa.7.1779788520626; Tue, 26 May 2026
 02:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523174440.9629-1-hardikprakash.official@gmail.com>
In-Reply-To: <20260523174440.9629-1-hardikprakash.official@gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 26 May 2026 11:41:48 +0200
X-Gmail-Original-Message-ID: <CAMRc=McOJ6FoLWYfFGeFgh20CNpFASj0gMtfn0+v25BqNUn5dQ@mail.gmail.com>
X-Gm-Features: AVHnY4JmpXz7wK0Lzy6vcqPE6O7WehNS7CYNGba0EvE6KOdl0cxDCVDtiIbeGMI
Message-ID: <CAMRc=McOJ6FoLWYfFGeFgh20CNpFASj0gMtfn0+v25BqNUn5dQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/1] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, mario.limonciello@amd.com, 
	basavaraj.natikar@amd.com, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 7:45=E2=80=AFPM Hardik Prakash
<hardikprakash.official@gmail.com> wrote:
>
> Patch 1/2 (pinctrl-amd GPIO IRQ fix) is already in Linus Walleij's
> tree. This replaces patch 2 with a generic solution suggested by
> Mario Limonciello.
>
> The root cause: i2c_designware probes AMDI0010:02 before pinctrl-amd
> completes. Dynamic debug tracing confirmed the race:
>
>   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
>   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
>   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
>   2.348157  lost arbitration
>
> Previous attempts to fix this via initcall promotion (subsys_initcall,
> fs_initcall, arch_initcall) all failed because the race is not about
> when the driver registers but about when probe completes. The GPIO chip
> becomes visible to the system via gpiochip_add_data() before
> amd_gpio_probe() finishes, and i2c-designware probes AMDI0010:02 in
> that window.
>
> This patch adds a generic check that walks ACPI child devices, finds
> any GpioInt resources, and defers probe if the referenced GPIO
> controllers are not yet fully bound. No DMI matching required.
>

What happened to the idea of doing this in subsystem-level GPIO ACPI code?

Bart
