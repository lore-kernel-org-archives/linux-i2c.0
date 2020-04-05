From: Stefan Schaeckeler <schaecsn@gmx.net>
Subject: Re: [PATCH 0/1] i2c: imc: Add support for Intel iMC SMBus host
 controller.
Date: Sun,  5 Apr 2020 14:40:59 -0700 (PDT)
Message-ID: <20200405214059.91F97899799@corona.crabdance.com>
References: <1582498270-50674-1-git-send-email-schaecsn@gmx.net>
 <CALCETrXcFrR9V_yjPRh9eJ1=1efo_DCCwGTeusmo2CQXpFFdrw@mail.gmail.com> <20200405180510.GD6313@kunai>
Reply-To: schaecsn@gmx.net
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:44335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgDEVlI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 5 Apr 2020 17:41:08 -0400
In-reply-to: <20200405180510.GD6313@kunai> (message from Wolfram Sang on Sun,
        5 Apr 2020 20:05:10 +0200)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: luto@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com

Hello Wolfram,

> > > This patch is based on Andy Lutomirski's iMC SMBus driver patch-set
> > > https://lkml.org/lkml/2016/4/28/926. It never made it into the kerne=
l. I hope
> > > this rewrite will:
> > >
> > >
> > > Overview
> > >
> > > Modern Intel memory controllers host an SMBus controller and connect=
ion to
> > > DIMMs and their thermal sensors. The memory controller firmware has =
three modes
> > > of operation: Closed Loop Thermal Throttling (CLTT), Open Loop Therm=
al
> > > Throttling (OLTT) and none.
> > >
> > > - CLTT: The memory controller firmware is periodically accessing the=
 DIMM
> > >   temperature sensor over the SMBus.
> > >
> >
> >
> > I think this is great!  One question, though: what happens if the
> > system is in CLTT mode but you disable CLTT and claim the bus for too
> > long?  For example, if there's an infinite loop or other lockup which
> > you have the tsod polling interval set to 0?  Does the system catch
> > fire or does the system do something intelligent like temporarily
> > switching to open loop?
>
> Any news on this question?

Thank you for your interest in this patch. You can read my reply here
https://lkml.org/lkml/2020/3/1/216

 Stefan
