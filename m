From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 0/1] i2c: imc: Add support for Intel iMC SMBus host controller.
Date: Sun, 5 Apr 2020 15:51:29 -0700
Message-ID: <CALCETrVUWEOwpMOLAPieU5mffaA6vJPWQov5N82gtcBo04JsyA@mail.gmail.com>
References: <1582498270-50674-1-git-send-email-schaecsn@gmx.net>
 <CALCETrXcFrR9V_yjPRh9eJ1=1efo_DCCwGTeusmo2CQXpFFdrw@mail.gmail.com>
 <20200405180510.GD6313@kunai> <20200405214059.91F97899799@corona.crabdance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbgDEWvm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 5 Apr 2020 18:51:42 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0456A2074B
        for <linux-i2c@vger.kernel.org>; Sun,  5 Apr 2020 22:51:42 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id j17so15129556wru.13
        for <linux-i2c@vger.kernel.org>; Sun, 05 Apr 2020 15:51:41 -0700 (PDT)
In-Reply-To: <20200405214059.91F97899799@corona.crabdance.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stefan Schaeckeler <schaecsn@gmx.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, Andrew Lutomirski <luto@kernel.org>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

On Sun, Apr 5, 2020 at 2:41 PM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
>
> Hello Wolfram,
>
> > > > This patch is based on Andy Lutomirski's iMC SMBus driver patch-set
> > > > https://lkml.org/lkml/2016/4/28/926. It never made it into the kernel. I hope
> > > > this rewrite will:
> > > >
> > > >
> > > > Overview
> > > >
> > > > Modern Intel memory controllers host an SMBus controller and connection to
> > > > DIMMs and their thermal sensors. The memory controller firmware has three modes
> > > > of operation: Closed Loop Thermal Throttling (CLTT), Open Loop Thermal
> > > > Throttling (OLTT) and none.
> > > >
> > > > - CLTT: The memory controller firmware is periodically accessing the DIMM
> > > >   temperature sensor over the SMBus.
> > > >
> > >
> > >
> > > I think this is great!  One question, though: what happens if the
> > > system is in CLTT mode but you disable CLTT and claim the bus for too
> > > long?  For example, if there's an infinite loop or other lockup which
> > > you have the tsod polling interval set to 0?  Does the system catch
> > > fire or does the system do something intelligent like temporarily
> > > switching to open loop?
> >
> > Any news on this question?
>
> Thank you for your interest in this patch. You can read my reply here
> https://lkml.org/lkml/2020/3/1/216

I think it could make sense to upstream this driver but to require a
scary boot-time option to enable it.  Maybe i2c_imc.dangerous=1?

>
>  Stefan
