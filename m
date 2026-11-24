Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795494050;
	b=HyxM7hYx0bAp88uExVKCUFrG4VDsVRNwJyUi2gidckv4wQchIv5P5GFZY3U3nNO+979E
	 xohNyX4Q0gy7l/kNC/n0K8RgWKgyp6w8sQalNVZDSSxLINjf/0vp8jY5hPdffZtycfbeE
	 5QaOFuy9kVNwmU89mwiGQP8jZ8kvy7UzZnaMSPHyVAsXPa3Rz3iIgNmYk74TboldCwjRI
	 AY06a5M9nReeLykmWfz9OF51SKUM8rp0hWasjkfWeYnkEUhEy5nz8vpypVTWFyx4g88LF
	 pyqNoFvNJOkeAmn3HwBwU81G2FRHp5aK04u9T2OaMMaQfF+61YlZqj/e1KRpVgOhhWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=Iwz99gTCxCIUCcRsgbRPplQdxHuMdIk+bgQDXj94h8k=;
	b=ZC0YlPgXI22U10s9zUf1n69T41ZbTKOsKv8J0NoBYLv32ggRYXJq+vLT7j16alAK7Uym
	 5Fri8zCGmKkjnOUZbskuU2+LwVJm28fDUroGZDsCjXkVH67fYmrXalMJTyEETyOG1NZnd
	 OJ3IR7AYHxyABGzIKOA2dvECCtskZrbzHAdI0ZuDN6XbICkgdcYeYE9jStSuf+3wbkS6I
	 hyZJLywe0o8qCuiRALYRNrb1kUPYaP8jUufUdwlITytqUEsi0gWYVA1easjJHOmK7Ze/k
	 MYn3z7RZKiOovpxXvh/jvaVyd1kOVvlIpblKMddQf9ePDpG9CIqHBLYbV0oMJkbLLJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LngA7yn+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E6606A322
	for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 04:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 403E6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LngA7yn+
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b8b20b2538so4779064a12.3
        for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 20:20:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795494047; cv=none;
        d=google.com; s=arc-20260327;
        b=rzNNvpLtt9NKDwcuVMqWGSXXxZ892gSTd5WqdibAbMoS5B9Oew+XRmvGDwp3YvPtlP
         TreIhMzZjyZyX5XXZ84+5fa8NCEjXKKoUwU9Fzh4+xXnLU1owraB17Z/IXOop6D1UDZ/
         Rch1a7I95dLM3DqNDQsEk3BbxaknHjgmtDHAd+xVnQr+Sc39QOVGjtGUZzEUkRxLOa9x
         +S6WtyslteVidihKxikufZpsSGufk7spqASwzhgwGaYithi1oz8Hh5RFAmbCgKtIPuXl
         a24MtgbIbR589L58HK5og3waGdF1NeBSSk5g6rnvrrgBT4QDhwerCtARN/EdKoclcFFX
         4Aog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=Iwz99gTCxCIUCcRsgbRPplQdxHuMdIk+bgQDXj94h8k=;
        fh=e4Smz3GMsHDV7KtigfPW8X0VI7VS0Kw1SsT4IGE1aRQ=;
        b=QAm6exbYBZf8us34f0iVIHnZEfFX7cSsicoDAXZ0gfaXXlkYQDanzDdJFNvZ7djQ7x
         MrDpYgiaTaCKA58hOVqo00lN83Obj7fkSpdedWVPkTamwZhr23rvDfmBUOph3pGzbIwQ
         Tg2LTowltgyytxu57iVIEbX+CJsWOfEy19WglqY5f7I1JFbNVenceZRgn38yO868LR5/
         j53x6yWJwYaJvU43wIgqNHNUJbqwB6gA/k62EWpf6jTPXxoe5902iiJkP8breRxjoxx2
         eusrowA001OfL/YK4EEuSphnl0ityAjoLNrYOJkV4ElISSCk2MytkL4Dmpg+FmtIJNSj
         1Vdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795494047; x=1796098847; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iwz99gTCxCIUCcRsgbRPplQdxHuMdIk+bgQDXj94h8k=;
        b=LngA7yn+TYj3oBq32jsDML3Wtm1oLrVRjkDolfkMT1Oz7Qj+6OuF3gfr65+3X4izA5
         Y11HGSqlPp5/pQ8gk5fHZAUH95KMDhMm9TtyIWpaPzHIKc8uirsZmilPhpVqOO+DaHuY
         2Y2wGIOE/s59Td8aJONIlq6OE+j+tHh2gzIglSCjjgBI4WKEooJvAEXqT4JksOKevaNP
         37m32naJDe/zEuog+obxzxCI+SFVsDI26JPSx/HNztwYEMrKi34wXl/n2ghjLzxCC2Dj
         qk5XXenBf3Qs41nOUSPrbXNUT+mfMB32+2o648Nw0cq4+CJaibNaJf5NbvFEjNyCuxdb
         h5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795494047; x=1796098847;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iwz99gTCxCIUCcRsgbRPplQdxHuMdIk+bgQDXj94h8k=;
        b=Wiy22qoc/lmyQIqEgIs+uGLP+lcE9TQ7vm+gjCl9u+3Y6mJV8s5IhQMwaNzH8PbL3V
         v1HENp1vijJ79fwnW3WJXJ2ol1TGm23/US9A5xtLsuDshw1BuzAbO39HmE+GVof8fC3i
         sR2q6ieRE7xOQIPBY5ArzNGy8OWJWIYmK26DB+h679aa3D9i85RgXkdE+09frN3oV3Rn
         Tw781MZ9+j7nptit9+4qCRSIdbdmxbD/oQQxYRuKvUZTFH+csREk/ZbGFL/HxuaGZuLT
         n38jQwAegl2bPrqvCxNPRADr0ElbEE+OofrUdVXUR11UMEMJAJYCO89nsxymOKXbS48a
         U28A==
