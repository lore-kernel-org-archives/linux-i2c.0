Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096CC171CD
	for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774251786; cv=pass; b=mpiqbxpTH4mKyTWglkxhPopVgz30cr6AUq5rpYBrH+N/GqTbdvD1Fp44lMe8HjG92gVQSNtEKgNOMR/zn6WqM4BaOodwCKtQPgZ2JHSS+wZmniMkiWa1OiKqva+IPA4OqFvYarR9gCmYkK9ZmGh86nDk/C6p2r1ST7J9YHv3kCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774251786; c=relaxed/simple;
	bh=1AWEYAhcuKqbnxtBysAJR5C0Rw0X4KRCya1IHmqv/uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqhN4DOn/9nKRL4w7+Ww1L4OHtl86w6BtA6jy6tu3zB+xhCBc4tj4aJrOXiiGB4hydfk0j5pPOPJN7cvIoSk3QI/Yylt974cjjYJOkgRcXSfZykg+gvOZVbFu0bKnDpLRZ0VQ/R6FDZj3rTBIdBCg1MMfyO6bAxb+trihmEwu3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWdQxNLa; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWdQxNLa"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-669720ca6c3so2078945a12.1
        for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 00:43:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774251783; cv=none;
        d=google.com; s=arc-20240605;
        b=ZBg5jVWfpOcBVmfLVeJf/yzRcI337pkwEly5KyNZzDDeAvkUvBXbmJa92eR7pcgY5B
         GNEf0o+48G51LQzhsJyYr6znAPStL/18JrfYEIaVgC8tMHodaNLo7A4435Agw1PtS85d
         Dg27ouEikXgqaNkhG3VGZ0UCmNGcBN9fFvk7w6uj8O+A6rfUUn6PHLC6woQj516M8DkG
         H2ptBsaBHouiQG3j0YYNoS6sfnDWmEtfsM0Fzq3rlnM8bAaSKSZd66NZ6eDmqeSSsRT1
         tVLklovwyIaYWqQonwgYeR45mjATXd/6xWUjTJnyJEtIbTk/b921//0KaYXcoG+F/e3E
         5HGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1AWEYAhcuKqbnxtBysAJR5C0Rw0X4KRCya1IHmqv/uk=;
        fh=Al5nxAfTTZpItfmjt/ZbAXPWGZCGLgzWhDr5wF8FpfE=;
        b=aiF/SoYYNYkY5a2XN9DqKx3LiwP1nS8My6uPrfYU/+Ev/NF+6ic0CZfnPdiEwMNFfs
         xCkYzjA8U+PTwQIZPNa8DcX7pieDKYiRDJU1Axw6QoChoLBTE2QucfOYJuGjkUJcRhj+
         keRhl186A8VbnGMmA4bHfiaWUNW6+j8aY97hQ94nfjWMh54OaH2g8G60f/ElsBVU5ldn
         /eIk/45geogX3Y+oaWmpGxUxHocuZPdr1Uw/AGHCrhfQPmUTJuFGPQI/QMJA1VD13mam
         bDWtqQr1lz62yrC9bq5kH+jtwmdjklEYl9L3C0jWZnONyMm3xW5gHxBjfyM93zvqviBr
         SaoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774251783; x=1774856583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AWEYAhcuKqbnxtBysAJR5C0Rw0X4KRCya1IHmqv/uk=;
        b=cWdQxNLaMGcqV9pahNRMBsTNzEN9l2M+Fb622qHCTdeUU54ruHQ1yJ0TnYiu7SAurf
         Vhf6Jm9Wtqkn0wnDa8UZCIi3O10m4NJPxbZNzqdKxiUtlmDeKuv6fKXus2W8xkGI/bbW
         9Hz/gEvPcU2fPkS13bFS30WLLmguE+EIv/WbrtiJLxENMwNJE5Tx1ZultF87bVDSpZpi
         6tF7CGud8muntF39UYIC5ijtl0BTC/U36Anajv/IyTU9uSp5lc7uZZ8djcsD5HPgUP5m
         f/0RN+PMFtm5JSj2BDiBH6HtIO3+vibJ81v/wo3HfSUoNlzyxDTQ0rMhCEIU4/mj9D9M
         6zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774251783; x=1774856583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1AWEYAhcuKqbnxtBysAJR5C0Rw0X4KRCya1IHmqv/uk=;
        b=MrxJnVCMVfBy4bM+lIqEMlyPMTEVkR9kJGvvGY4Mwxw641kDzFtigCZsz2oZjIum2E
         5So1Tcz7pNg/K2o+FgP/A0XEVnRM2QxR2HqQzgUZK1KIPAE6Sm0DeD8rRYMiXv90O6W1
         cTXWyIolSsB433Dq0se690vdc3L5ovTV3vyVSygj6SgU/T/jOw/2yRY4+Ddk6krGCMA5
         qrLwDUB0iUNzYiSAia082fF/Jx84ryiOMGawAXQuqv9cH2r0wSZA2kXRfvXI/goKAWQc
         fnROs/4HRMNELYPcxPk6v/4CnDLadKF/jR0vdWcCfynl/G9j0t6iSAja9SHc/4GTmLdx
         Of1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpmkPgotirD0vKRcHB5+z3PB651xVm9/wwGY7Ma8QYW7x+rkIpYQf9hruYM1HBePixC2HxU82aMUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrnqRZkagwTmKOazluDC4PA99J1/XrJfPSExAikZ/+Q/E9kp6Y
	XJFtOJCi8SE/ORrQwUI/GbSD5IrQCZDLORZGpqHldL58sEYDZf/hF+duCUYKTzDd478epXpMAgt
	osxnXR5eUWtgZaGgZpAqHHYOZjfZJQQ4=
