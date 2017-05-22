From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL REQUEST] i2c for 4.12
Date: Mon, 22 May 2017 13:11:21 -0700
Message-ID: <CA+55aFyzSD3Gt9JqGvfyyaujYnGi+kQz3vDho6LBZG+Xz2qqNA@mail.gmail.com>
References: <20170519204014.jumojwrdw6lfnycw@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34411 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758330AbdEVULX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 May 2017 16:11:23 -0400
In-Reply-To: <20170519204014.jumojwrdw6lfnycw@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, May 19, 2017 at 1:40 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> here is a regression fix for I2C that would be great to have in rc2
> already. Based on your tree from today. Please pull.

Gaah. I hadn't tested this on my laptop, and instead of beign a
regression fix, this looks like a new regression. My touchpad on the
xps 13 9350 no longer works after this.

Now, I'm not 100% certain it is this particular change, but I'm about
half-way through the bisection, and this is the only thing that looks
even remotely likely.

And yes, the xps13 does use i2c_designware for the touchpad.

I'll finish the bisection just top be sure, but the rest in there
really looks like kvm stuff etc that shouldn't possibly affect the
touchpad.

So this commit will almost certainly be reverted unless somebody can
figure out why it breaks.

                   Linus