X-Forwarded-Encrypted: i=1; AL+hErEn0n3y+iODI0NcI5shVAy1lM0rDLG0eb0QHSEIcCVahHbrMbiIZnAz1SPoSRGXKSWSVIWQP8v7sZ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9o3AaSjdHuxhnUhAT3XuTX/Tg0ovUAOQNCjBBm8AZPEx6Itu9
	0+4IbbL3HszhTbRj4SceZoyM/dlF+buYFfjvV3xTolgtB/tTV7EiF2TKBwwETLIO5Ee0VMejH6X
	KB9tLonF23W1K3V+ZH2/fDuqZQtktY8rLQEGM
X-Gm-Gg: AZFdTZfAgPAlcYnlImV/BWO5/j8V/rCmvEIaP2I790Fud7X6byWXjPXUAsVCvVNIq5t
	1VImpaIdCW/BGLc7BPo/D++gPbrJexRxdkf55A3iRMlsCPekPgcDnTyKYLdGkXPcqknBW5xDJMz
	JZeWCqLKaYL7vHUvAG5T+0PISh99/v8GfHdztsX06gPZM78XyiM5j/yrrMQt7uo6RQFd6D9JgVf
	Ia9r6Vng+Y1k1eYxM33FtaAfTighT2DL1O6qPwCLhWEO1mwo5F/5cqyAyKBVKpP7xvfig8z32vi
	I2SayoOWT3s/GHvPJG5spfIp1I9OG3VNJ5CmRUycCe/cExwjOcIc/vO7gzZIT82FLqR5K9M2JCn
	SFcbNib9uH5JxSWHKc+9VJI6v98O7HRAbZLI=
X-Received: by 2002:a05:6402:234a:b0:6ba:7762:3dc6 with SMTP id
 4fb4d7f45d1cf-6ba7762424cmr5526320a12.31.1795494047241; Mon, 23 Nov 2026
 20:20:47 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118104935.1716-1-linux.amoon@gmail.com> <20261118104935.1716-3-linux.amoon@gmail.com>
 <awS84s2FVdzy3j4Y@aurel32.net>
In-Reply-To: <awS84s2FVdzy3j4Y@aurel32.net>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 24 Nov 2026 09:50:34 +0530
X-Gm-Features: Aa3M54o2V3tALqDtTk5FmFGSg-XejOz73sQbTVaEuMBBmEBfiB2hu2jposXV5Ww
Message-ID: <CANAwSgQXRojN2x4NypLajJ8tUf2cyNfdfFLnaOFPd1hXuOMkJA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] power: reset: Remove SpacemiT P1 reboot driver
To: Anand Moon <linux.amoon@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, 
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Aurelien,

Thanks for your review comments.

On Tue, 24 Nov 2026 at 03:53, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> Hi Anand,
>
> On 2026-11-18 16:19, Anand Moon wrote:
> > The SpacemiT P1 reboot driver uses I2C-backed regmap operations to
> > request system shutdown and restart through the PMIC.
> >
> > The system-off handlers run in atomic context, where regmap operations
> > may sleep. This can trigger invalid wait context and
> > scheduling-while-atomic warnings during shutdown or restart.
> >
> > On SpacemiT K1 platforms, system poweroff and restart are handled by
> > OpenSBI through the SBI System Reset (SRST) extension. The Linux PMIC
> > reboot driver duplicates this firmware functionality and is no longer
> > needed.
> >
> > Remove the driver along with its Kconfig and Makefile entries.
> > The P1 MFD driver and its other functionality remain unaffected.
> >
> > Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > New patch
> > ---
> >  drivers/power/reset/Kconfig              |  9 ---
> >  drivers/power/reset/Makefile             |  1 -
> >  drivers/power/reset/spacemit-p1-reboot.c | 87 ------------------------
> >  3 files changed, 97 deletions(-)
> >  delete mode 100644 drivers/power/reset/spacemit-p1-reboot.c
>
> The patch is correct, but you might also want to remove the
> spacemit-p1-reboot entry from drivers/mfd/simple-mfd-i2c.c.
>
> Anyway, while I support removing this driver on the long term, it might
> be a bit early to remove it. Indeed, while the driver is available in
> OpenSBI 1.9, using this version requires either patch the vendor U-Boot
> or using the upstream U-Boot which still has some limitations (thanks
> for your efforts improving it).
>
> At the end with your patch 2, keeping this driver a bit longer doesn't
> hurt, as it is only used as a fallback if the SBI SRST extension is not
> available.
>
Ok I have no issue keeping this as a fallback driver.
> Regards
> Aurelien
>
> --
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net

Thanks
-Anand
