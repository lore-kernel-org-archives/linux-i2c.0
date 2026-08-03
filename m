Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948E740F721
	for <linux-i2c@vger.kernel.org>; Mon,  3 Aug 2026 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762876; cv=none; b=A6bpK1LtcZuRUgPtFlnv4BVg1gFy9nStOlwEynhk/FsSTHYxZGjwVtzpUvIruE1X5zpeGHxBtxpEpb2QNviLZlO9/QlaGv/0H9XP9a0pqk2kHOawqXlOE3Qe9Uo35wRQc5S1nOOyxT02Qk//qhKP4XiVdi0EEDQc44MPyPjpbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762876; c=relaxed/simple;
	bh=wpRAEVGSk5EIt33MrZa1qKsoJY/CcW69bNAQso5cJjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csIOsSvwE0vJc1ZkozjAVD5Tkn2JBzdkaTfVe/vJxDJ3c8aVdzsHOWcSk4HOV9rmXVvLgJ/xxce7ONtmNTG7UzZdnwl8VBKMyiLkRQ5G8dYLz3YYWdHsvn/iu9rC4G1WuLFCZsLIepqxa4jwfpaylQDDePa1rT2jwQ+RxdoUqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-738cdd667ceso777586137.3
        for <linux-i2c@vger.kernel.org>; Mon, 03 Aug 2026 06:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785762864; x=1786367664;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s3m1f4gLLLciDRPIgPDtS8bZatt98aWtSkUwBrLRSjA=;
        b=CkbrX9bj/TW7GGwdhrq1QbQM/BV/jKtNI1cLVnFe7Gc+KIIhxalH5uq3UJQRaltgdn
         TCIDREvS18oY7fOJAEf5b1/ZFxIr23eI/Z36A/WfN0S3IWF9IiPEPkU5F8NRn54SfTX8
         n/eeT4bVeGoMVesyBW6VHQU7GOmOFMZdBrHVmYadwLdHlIiCVe9yrrTogER3wmELk+GH
         PkQk4MyZLzo2st9zeqhOeFNsBWV+akzOgTMFOJSK1NPFrz0ainAZkF/zI3nLs71uuLwy
         tyXYNBMaTFg1y1+/TrnBwrrUzxop5quC5DoEZux5DayQzbuyMd05Mvv4e/4bKaUO19qI
         61+A==
X-Forwarded-Encrypted: i=1; AHgh+RrwDo35nfie3ngw7YhsmwyHF1aHZklaz+wohDjk9XhfPm+fCSYTmiS/X7nnVDLFmAWFCQuifibJqXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/zJ/WNX4Q6wyBzA+Fiw///lt4xb8b6VetPrue4Rs3euwl+Vl
	n4E98PAFkbGlFGWxS1C3r+KSSLyAZBLDsianbI39LTQImV9ht80hDkSKEE+T/7Qn
X-Gm-Gg: AR+sD11KKRJD9q3bMFD4v0cI+JthiBFJiE2iyVCTaexsTN19l/DOfqDktxvthIb5V1K
	nZLPdCz/mdbkG8JC5WteYWUcCeEf8DxKY2cEWKTXtWXxXbYILBOS8x28Jp62aC2PbYJ4qB0QHqw
	jnA6PNjotfrUx8wXJ3krupQNKDd0XOQ8wlbN7PBp75fAt/JHTpdtIsmuWrBycbzbNy8ecohyTDy
	kiMGOX6D9FSwYJ/guYE9qrUDvjEwnGwYr8Cb897mb2AhSDz0h/xCkK9PAVRMo1eQNaOhkjtybq8
	ns9/FGDvq6TuBCwoub/P9pA//AmOE8hmLDtHtgVGCRdkDPyrjYkjJehBegMJAyDspugV0L0wzXK
	NTiq5N22EXfVkR9PzvpbL8NaG4b4ticjB8eu74FIgjcSOj2X4ThTusfdlO+PaO+xIaKmbF7Zj6+
	z3jcubONGv62ZgDR69TCNxx4dXYHncVTcAtS0s7JxO8s4igg8Ay5V4+0x4NQRzqPeT21J36JnVw
	mBuNEexXxYP1f2Wru/qYC0a76ajUEUh9qPl
