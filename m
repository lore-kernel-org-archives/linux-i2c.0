From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v7 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Tue, 25 Apr 2017 01:00:44 -0700
Message-ID: <CAFd5g46kbNg9wGtT1aHt+oRYHjLBdiEPd1Nu7gZoHe5A9Mn-1g@mail.gmail.com>
References: <20170424181818.2754-1-brendanhiggins@google.com>
 <20170424181818.2754-5-brendanhiggins@google.com> <1493086864.25766.266.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34733 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980934AbdDYIAp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 25 Apr 2017 04:00:45 -0400
Received: by mail-qk0-f178.google.com with SMTP id y63so108316735qkd.1
        for <linux-i2c@vger.kernel.org>; Tue, 25 Apr 2017 01:00:45 -0700 (PDT)
In-Reply-To: <1493086864.25766.266.camel@kernel.crashing.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Joel Stanley <joel@jms.id.au>, Vladimir Zapolskiy <vz@mleia.com>, Kachalov Anton <mouse@mayc.ru>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Ryan Chen <ryan_chen@aspeedtech.com>

Adding Ryan to thread.

>> +static int __aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus,
>> +                                struct platform_device *pdev)
>> +{
>
> Minor nit ... I'm really not fan of those underscores.
>
> We use __ functions in some cases in the kernel for low level
> helpers, usually when it's a low level variant of an existing
> function or an "unlocked" variant, but I don't think generalizing
> it to pretty much everything in the driver is worthwhile here.
>
> If you want to be explicit about locking, I would suggest you
> use a comment in front of the function explaining if it
> expects to be called with the lock held.
>
> We tend to only do that when *both* functions exist and one is
> implemented in term of the other.

Okay, I guess that makes sense. Sorry, I thought the "unlocked"
variant might refer to a function that you have to pay close attention
to the context in which it is called; with as many functions as I have
that require the lock to be held, I would like there to be some way to
say the function is "unsafe," but I guess if there is no convention to
do that, then there is no convention to do that.
