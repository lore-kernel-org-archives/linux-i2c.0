Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901D4C433DB
	for <linux-i2c@archiver.kernel.org>; Tue, 23 Feb 2021 22:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658C564ECB
	for <linux-i2c@archiver.kernel.org>; Tue, 23 Feb 2021 22:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhBWWex (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 23 Feb 2021 17:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhBWWcf (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 23 Feb 2021 17:32:35 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BBBC06174A
        for <linux-i2c@vger.kernel.org>; Tue, 23 Feb 2021 14:31:28 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l18so2977932pji.3
        for <linux-i2c@vger.kernel.org>; Tue, 23 Feb 2021 14:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k1RzooZPZP1J4eGG1QIqaiAicm+Bu37ef5lc5yWEgH4=;
        b=t4xgPhOx/fSPdt9GfCu0R0De6/bDyWxmpEoRAnUJr3nOJHDifQWPwxokNt7mbELdv/
         bhXSf11bwUOi27tQcVlvVJPHO1IlOMaYoZugaRUA1LaNr3mDwYkdIZqTisVGAitkICPB
         SksJBCEwx31Zlzzx9qOeouKee4op1oBaHz6DunH3WeM4GcOaLffIiaxJ27Ae9+YfKPry
         MCb8qfSwnexxFOFNvhL1BV9lm+5yUsCqGRDaVHYeSjHKah5yInwLAxwbglzR9X7T/AN+
         uDOEaT977YBIAKlTyM5bpzHZabZwgUGEiJ5ZI/XtQJMq9u9AE+TZe7ellMGmv9G/Ixxn
         Fbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1RzooZPZP1J4eGG1QIqaiAicm+Bu37ef5lc5yWEgH4=;
        b=n0+ks6Nn2W7PXSHEM1pOPTXLMqLPJ1Gsy+I3KNegrny0aKn8xBhi8HwxDAEMyUVsma
         0CXn/Kr9DQ2c59NtrCZQb1Kz7mrFdPDf/iIkrGCpqDlyoyCP6/kelhvPBbue+sIh039o
         HnJVfzBF4dkjjR2tyI5Ux9VkdKD3BmAR1AUo+Lc6/sgLVq44Ji9iZMxrpjTdvxcorUrs
         XAtex4ltiXbuqEGczLyh/fD8psY51AaFr61mO2F0PidyLqkGdwFyocHxWAfNIrOzCCOI
         PaUdenGKzZ27YfSerrdN2zATGMFaelbWXdpuRLev6YIte8iGXOLgXRgAdXYFeqbSNTjv
         Ed7Q==
X-Gm-Message-State: AOAM532kO4b5UBUYxCfN/7LnksdmHZ0ZVXRW/xhQlPVS74f1O/FnU+r2
        t7hO5N0CsthgR6RuOviJbvqhgRuok4v36rg81A1Ekg==
X-Google-Smtp-Source: ABdhPJz6AeMs16zm2xQVDtus3cuIEyeB5wTXLC2MGx6pelc1e0zKNRbFQm3TdaKPHwXT9D9EujJ0ZjjXUTabbAv7Wqg=
X-Received: by 2002:a17:90a:e64a:: with SMTP id ep10mr1079603pjb.20.1614119487708;
 Tue, 23 Feb 2021 14:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20210216182735.11639-1-jae.hyun.yoo@linux.intel.com> <20210216182735.11639-2-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20210216182735.11639-2-jae.hyun.yoo@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 23 Feb 2021 14:31:16 -0800
Message-ID: <CAFd5g44agiB+d5_RuMmL7=exhzUt=aSMEWMEgEkbAZCgH0JbJA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: i2c: aspeed: add transfer mode support
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, Tao Ren <taoren@fb.com>,
        Cedric Le Goater <clg@kaod.org>, linux-i2c@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Tue, Feb 16, 2021 at 10:15 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> Append bindings to support transfer mode.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