X-Received: by 2002:a05:6102:b0f:b0:739:5f55:3c3c with SMTP id ada2fe7eead31-75b238606fdmr6700069137.13.1785762863829;
        Mon, 03 Aug 2026 06:14:23 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-759b8914dc7sm6054188137.2.2026.08.03.06.14.23
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 06:14:23 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9667ea2fc22so450855241.2
        for <linux-i2c@vger.kernel.org>; Mon, 03 Aug 2026 06:14:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpIGI4Kb9AFMza5eXbyO0G69doWD7WyBNJ+ddXjI42tEapZSCaQqKD6SNOh2b011tceKYfEVLatU/o=@vger.kernel.org
X-Received: by 2002:a05:6102:3ec1:b0:740:177:f357 with SMTP id
 ada2fe7eead31-75b21b5cddamr7351232137.6.1785762863033; Mon, 03 Aug 2026
 06:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727122546.4232-4-wsa+renesas@sang-engineering.com> <20260727122546.4232-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260727122546.4232-6-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Aug 2026 15:14:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVAgjguscFMKd7u1XPuZEkB7mH9-G-Y8nYfXqbzJ2hH9Q@mail.gmail.com>
X-Gm-Features: AUfX_mzjV3ChZNmkKXmVTHVzhvZIDU94wJyunanhT_HiX5hV15YK6vYRfgEHgVU
Message-ID: <CAMuHMdVAgjguscFMKd7u1XPuZEkB7mH9-G-Y8nYfXqbzJ2hH9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] i2c: rcar: add R-Car Gen5 support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Mon, 27 Jul 2026 at 14:26, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> To support the next generation of R-Car SoCs, we need to skip polling
> the reset status. SCMI doesn't support it and the firmware must take
> care of this anyhow. Other than that, the driver works fine as-is.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch, which is now commit 87e713f200481106 ("i2c:
rcar: add R-Car Gen5 support") in i2c/i2c/i2c-next.

> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c

> @@ -900,8 +901,12 @@ static int rcar_i2c_do_reset(struct rcar_i2c_priv *priv)
>         if (ret)
>                 return ret;
>
> -       return read_poll_timeout_atomic(reset_control_status, ret, ret == 0, 1,
> -                                       100, false, priv->rstc);
> +       /* SCMI based resets don't need to poll for success */
> +       if (priv->devtype < I2C_RCAR_GEN5)
> +               return read_poll_timeout_atomic(reset_control_status, ret, ret == 0,
> +                                               1, 100, false, priv->rstc);

How to differentiate between using SCMI and running on bare metal?
The latter still needs polling.

I think you should call reset_control_status() first, and check for
-ENOTSUPP, which would indicate that reset status is not available.

> +
> +       return 0;
>  }
>
>  static int rcar_i2c_master_xfer(struct i2c_adapter *adap,

> @@ -1194,9 +1200,15 @@ static int rcar_i2c_probe(struct platform_device *pdev)
>                         goto out_pm_put;
>                 }
>
> -               ret = reset_control_status(priv->rstc);
> -               if (ret < 0)
> -                       goto out_pm_put;
> +               /*
> +                * Gen5+ uses SCMI based reset which cannot report status.
> +                * Firmware has to ensure proper reset
> +                */
> +               if (priv->devtype < I2C_RCAR_GEN5) {
> +                       ret = reset_control_status(priv->rstc);
> +                       if (ret < 0)
> +                               goto out_pm_put;
> +               }

Likewise, i.e. call reset_control_status() unconditionally, and
ignore -ENOTSUPP.

>
>                 /* hard reset disturbs HostNotify local target, so disable it */
>                 priv->flags &= ~ID_P_HOST_NOTIFY;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
