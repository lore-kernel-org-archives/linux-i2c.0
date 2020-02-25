From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 0/1] i2c: imc: Add support for Intel iMC SMBus host controller.
Date: Tue, 25 Feb 2020 13:49:34 -0800
Message-ID: <CALCETrXcFrR9V_yjPRh9eJ1=1efo_DCCwGTeusmo2CQXpFFdrw@mail.gmail.com>
References: <1582498270-50674-1-git-send-email-schaecsn@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbgBYVts (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Feb 2020 16:49:48 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CB1624650
        for <linux-i2c@vger.kernel.org>; Tue, 25 Feb 2020 21:49:47 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id g3so443031wrs.12
        for <linux-i2c@vger.kernel.org>; Tue, 25 Feb 2020 13:49:47 -0800 (PST)
In-Reply-To: <1582498270-50674-1-git-send-email-schaecsn@gmx.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stefan Schaeckeler <schaecsn@gmx.net>
Cc: linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>

On Sun, Feb 23, 2020 at 2:52 PM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
>
> This patch is based on Andy Lutomirski's iMC SMBus driver patch-set
> https://lkml.org/lkml/2016/4/28/926. It never made it into the kernel. I hope
> this rewrite will:
>
>
> Overview
>
> Modern Intel memory controllers host an SMBus controller and connection to
> DIMMs and their thermal sensors. The memory controller firmware has three modes
> of operation: Closed Loop Thermal Throttling (CLTT), Open Loop Thermal
> Throttling (OLTT) and none.
>
> - CLTT: The memory controller firmware is periodically accessing the DIMM
>   temperature sensor over the SMBus.
>


I think this is great!  One question, though: what happens if the
system is in CLTT mode but you disable CLTT and claim the bus for too
long?  For example, if there's an infinite loop or other lockup which
you have the tsod polling interval set to 0?  Does the system catch
fire or does the system do something intelligent like temporarily
switching to open loop?
