From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL REQUEST] i2c for 4.13
Date: Wed, 12 Jul 2017 10:16:32 -0700
Message-ID: <CA+55aFzHpnRw6Vw3GNGydzQbxK5SUFKkDH-MLUWPm5r1rAHeDQ@mail.gmail.com>
References: <20170712154901.yrrhtwfpnokkmswe@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34984 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753485AbdGLRQe (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 12 Jul 2017 13:16:34 -0400
In-Reply-To: <20170712154901.yrrhtwfpnokkmswe@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Jul 12, 2017 at 8:49 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>  drivers/i2c/i2c-core-acpi.c                        |  665 ++++++++
>  drivers/i2c/{i2c-core.c => i2c-core-base.c}        | 1684 +-------------------
>  drivers/i2c/i2c-core-of.c                          |  276 ++++
>  drivers/i2c/i2c-core-slave.c                       |  115 ++
>  drivers/i2c/i2c-core-smbus.c                       |  594 +++++++
>  drivers/i2c/i2c-core.h                             |   24 +
>  drivers/i2c/i2c-stub.c                             |   14 +-

Side note on this.. (and doesn't affect the pull - I pulled it and
it's going through my test build right now).

Please don't do the silly "start every filename with the same prefix".
It annoys people (ie me) that use tab-completion, and it just looks
stupid.

And this core re-org does it twice over - first with "i2c-" and then
with "core-".

Of *course* it's "i2c-something.c" - it's in the i2c directory. So
that part is entirely pointless.

And the "core-something.c" part seems to be entirely to keep the files
together - but if the issue really is "sort files together", then
that's why we have subdirectories.

So I personally tend to much prefer

   drivers/i2c/core/acpi.c
   drivers/i2c/core/base.c
   drivers/i2c/core/of.c
   drivers/i2c/core/slave.c
   drivers/i2c/core/smbus.c
   drivers/i2c/core/core.h

as the model. Then things *really* sort together, auto-complete works
better, and tools like "git diff --dirstat" etc that group changes by
directories also automatically just do the right thing.

And notice how the filenames are smaller and prettier too? It's just a
win/win situation.

But I'm not going to enforce my style guide on you, since I very
seldom actually end up touching those files. If this was some area
where I often actually ended up looking at things, I'd almost require
a sane directory structure, though.

Because "name things with the same prefix" is not a sane directory structure.

               Linus
