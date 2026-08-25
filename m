Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA072470458
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664025; cv=none; b=ltG1JYIZGI8dO5LRMwEkx2G5mOMfxesmoy43v25BgbDZyh+kZHei+d/xXDNyKRdNZt0MMWRTzoaI8Ph8+/TGBHMXSB1UDcQAqYWK5E/xQiJi4yua7WZzXZYvG9rutdQvUQ4pbxbYgS3ESWHVERO7NKUEneHKARCsdHaYQcxNyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664025; c=relaxed/simple;
	bh=PmRTs1DzZxI+FrDLeeLH+DQ0KrqSOQNiLUieGIdPbFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbSzzTEXcc+BwKdWfgHvlZb/9+7psdE9TukEoVPLq+u7DsIZG3kGDRksMERxzgMkZCCudcNHzWlNVPvKTB6kmE9mTNO5E1p7jHabbG87xgyBbMIowrlqCAgajOyWoWqBVbZHlCwx7Xs+FGP5IrY+m/+allJ+RhrkfVw2LKfeBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a3fda88184so7236373a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 06:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787664022; x=1788268822;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7Y+iQzfc/wt6owXkRW+QJJNIcqzyaAjLzqiiwkIiBt8=;
        b=sngzUoIuQmb4e4MKzh1C315lZjOvfC877GijJxZo8999G/gBN6cCDpWB1HDVdLyVk6
         QQKCxW/9DA+qCWA27LdSwArGvjgaibaeUkYow5GlrgCK6KEU8yhZI4x9KxbKoCmYazUZ
         A0uPx1aZRe8wgxLKgvmDdhtt0+KlQykon4Ksv8WGq1QwUqRdRQctpNwPwFPIZG5lshFZ
         p7OCFGufCybLYWOD3NzrXFu0wtmkA8cT/dBc5h7QkFlhEaSveySIWpTlYzCAYh2B1rza
         0LzMWjQUaTHG+eCZwPExeZ0ygsB5LLRJdYKef0QH2chI36J/AXILRPIBwTz4OPQJftUh
         UR1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrCy8M5z+7WBsoJk3QMhGnkiuNNEXQjS3+eI3NbYFkilK8P+nxAw45KurkBbrjNcrCgyDxRshsIDI4=@vger.kernel.org
X-Gm-Message-State: AFuF++lDnODqfJNXitPnnz37G9DrX2lvZY1B9kg9crxs2j16snRV+X5n
	EGMm/0EyVrM5ZOEwpKkb7TwIjZgBJ4hY70PUB8daSXJUVnyKS1PAbhEipZ/gOo/7MxU=
X-Gm-Gg: AR+sD111ACeEf3fuxJz4FaBuyumJx+E4RrPUgCdodBFZywW9VDDYUXmfj28Sm57tKx7
	PXst3kT7JzRFONlyaZVK77hSChqdfPE+IT2waPsh5PIUMcjkbwkAlUpw3CsfvkNYdMGk5HKhqYi
	G9vDchUU48FSX9uvnb+kJMUx8eWM/iNiAvrOzt2rVoozuKepf7QM8Nw5/EawVCY51EphOVfffPv
	6Ueq/Ql7bvWCPmbsy0IY45YdPWI9qR3CXM5+jl5gMRHA/tWtyIoEka7VlgIb8yKhbmpF95HsDfe
	2jCKr34pWNgmOdT3ZQH4LUEWPChElu9LJ1YmMTwUjBxDDJLMOmh2KmFLzA7W++evQMGWRNZTBwj
	L1LAWIu69TGWc9rMvCk/VRGt0GCjwryfEVhurVDzIRviEkgzIpugeKb3cwTWBFWS3IA48crd210
	l4Eai6fmQjQU0YsuAcC7RsDWjamHMEoVNmTZv2kzJE2C9c63tMoC3wH5QRfljzFehf3boPPHcdm
	h3pWSacTTqBSXDFxfTn7MUxWw==
X-Received: by 2002:a05:6402:5307:b0:6a3:6b8f:94c4 with SMTP id 4fb4d7f45d1cf-6a5c416c53amr8431208a12.16.1787664021708;
        Tue, 25 Aug 2026 06:20:21 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1d741asm13965181a12.27.2026.08.25.06.20.20
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 06:20:20 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69fc9f25118so5203797a12.2
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 06:20:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro52dxEnRApnox7FXjb6qKCbLqJxzxs4WX9U47jwHVBOcLdIDGb5ySvFcQs4N7CTbijmCQ57IcSc58=@vger.kernel.org
X-Received: by 2002:a05:6402:f21:b0:6a5:d7e0:626f with SMTP id
 4fb4d7f45d1cf-6a5d7e0643cmr2123073a12.6.1787664020370; Tue, 25 Aug 2026
 06:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520131206.932050-1-claudiu.beznea@kernel.org> <20260520131206.932050-2-claudiu.beznea@kernel.org>
In-Reply-To: <20260520131206.932050-2-claudiu.beznea@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 15:20:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW5QrWvA4cXYWgttMmk+RPUzc-khjaDfSNmUKcUiW_FfA@mail.gmail.com>
X-Gm-Features: AcwNN1U3OmHmmWpwS87tYrTQJzi3-zHMxDqRDiJzx8Y5-1P2kHE8ffd0bGHqVT8
Message-ID: <CAMuHMdW5QrWvA4cXYWgttMmk+RPUzc-khjaDfSNmUKcUiW_FfA@mail.gmail.com>
Subject: Re: [PATCH 1/4] i2c: riic: Abort the transfer on completion timeout
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: chris.brandt@renesas.com, andi.shyti@kernel.org, wsa@sang-engineering.com, 
	claudiu.beznea@tuxon.dev, linux-renesas-soc@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Wed, 20 May 2026 at 15:21, Claudiu Beznea <claudiu.beznea@kernel.org> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> riic_xfer() configures a transfer and waits for the interrupt handler to
> signal its completion. If the completion times out, the device may be
> powered off through runtime PM. However, the transfer interrupt may still
> fire after the timeout.
>
> To avoid cases where riic_xfer() powers off the device (via runtime PM)
> while the interrupt handler is still running, disable and synchronize the
> interrupts after the completion times out.
>
> Fixes: 310c18a41450 ("i2c: riic: add driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/i2c/busses/i2c-riic.c
> +++ b/drivers/i2c/busses/i2c-riic.c
> @@ -112,6 +112,7 @@ struct riic_dev {
>         void __iomem *base;
>         u8 *buf;
>         struct i2c_msg *msg;
> +       int *irqs;

Perhaps make this a zero-length array at the end of the structure,
so this does not need to be allocated separately?

>         int bytes_left;
>         int err;
>         int is_last;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
