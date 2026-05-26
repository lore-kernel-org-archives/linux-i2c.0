Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DF640758A
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808133; cv=none; b=p4UA5FkvgnXNZlGqFWWAd43mG8ZrmWCm/9QXeSCvx0kfXZWGtOVA2lJ4wUkcBCY1AXj44wOxmH8/O9EHBpmY1mdGQCV3GBSG0rukdoVvOIGNacEVFu15JeggxFa1yrDBd5GakRK77B9R+q7CK/DzAUo4QCVXJCF1u0w8++z9sbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808133; c=relaxed/simple;
	bh=yb+0omux6d1zyLgvLzeZABk2GNuWtKQ1yrpCoQCsmR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLNPjK/bowYKsS5hXWZYfwwgudZl+7lImAS4NZXlEr5r8+O6qoX2d9WgdwB1lrUHPfbkaZmsKJ7S92Kw50Ut/jQC6dYYayW9VwRSDMrnrOjNad21umrjSzaQGsdD26aZ40f/EB0AEAI+pRviQxLIoJN1mcm/lETrOwcnJF9+2KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so5688704a12.0
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 08:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808130; x=1780412930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MLTPgXz6PTE+WNmbiors/d1TQS2Sqmrm+U6hNBea8hs=;
        b=rLqiRxTyYlS1iQXaL+netxHea9hKokOUTpjSj+Oue+dj9mGQXlYoh4gdnpiOBIV0gx
         OvKo2is0B3G8IL9Xa2q1wAnZkLrcqs3lolKv8H3XFPfD7RwlNEq4tCi8xrbysBNP1EqV
         /TrDOhPg9V7b4dX2qxZter15FqLZfaMjNV+GhQBLoOPWpThw5npPmMiKGU5/LRWd/yDy
         tvU8pOTQoYzZ6l+OtOqgmxSv8Z7w/w55aFvU+s5+HDEXpDUGjcdpcImlg6WWM0QgJ3M5
         B3hwoqKI9NxmUkPxiO5Occ3x+vBOIZ8Eu/6EmoPV8BdHhkQ+V2YSSWze20f6i2KQfZPG
         gpVg==
X-Forwarded-Encrypted: i=1; AFNElJ8VweAtX3MMdkwsLR09o9H+DwgPClrhOS3F/nYhm9TMRwQ6O4V30pPtQJgECKZ96NVRxQjEShW1enc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxovqhN612VaO9aVV86JK5hD+FA6u9PLn2HRu90Uaf6K/X2Knux
	NyuYKzPR29CppnV5vXdKWvGuYMJ/l4ntj+vgBk+sElLx+RP1rQ/wPOiI8GLYv+sV4PA=
X-Gm-Gg: Acq92OEsv5TYjUaAtbvB9/z1mSnwnJJMDc++Px0ZlNNdgYfkRZGQVeDzJeA162uVN3y
	RTldzgu4bnk2e+DZcIZkNpKnoSheUTiU2UVcUcdUieshwqC+Dw+4Xal4tWmBrrz3tcuzEqjXa9b
	FsgKLtZpWIOg8gr20tDKpDcKlKscMOpUOTl8q16FzmY8hTnRfajNvIoH6IAHkT5QuFSR01niCPe
	4bLH/XQ7CcTOJecmwzqKb29mnMdi6uIfbhqJ7+lLmXdWoFQvP8U4BuJhDmicfB2tuD/sAugHc2D
	kwzmr5ACh+HzVL0jnQm6tmvXDB8KAmhXsgLW/dBAndYcqhr93GrnumHyUpW4qIsRDgjGKCSb138
	UGrBTX5iqdKAk2CIb8OtTdl+VDcs5VEiGS/KRJp25eWh8KcTgk+foxLXaf+imfLpU1T9xX4+WeD
	+0gO+xWrRMu29TJbA5Bp6r7fdxc+8zr/FE23FE0AVAWaDW4zlTG8TPo6/q0pFx
X-Received: by 2002:a05:6402:354d:b0:687:3580:fc26 with SMTP id 4fb4d7f45d1cf-6889cb3d24amr10325136a12.13.1779808129894;
        Tue, 26 May 2026 08:08:49 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688bb6273a2sm5205668a12.29.2026.05.26.08.08.49
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 08:08:49 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68852a4fc68so6038780a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 08:08:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8eR5CRJqfYNeWJPdccBBBUeZQ/4pwLpkpY19KfDA5PYFizv1/QKgicqjOFngdyInhwC0rMpXOXCS4=@vger.kernel.org
X-Received: by 2002:a05:6402:360a:b0:674:40c3:f047 with SMTP id
 4fb4d7f45d1cf-6889ca4520cmr9385916a12.12.1779807721391; Tue, 26 May 2026
 08:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 May 2026 17:01:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
X-Gm-Features: AVHnY4KG1TJnpMipnk7rqdd9LGhhF-uK_MvXjYFynbh1jLKZ-eyBikYr9yO02y4
Message-ID: <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in zorro_device_id::driver_data
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Max Staudt <max@enpas.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Helge Deller <deller@gmx.de>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	netdev@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Tue, 26 May 2026 at 16:17, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> this series is about improving the handling of pointers in struct
> zorro_device_id's driver_data.
>
> While it's ok on all current Linux platforms to store a pointer in an
> unsigned long variable, it involves casting that loses type information.
> This can be nicely seen in patch #7 where after profiting from patch #6
> the compiler notices a missing const.
>
> Preparing for that change, all zorro_device_ids are converted to use
> named initializers, which is also a nice cleanup that could stand for
> itself, as it improves readability for humans. (That is necessary
> because an anonymous union can be initialized by name, but not using a
> list initializer.)
>
> My motivation for this series is the CHERI hardware extension. With that
> pointers are bigger than longs and thus you cannot store pointers in
> zorro_device_id::driver_data. So this series is also about getting
> support for CHERI into the mainline, but I hope the clean up effects
> mentioned above are justification enough to accept this series.

Thanks for your series!

> The dependencies in this series are as follows:
>
>  - Patch #5 depends on #1, #2

s/5/6/?

>  - Patches #7 and #8 depend on patch #6.
>
> So if the ata maintainers agreed to merge their patch #1 via scsi, and
> Geert agrees to patch #5 and that it's also merged via scsi, patches #1,

s/5/6/?

> #2, #6 and #7 can go in without further coordination.
>
> Patches #3, #4 and #5 are only about using the same initialization style
> for all zorro_device_id and can go in without coordination.
>
> Best regards
> Uwe
>
> Uwe Kleine-K=C3=B6nig (The Capable Hub) (8):
>   ata: pata_budda: Use named initializer for zorro_device_id
>   scsi: Use named initializer for zorro_device_id
>   net: Use named initializer for zorro_device_id arrays
>   i2c: icy: Use named initializer for zorro_device_id arrays
>   video: fm2fb: Use named initializer for zorro_device_id array
>   zorro: Simplify storing pointers in device id struct
>   scsi: zorro7xx: Make use of struct zorro_device_id::driver_data_ptr
>   video: cirrusfb: Make use of struct zorro_device_id::driver_data_ptr

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