X-Gm-Gg: ATEYQzztTp7OqGPzP+qP/SM55gYU2sdNzsESRVrMZ1gIY9b32enKPF3bdlV/xf3v5RY
	OyAMNn2WSfPacupVzVUStQux7VADAinwBWDwbRGqAbVYIEChN2c7TGDz3DwxjIJ7qEHRVJDdGKv
	/syTOqJDeriSwjDuo9WEd+IKsIB4peC7/hBZW8Q6Ybro5vXmANixGpzkfYcaUs9Z0Ju8PcTFVMC
	XRNCIEtiXNxvRC64HjBpnL5D8tvqxF4Tp0MJXSdYdeh/W4GKrWbyIczmSQwoZ3hd3hona2AmFDf
	C5vcvD+uiw==
X-Received: by 2002:a05:6402:5188:b0:663:59ef:3f09 with SMTP id
 4fb4d7f45d1cf-668c9c50d4emr7902847a12.29.1774251782990; Mon, 23 Mar 2026
 00:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310184046.2010403-1-a.shimko.dev@gmail.com>
 <abBvf9HgLeCpjevu@ashevche-desk.local> <CAOPX746OoVrQYgJiBMgDA+VOkUj5mtUmxFEXubwHsXTnPsCsrA@mail.gmail.com>
 <abFbzyYHjTCilnqU@ashevche-desk.local>
In-Reply-To: <abFbzyYHjTCilnqU@ashevche-desk.local>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Mon, 23 Mar 2026 10:42:50 +0300
X-Gm-Features: AQROBzDeyLNUX38OZOjuUkdvsRKn0Fhcw3VOMdqpvESlbag9a5B6UwQCnv7HFu4
Message-ID: <CAOPX747gA_hyzMEb=8QJaYMrKoVP-K6xLx5=9Y=MzhOCOL3Mwg@mail.gmail.com>
Subject: Re: [PATCH] i2c: designware: add reset control support in suspend/resume
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, rafael.j.wysocki@intel.com, 
	wsa@the-dreams.de, Jarkko Nikula <jarkko.nikula@linux.intel.com>, js@sig21.net, 
	rajatja@google.com
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Wed, Mar 11, 2026 at 3:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The second option is inline with the current approach in .prepare(),
> so at least it would be easier to sell to the maintainers.
>
> The first one will still require some ifdeffery if I am not mistaken.
> (Or at least the similar has_acpi_companion() check.)

Thank you very much for the review and for the suggestion.

I spent some time trying to implement the has_acpi_companion() approach.
has_acpi_companion() can be used inside the callbacks, but it cannot
change which callbacks (suspend vs. late_suspend)
are registered in the PM ops structure. For ACPI platforms, we must
keep LATE_SYSTEM_SLEEP_PM_OPS to support I2C operation
regions that may be accessed during suspend/resume of other devices
(as established by commit [1], found by my colleague). For DT
platforms,
LATE_SYSTEM_SLEEP_PM_OPS causes hangs because the reset controller is
not yet available at the late/early stage.

I agree that adding ifdefs is not ideal. I will prepare v2 that:
1. Moves reset control handling into runtime suspend/resume callbacks
(this makes sense and aligns better with the existing PM structure).
2. Keeps the conditional PM ops selection.

Let's look at the maintainers' opinion, maybe after that I will be
able to send v2.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20260317&id=3D541527728341b
--
Regards,
Artem
