Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0607A38E110
	for <linux-i2c@vger.kernel.org>; Wed, 18 Mar 2026 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823667; cv=none; b=kuJ1Kvd5AxgsEXlg+AjU+L29CLrHSUOiKcMqR2sssbS1e0zkJ1uBVPRJkIMRYYwu5+VIjCt6L5Q2IW6uHXkrLJQznk5ciY4i2UPKxtLYou1I8rbRr9HYacoScAaKDChq8wMd70MaloYoG28gO+J2lW1u2+xDkkkSYi7LXWRP6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823667; c=relaxed/simple;
	bh=1Q3Co6bxbshrYxrPl4jn/U2T1xBX3gjFWpDnRI8lYDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKQSdf9x+505OD4dkpSVGtJ2JsgG2ZNTK9YUeOhfVm2SvCJEwbHEambeU76sa36FfpRq+0vFZr9FyC91KcFUMqZ3WiLGKTeg1u+qmXM22uZ+gNRK3enRSVls8fxFlEx9QwwkeTV79Rzzg/KWhhtj13DoFwn49K354gKv8X/Upzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb5c9ba82bso1027485285a.2
        for <linux-i2c@vger.kernel.org>; Wed, 18 Mar 2026 01:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773823665; x=1774428465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqPUDw6RZ7tI/8SbuWaBeZ31o+A7cvn/glmx6dclWwI=;
        b=LdK5v6d7S937/vqTopjx0W/1nuBVKpbGriq6JmhaDxDyAR/h2fETtn/+HlWcAKJAW9
         LdvsdVjh+YV+qLc2gQCxM6Hqvvqehwu6EBfa32NY6FTdsHITsH6epY0oPb3+b5JmwtwP
         EvTxDMj3R7jXgtqYXsIUYBxBAJIfKKOu8pdU7mqS2hWTXm+q6ZQdSEsBjmjJcL7fD0sg
         wEFPkxFPMYrz4+vDQuPeYmnFYLDwzRlZnEmXr7aQxrupIKfBdKToAOas9YdiRIBl/1qA
         hC5nhe1RRFBoMB6/RMAzeYaUUOr33nEzzrfe6TzXnTMk+qCRlpJVuQAXu0gOk7hTzUT2
         Uu2A==
X-Forwarded-Encrypted: i=1; AJvYcCVg1QflipvH405ne2Rg54E0PGjIBPVF5NL6vgp8xnhqMYOM2B0G5MfWQQfUSFEOABZBA9616uXV3aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaT0EfiY+mtFW2sJCzsp7Bt7Yhgx6w7GiqmXpFZOVXAUDBemIw
	PoZCGcYFP0D7ko2cEn3cp4fsNmZRgSRhU/xa1qi668pesbHZSwh34EqJpFIKRzxVmjU=
X-Gm-Gg: ATEYQzx/fdaOMcud8LcEjz/Jg+EKm1JNeG/ea0wmLGm05oQITAgNvyJQwXILPCDGfPS
	eOyVsdCwbMfgt0m02aClAA1m3DG9gknuodXw8qntGNFJejc0/NS20pjZr23Huplrxmx5g5nMVHh
	WWe4GTwP9PZkez8xV5Zj30LCfFUfufmhoLcbBJj5G+FchrUR83dhuMjNId7vN2SQcQF6Fk01k01
	5gWl7Di595jreI2Axr9bNPR4G2M5GDL+a44mh7WuKvydLFGou9QuJvkhimu1mGAsVeNBHAVOXWK
	mmyAxk6nfpqW8XtxqSgMfrIo/l1pDBh/QcbT9YYtRmMEn4viya7RM+3vI/a1zlZWo4ov80Dv6ji
	A9U0oDQBtnHcq5b/T7fubwrwFiaKKq/vAJhTzPnSdIvJEhCUnpb8UqVP09ZMeH+chwGsS00uar/
	Z1QAwl/5V6QPb4fgRvHKL4bExsChI0+iNyIJL60xHNz+qmkvUkCQ1A6LPJN7fpHmvT
X-Received: by 2002:ad4:5ded:0:b0:895:7864:f69d with SMTP id 6a1803df08f44-89c6b5617dbmr33049746d6.40.1773823664849;
        Wed, 18 Mar 2026 01:47:44 -0700 (PDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c703c854esm7247556d6.42.2026.03.18.01.47.44
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 01:47:44 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c9f6b78ca4so832401485a.0
        for <linux-i2c@vger.kernel.org>; Wed, 18 Mar 2026 01:47:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvFb8pQCpy3TbhYHDUxDoClvW8IlfRsHtTpuJfLLvZgrxUl92NfAAj6JnI1b+ZmJVgus3c4vdd+PQ=@vger.kernel.org
X-Received: by 2002:a05:6102:5087:b0:5ff:e39d:9f9b with SMTP id
 ada2fe7eead31-6027d159e7fmr1126209137.16.1773823315107; Wed, 18 Mar 2026
 01:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro> <abkD-VLprcbbEbB1@ashevche-desk.local>
In-Reply-To: <abkD-VLprcbbEbB1@ashevche-desk.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Mar 2026 09:41:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVX4tfko8iv-EdwO-bBcwCd+cPkb9aP8qJbcM1F4zdz4g@mail.gmail.com>
X-Gm-Features: AaiRm52_MgNfiAr79FL-62Ac0xXnTx-AfzVYThIE_IN0tF6AadQcPRzCkdJNUOc
Message-ID: <CAMuHMdVX4tfko8iv-EdwO-bBcwCd+cPkb9aP8qJbcM1F4zdz4g@mail.gmail.com>
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Douglas Anderson <dianders@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	devicetree@vger.kernel.org, driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Tue, 17 Mar 2026 at 08:34, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Mar 17, 2026 at 08:26:53AM +0100, Wolfram Sang wrote:
>
> ...
>
> > Thanks for tackling this issue! I agree it should be fixed, just
> > wondered about one thing:
> >
> > > While flags are often modified while under the "fwnode_link_lock",
> > > this is not universally true.
> >
> > Is it a possibility to use the lock in all code paths instead?
> > Because...
> >
> > >     struct list_head consumers;
> > > -   u8 flags;
> > > +   unsigned long flags;
> >
> > ... this change costs some memory on every system. Maybe it can be
> > avoided?
>
> How much memory does it cost? On most 64-bit architectures is +4 bytes,
> rarely +0 bytes, on m68k it might be +2bytes. On 32-bit it most likely
> +0 bytes. I expect that 64-bit machines will cope with this bump.

On all architectures with natural alignment of pointers and longs,
it won't cost a thing: struct list_head contains pointers, so the
struct must be padded to a multiple of 4 or 8 bytes anyway.
On m68k[*],  it will cost 2 bytes, as the existing padding is just a
single byte.

[*] Iff m68k ever switches to 32-bit alignment, there won't be an
    additional cost due to the change of flags here, but of course
    there would be a cost all over the place.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
