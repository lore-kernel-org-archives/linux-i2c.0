From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] i2c: mux: fix up dependencies
Date: Mon, 14 Nov 2016 15:30:15 +0100
Message-ID: <CACRpkdYsMupk6DtzWxyCchi=Zv2aSGcV4zkxj=V28fxij-ZedQ@mail.gmail.com>
References: <1479128586-17052-1-git-send-email-linus.walleij@linaro.org> <3ba9773a-b32b-1be3-cf27-2c4e7842197f@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34917 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932164AbcKNOaR (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Nov 2016 09:30:17 -0500
Received: by mail-qk0-f175.google.com with SMTP id n204so97046808qke.2
        for <linux-i2c@vger.kernel.org>; Mon, 14 Nov 2016 06:30:16 -0800 (PST)
In-Reply-To: <3ba9773a-b32b-1be3-cf27-2c4e7842197f@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, stable <stable@vger.kernel.org>, Jonathan Cameron <jic23@jic23.retrosnub.co.uk>

On Mon, Nov 14, 2016 at 2:59 PM, Peter Rosin <peda@axentia.se> wrote:

> It is not obvious to me that the i2c mux is dependent on
> CONFIG_OF. Sure, there are unconditional calls to things like
> of_property_read_u32 etc, but those are meant to be compiled
> away for the !CONFIG_OF case. I think. The code predates me,
> but that's how I read it...
(...)
> But don't add "depends on OF", or am I missing something?

Yeah that's right I guess. It can also use ACPI.

I'll update.

Yours,
Linus Walleij
