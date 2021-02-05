Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5426AC433E0
	for <linux-i2c@archiver.kernel.org>; Fri,  5 Feb 2021 23:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0BA64FAE
	for <linux-i2c@archiver.kernel.org>; Fri,  5 Feb 2021 23:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhBEXQs (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 5 Feb 2021 18:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhBEKeB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 5 Feb 2021 05:34:01 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A413BC06178C
        for <linux-i2c@vger.kernel.org>; Fri,  5 Feb 2021 02:33:20 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p20so11133894ejb.6
        for <linux-i2c@vger.kernel.org>; Fri, 05 Feb 2021 02:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nakZx3zOEZLUUZAMILq/ar1r+Acw84d9yqhqJi2BCQ4=;
        b=MCaRB/yhouM+RasCXL7nWTII8zlWlMUWJAulO8jiC92x8qY3zCz/ZGArDm64ac/QVu
         VLQM9j87YSDa3s86JmjFuS0nHbLZedPdvmtL7t/YozzV3TlB5BwbFOu+tbzemhs3XjDv
         qQyeiCfX55uvYTwtzs6Qm0U0ROsgSkXHI7zsFMI84+S4aUpEwnJLT1sb0s1QqxH9N76H
         aFcfa1C0x/QwJzp1/IMOouUvIXzmYNBHSoMxXokMqH3fjYiacgwIGHe51hPP5gTubOXT
         tttNxPaUJCMjFmYYAT2UziRm1+BKsTzMNXOhAzCsl9vWOXkAutzGpRf1FXkTdXqnALF8
         W4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nakZx3zOEZLUUZAMILq/ar1r+Acw84d9yqhqJi2BCQ4=;
        b=UDbmNwqrUbgmap1QqOUqCtTBJ4WsWqD8538rIPfNHmL3oSimvK/Pm9rqkLPTpffYMr
         cntx4lPloeGE2O6XMLqqH5UF+PmzYZXDOzaHekAn4hsGbH0wqQt9USKzEWPRcsSexLQM
         DOHMH10u5uOHfd0Y7JMdmiIMiRc31C0QYKDbkyrCpZL+/UExEGoAVdCBLRy8f+bqsUm8
         ZQWWNDmmT3UF3FzQ0I3nBb21Y8rNAtW5v8KpRzjObEFZwUsUya7KMdAeo5uZjHF0WP+0
         ZozeT6jBh+zXYqZ3rGqChDkJCsLz06NQr+eAeJ5mQZe/4SmKcUV6XgdLqe9NWh13kr1b
         Js+g==
X-Gm-Message-State: AOAM530sNNfgsMFUwJNyOi/FP5ha0jCrVgjWXztRsIm8d+4xPFJzVP59
        EdOrSpfOq3291bvNmQLCWdgY70lKbn4Y7RHoOhuAjg==
X-Google-Smtp-Source: ABdhPJyHaqQrjRO5cpqMINsa6mjFq2ZDnqJ4rhd+YTk+15U1aHYwn6Iulgfm+QqVy4Lfq+NfF6kym99R3LGVRL0xXUA=
X-Received: by 2002:a17:906:8053:: with SMTP id x19mr3388210ejw.470.1612521199418;
 Fri, 05 Feb 2021 02:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20210128111343.2295888-1-geert+renesas@glider.be>
 <20210128113353.GN963@ninjato> <CAMuHMdW--A2bwe==+A35_sLAS2OkXzi2hY0Ky_dwL0n8irHMZw@mail.gmail.com>
In-Reply-To: <CAMuHMdW--A2bwe==+A35_sLAS2OkXzi2hY0Ky_dwL0n8irHMZw@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 5 Feb 2021 11:33:08 +0100
Message-ID: <CAMpxmJXcbTnCbseAap=F0QO2Er6ANGSfgPMuoufaD2qQyUbpRA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: eeprom: at24: Document ROHM BR24G01
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Thu, Jan 28, 2021 at 12:59 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Wolfram,
>
> On Thu, Jan 28, 2021 at 12:33 PM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > On Thu, Jan 28, 2021 at 12:13:43PM +0100, Geert Uytterhoeven wrote:
> > > Document the compatible value for the ROHM Semiconductor BR24G01 I2C bus
> > > EEPROM.
> >
> > What is the difference between those two? Could one also be the fallback
> > of the other (just in the highly unlikely case we need "generic" Rohm
> > handling somewhen)?
>
> Good question.  The datasheets look similar.
> Parametric search on rohm.com says the G-series differs in using
> "Cu wire bonding".
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

I'm fine with the current form as it's simpler than using two
fallbacks. Do you want to submit another version anyway or can I pick
it up?

Bartosz
