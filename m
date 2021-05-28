Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15214C2B9F7
	for <linux-i2c@archiver.kernel.org>; Fri, 28 May 2021 14:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B80613C9
	for <linux-i2c@archiver.kernel.org>; Fri, 28 May 2021 14:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhE1Oz4 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 28 May 2021 10:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbhE1Ozy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 28 May 2021 10:55:54 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D236AC061574;
        Fri, 28 May 2021 07:54:18 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y2so5830922ybq.13;
        Fri, 28 May 2021 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=T35D64bBU0WW7+1maAxJ4aFWgw+2odUz3cLA7+UMgEI=;
        b=DSqqgWowfLrIWaQ4G8FQP8D/Mv3uukUZsXi2LrtxNR8IH8Y9O/NT4D7B4Vh5dUSx8h
         mLZ+de7qnQF5uIUxdO879yC28hjn6Na8tAdHKbXH9rIwoej2zJzDUeIatOThVFIE2mO7
         ASWd0Fy648tunLsP0IFZaviDRP9qhL3qljPexrscb456pFL4H/6WDNHySEAWcU5ZYhxk
         h31+dOy5rTjEBJg0S9x2vrxGQAyrhCwForLfjRl3dy+r5fc4WVVc/+HvZCHCL3ccNYcm
         k6xoE+XL/yido36VaiSPRMAZy86JeXns+++SPuUGGsOrltHcKLcGtmb2F4JX+faRxIAo
         Q9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=T35D64bBU0WW7+1maAxJ4aFWgw+2odUz3cLA7+UMgEI=;
        b=BskphTbhcPxsVQe8pJMYmcSzsFrFQaJ/MIuYzNVsBM9e9soQURBXv9iOTZpygT2mse
         3vBcG6YPFGVhj6LXzKWWdPVYhNFGR6j9tOWXnYyaoxVE1TqvS8teqeYaeJ5WMj9cTnen
         OVHb8IlhFDhE5ao5Jnmq1kyxCYI0NR8P9AvT9ggghKDO91Vu67C+1gZe/En8AOA4lPdO
         glxLWsDgzjG3ZF0muJVt4D6FgNSmnr+VhpCtSAzk4RRw2vreuz3yRoY/xzBinUKILrl5
         w7Z0EA5O7giJIw3OBWG0t4RxQcjeTJl3Y0+UVDEgq1CIi0uTTL1lJeq7pW6ES3BGaAet
         JyWg==
X-Gm-Message-State: AOAM531ywJW+9afu5tQQWcnyKC91Tyx8Rw39P2ScUlmHoW/2/6TNTuCw
        4bLE6HLN3sKlH7IPNpX74/7wJt9i+9g9CFKeOt4=
X-Google-Smtp-Source: ABdhPJxmdZtok+h3/xyZHsCmdxnesIbAJ+0wLcRSBoka8XapjX0i5YvSL5vVLLAqka8KNoHwNxt11mLqAF6IUvvAWBM=
X-Received: by 2002:a5b:90d:: with SMTP id a13mr13476356ybq.151.1622213657995;
 Fri, 28 May 2021 07:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210419061809.15045-1-lukas.bulwahn@gmail.com>
 <CAHp75Vfv0FQGXrmpDveOf-cBahoDK3uSPHjPU2RNh6mhFxN7vQ@mail.gmail.com>
 <YLD/ZQiX5VhpWJg7@smile.fi.intel.com> <YLECsC9y8ici47Ln@kunai>
In-Reply-To: <YLECsC9y8ici47Ln@kunai>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 28 May 2021 16:54:06 +0200
Message-ID: <CAKXUXMwB5-7b8XsO=3jq2VxMf-C92VSYBTCArkLF+hhkKWHSzw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust to removing i2c designware platform data
To:     Wolfram Sang <wsa@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Fri, May 28, 2021 at 4:48 PM Wolfram Sang <wsa@kernel.org> wrote:
>
>
> > > > Remove the file entry to this removed file as well.
> > >
> > > Oops, I was under the impression I grepped all occurrences, but I have not.
> > >
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > >
> > > Thanks for the catch!
> >
> > Wolfram, isn't it forgotten somehow?
>
> I can pick it. I refrained from doing so because Lukas explicitly asked
> Lee to pick it.
>

Wolfram, take it. Nobody compiles MAINTAINERS, so it cannot break any build :)

Thanks, Lukas
