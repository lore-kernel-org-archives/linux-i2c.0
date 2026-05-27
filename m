Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CC040DFBB
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888246; cv=none; b=tEyP3O9nAxZByiKJB6byYOVIu8/+uXRZwnxD9ov94+Td2L7K6piqwJhrM3Q+KeNKdMXd8bLwwZz/XaquCcwwEhWc+CU24XgjvTmonjlasTtKgpLrNqczY+5uGycaxukiJ5Fmu+srh7b9bI4L4Hh3LjLHeoGtbuZLEmL+Q+uOgaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888246; c=relaxed/simple;
	bh=tmDU4VguE+cwpfpInPS+PXjfh3XEe4XV+vkqOU8kHK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URl7E5ra6KmYmegf5kh9MNk3ztnPNH4rmlPlyuW/VVeoRD7RzAwb7QfkVhMgGJxH+CuAePQVbwKJNn0h8oKmHZPPN7UBKukf8/iiNabNJAoVX73GmJ+bhn0Rt7d1J1mvVKdv1vmPdP0y88AKH59cftxB8D0Ks9os5DzTQs8U1Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e6201aeb2aso4279564a34.3
        for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 06:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779888243; x=1780493043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9MuSPc8y576tayBCaWdrNcab8/lH09ziazVq9lwM/2k=;
        b=mCI/HwTcrr1ohLLrIVsvB4QjPGIQfPmeuU5iMLE7oCjZpsGIP4S2umoGPyovUVWsTP
         JIZzX9VecdM0mV8AdI7bgKbLqdmBMiNncgPxULqB8WnFCUFZ7WxHGPJq+wSkPY1XlAgd
         nyyBr2gx82TXeOmFuguqRd8jPieQ682I+KGAWmOFCfyjZJPcr0J6TEnrqqvoPm11REYx
         cO429lnVihS7l4N/D7siheKYM1FKUBXoQwfKrXRIuStdvK7xKfRd4nCsZ0c4B9TeCOth
         JZDeqLCPz2utzrWekKGBJ09s15++1xFNkk7FI+w44Xb11BfciTlM97MGqiqvRVC3xGFr
         VRCA==
X-Forwarded-Encrypted: i=1; AFNElJ9GSJ22Z+yluYr6pa9H5Nu72zEeIdF9q/aQT0EWAw3F1533d/Wf2PiJHfCemszVN4UEXIhJAnEBop8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXFrobZ0J90DHorJUtIDRw13/FNYxql7DtGb5RPJMfHJO3Ji49
	GrWHWdNmzcsDkWvDXBSFXWAh1Ewevn4QQf/Ocm52FeCWXSwpcprGHj4ccIAVGbMMNi4=
X-Gm-Gg: Acq92OGP0jX6k2oWaCdVrTFsO1mYg97AVF79IG/vtOs1B+Hf1VuVsSWnnoahBTLkHy4
	RaDPpxlNhPolm/Yiw4mNIZbXy1/YQOcPAYr5Zfr8ty0UqcOxogCGQHyrd6KjNLCKJTkKf1Krxrj
	RwvIJpEcc4FXeEGrXbmZ3Hh7XRcDu11L8kJNS6X1xQ4ye3UeU/mWjtvIgj2e3bY7u2qj99ITtMg
	pRo7jjkuaw5ohGiWHrYmbpnZCLTlabrixPa1QFyS37Vl80gl2Lmr7m/T8J8fSLBCJU02UzpRz4Q
	LNku1tZ114Q/FSfGH59VPIAd+xR6QTTmVsA7S2yCK2JMaf6iqfTtC3b9hl3HXUXZHpx1QHztcWD
	tx/sdf28XhqLjs25YbbU9HMMBiN35ibEHQG1BfxOplQsthnzFQzoYMF+b+3PWxNqZY3JCeQoMVd
	016C3qurkQpNBZ2EXjD/hvPYooY3D9EvM827qML8RNAYpWdJE1FunwphI8j87iAFBT/QVESPw=
X-Received: by 2002:a05:6820:8186:b0:694:a362:4b86 with SMTP id 006d021491bc7-69d7eb8b473mr11911282eaf.22.1779888243606;
        Wed, 27 May 2026 06:24:03 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b6350ad38sm16859657fac.1.2026.05.27.06.24.03
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 06:24:03 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40ef10ec84cso9930969fac.2
        for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 06:24:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/jKFwINqtwcKzKVwuQPMyiM1Yo19sNyaO3nlspxzBhluz2u8BDo9e0PC8DOZp+afvGVZRGaTcB4+s=@vger.kernel.org
X-Received: by 2002:a05:6122:3102:b0:56e:e9cf:7134 with SMTP id
 71dfb90a1353d-5865ee6c055mr11675886e0c.3.1779887909452; Wed, 27 May 2026
 06:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com> <49576a7501128c93ef318566ed7faefce163f1fd.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <49576a7501128c93ef318566ed7faefce163f1fd.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 15:18:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUFCGKUCDBLiX70bLBUGxU7iZRGT0hEipkrM2FkjE3v6Q@mail.gmail.com>
X-Gm-Features: AVHnY4K9MKooRiuSGEh5fNQ2eTKctG0rOT_zroLTx4bk0lQkHEgucmZG57_gNvg
Message-ID: <CAMuHMdUFCGKUCDBLiX70bLBUGxU7iZRGT0hEipkrM2FkjE3v6Q@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] zorro: Simplify storing pointers in device id struct
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Max Staudt <max@enpas.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Helge Deller <deller@gmx.de>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 May 2026 at 16:18, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> Technically it is fine (on all current Linux architectures) to store a
> pointer in an unsigned long variable. However this needs explicit
> casting which is an easy source for type mismatches.
>
> By replacing the plain unsigned long .driver_data in struct
> zorro_device_id by an anonymous union, most of the casting can be
> dropped. There is still some implicit casting involved (between a void *
> and a driver specific pointer type), but that's better than the approach
> to store a pointer in an unsigned long variable as this doesn't lose the
> information that the data being pointed to is const.
>
> All users of struct zorro_device_id are initialized in a way that is
> compatible with the new definition, so no adaptions are needed there.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
