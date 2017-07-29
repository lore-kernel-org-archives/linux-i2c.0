From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2 1/1] i2c: aspeed: add proper support fo 24xx clock params
Date: Fri, 28 Jul 2017 17:06:02 -0700
Message-ID: <CAFd5g45O7rJymFgnWj3SnSKhCvXoX4_xCO8FqeBFCe0-Du9AYg@mail.gmail.com>
References: <20170728204558.6455-1-brendanhiggins@google.com>
 <20170728204558.6455-2-brendanhiggins@google.com> <CAPLgG==69mNpqoqKUf-0tT4iJJ5-aCg+1uaAoLJ5QSe+8LGYkw@mail.gmail.com>
 <CAPLgG=kUxfriYRq-fc+AD=eo1T+6xa4imzda7Fd_aXmAb2pD3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:37746 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752987AbdG2AGD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 28 Jul 2017 20:06:03 -0400
Received: by mail-qk0-f175.google.com with SMTP id z18so45790425qka.4
        for <linux-i2c@vger.kernel.org>; Fri, 28 Jul 2017 17:06:03 -0700 (PDT)
In-Reply-To: <CAPLgG=kUxfriYRq-fc+AD=eo1T+6xa4imzda7Fd_aXmAb2pD3Q@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rick Altherr <raltherr@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Robi Buranyi <rburanyi@google.com>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jul 28, 2017 at 2:00 PM, Rick Altherr <raltherr@google.com> wrote:
> Is clk_fractional_divider from include/linux/clk-provider.h appropriate here?
>

Alas, no. clk_fractional_divider is not flexible enough to specify the
divider the
way that it is represented in the Aspeed 24xx/25xx parts which have the divider
expressed as a "base clock" which is always a power of 2 along with the time
where SCL is high and the time that the SCL is low in units of base clock.
Thus, there are two separate "numerator" values and the denominator is
represented as the ilog2 of the actual value.

That being said, I could implement this as a custom clock subclass, which
would probably be cleaner that what I have done.
