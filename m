Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54FDC433FE
	for <linux-i2c@archiver.kernel.org>; Mon, 23 May 2022 08:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiEWIAy (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 23 May 2022 04:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiEWIAv (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 23 May 2022 04:00:51 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9569A16593;
        Mon, 23 May 2022 01:00:49 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id x65so7990604qke.2;
        Mon, 23 May 2022 01:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78dk875LafIfDiQAHXpXdnt3YIhTksx5eQ10JxEZ2W4=;
        b=dx/LACimog30dDhKTx5qh8+OtZNpQ4RZTGeyV0DnrR/+zgklBizNkQ+C7M/3RsGwcp
         obvXxrrZlz0YfMKQdr5d01mtwfIBuzDo3UeGiFEnT5+hafXWLJPfU1FT0rkwh2LnkDCh
         RKpFdof+8JhcC/8qEQhQFmhOe8sKL7QE11pkN0j4/LKYFzVzawL++TaTLa4pDR9USfkn
         6sjig+3fWsPcUjiFFiILAZU5Xdh2S8+njdJ53rHYAibTn1TDgKRwcoC1b0fPu8qBLuLl
         buiRK3om9IJFDEbta9pxPHo5vinpZNB/DqWFfLVXpTbdTHYFsvdBBkRFjAY1OGzAnXPs
         zffg==
X-Gm-Message-State: AOAM531BDp8+GdxzIwVcymmof8jbeZTKQuv5aAlYJDZvbVynahtoDvQR
        Sh6IYSnI8SzO16hqYIAeOWqMNJquAGP3vw==
X-Google-Smtp-Source: ABdhPJxlyZH0qzYNPIYegu9AFGKM06lQUh6v+/CwZPs41YoDkRqJLr2isyyJrMT7vXVTTz5YBBKpGw==
X-Received: by 2002:a37:a6d5:0:b0:6a3:4872:32fb with SMTP id p204-20020a37a6d5000000b006a3487232fbmr10154136qke.588.1653292848625;
        Mon, 23 May 2022 01:00:48 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id t5-20020a05620a004500b0069fc13ce24asm3894961qkt.123.2022.05.23.01.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 01:00:48 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id b124so11982576ybg.12;
        Mon, 23 May 2022 01:00:48 -0700 (PDT)
X-Received: by 2002:a25:e04d:0:b0:64d:6f23:b906 with SMTP id
 x74-20020a25e04d000000b0064d6f23b906mr20256218ybg.380.1653292848029; Mon, 23
 May 2022 01:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220520202918.17889-1-wsa+renesas@sang-engineering.com> <20220520202918.17889-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220520202918.17889-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 May 2022 10:00:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWiAQRYUafh5874dA599BxSXa8=g=5ya0XQ63Xffn=Spg@mail.gmail.com>
Message-ID: <CAMuHMdWiAQRYUafh5874dA599BxSXa8=g=5ya0XQ63Xffn=Spg@mail.gmail.com>
Subject: Re: [PATCH 1/3] i2c: rcar: use BIT macro consistently
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux I2C <linux-i2c@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Sat, May 21, 2022 at 5:39 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Easier to read and ensures proper types.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
