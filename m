Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEE2C433E0
	for <linux-i2c@archiver.kernel.org>; Thu, 21 Jan 2021 12:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E144F206ED
	for <linux-i2c@archiver.kernel.org>; Thu, 21 Jan 2021 12:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbhAUMTu (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 21 Jan 2021 07:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730949AbhAUMT3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Jan 2021 07:19:29 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9908AC061757
        for <linux-i2c@vger.kernel.org>; Thu, 21 Jan 2021 04:18:48 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id f4so1337456ljo.11
        for <linux-i2c@vger.kernel.org>; Thu, 21 Jan 2021 04:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57AM8icar+jGSxplZHMhnmQzzwwYkYXlIzTACz0r6os=;
        b=mrwPDJW8zJbcrE6VbygJi8d6Nt2bZY1UnmKfpiafqEi+8BH6tlj84OQ4d2stOL1JH2
         g7vhm7cvTeb3S5WBAjUeiNoHeO3k5Uy8ktomtVmtQFufJsrFSrZimK7YqR/YH8ufNcHU
         3lCl3M2eAHhfy7eJmKYnOxHJe8N0PI0WTcLxsakHt1OI8iNj2A9fwaIqDEIEXjJa0tq6
         8QyOskpDggEHFRRtnn/brtamFtio5tHhOOtMchBkrE74oEr/+wPEKiIP848sbbmCVxNZ
         o84OC66Fpt1YwhZ3KqrjJjI3tRvAumGD9OOcmmJGnh+XFTJnk7/zyMS90wirK9rxrZVd
         zYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57AM8icar+jGSxplZHMhnmQzzwwYkYXlIzTACz0r6os=;
        b=O57mFrL9357lp+CLCtMiHw6TV8HyTt7dDXX+4SLACBOLfTx7Kp7Ud/hfYceu+LBei3
         Um73o3C/Sj4RvHConGoQgwkuPR9a1yA7KhlzPpOO7GE3vgAcw/o/c4EDaH8TFfvIZ8M6
         9v/OaHTuLluUD6qhhBZIx9bJZPqdoQZGaSy8yWtpwbAkipSP24tMx3Mk1L/QSqDvyrCA
         smeR3tcb2r8UyUIT8S+ySd89rLFRkV5TTv79UfokEo8ReeUD1qi7fZ8uNVm5oA/OnpSr
         Ay73J3wFPkTZIiZEieM5pWMvFWplnSUnkxfBwVkjOoFFSEzq1nenr81SCx6QaIBq9a+5
         NhNg==
X-Gm-Message-State: AOAM532zyt8S5xoJHV0eZRYFpXLSdU7DoXFWhp0hzw6xvJ6xx/P2iCbd
        IFn4pmC4DL2fWFahUU/BmIOBIXGIg5aEDwgEblScng==
X-Google-Smtp-Source: ABdhPJywRPY4LyL+xF5n+34tfCMmuy4d6FH8zYoKAPB3QO9pVF+5xI5zmXvgGcg+KtqdBQmCxvtgBSEuF4OCSVc1S2I=
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr1096787ljk.74.1611231527091;
 Thu, 21 Jan 2021 04:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20210120132834.2375048-1-arnd@kernel.org> <20210120132834.2375048-3-arnd@kernel.org>
In-Reply-To: <20210120132834.2375048-3-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 13:18:36 +0100
Message-ID: <CACRpkdZEH0DhSuR1Km0LHkV3pMFQ42uexNLgDb1aegLYduiNtg@mail.gmail.com>
Subject: Re: [PATCH 2/3] i2c: remove u300 bus driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Wed, Jan 20, 2021 at 2:28 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The ST-Ericsson U300 platform is getting removed, so this driver is no
> longer needed.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

There is a theoretical possibility that someone else would be using
the driver as it is not actually a U300 thing, "DDC I2C" is probably
used in a bunch of old ST things but I don't think they ever had
mainline support, and with the ARCH guard in Kconfig we should
be safe. If someone needs it later they can resurrect it from git.

Yours,
Linus Walleij
