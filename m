From: Phil Pokorny <ppokorny@penguincomputing.com>
Subject: Re: Please pick up i2c-xlp9xx driver patches
Date: Thu, 1 Feb 2018 22:24:52 -0800
Message-ID: <CAAek22Gk9xKE=EpP1Qg9H0dsethmG4yHonxinG5R6E6fNX48bQ@mail.gmail.com>
References: <CAAek22FfKtt3QzXjcR1WatkFvLuTO5QWSKqCmE7mUGzTG0tZFQ@mail.gmail.com>
 <CAAek22EEs_mHcKg80Ei=FRNH88KVjWJNHHVZ3cU204c0fW8v2w@mail.gmail.com> <20180201081234.d22au6akp5fdz63n@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:41143 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeBBGYx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 2 Feb 2018 01:24:53 -0500
Received: by mail-qk0-f171.google.com with SMTP id l29so22639156qkj.8
        for <linux-i2c@vger.kernel.org>; Thu, 01 Feb 2018 22:24:53 -0800 (PST)
In-Reply-To: <20180201081234.d22au6akp5fdz63n@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Dropping openipmi list cross-post...

On Thu, Feb 1, 2018 at 12:12 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Plaese note that I took over I2C from Jean in late 2012...

Oh.  Jean is still listed in the MAINTAINERS file and I remember
working with him for years on i2c and lm_sensors related codes and
patches.

>> I tested the patches and they fix the ipmi_ssif detection issue I had.
>> So I'm willing to add "Tested-by" to the patches if that helps.
>
> Ehrm, why didn't you do this right away?

Because I only just learned about it 2 days ago.  It took Cavium a
while to get me a pointer to the patch they said would fix my problem.
Said problem I've only had for a couple of weeks since it's brand new
(to me) hardware.

> This helps _a lot_! With these
> tags, I might have considered them earlier. But without tags, they
> surely needed a full development cycle to avoid regressions. Which means
> merge window for v4.17. With tags, I could now consider them for v4.16.

That's great to hear.  I haven't had a chance to contribute much since
the change to Git, so I'm not familiar with the "local customs" and
procedures to add those tags.  Can you help by being specific about
what you need from me?

While the patches did apply to the latest 4.15 kernel tree, there was
some fuzz and I think it would be good to rebase or go over them to
make sure that all the code bits are put in the right places.  I guess
that falls to me to do, but I'm worried we'll miss the 4.16 window
which I would really like to see happen.

> Rule of thumb: If you need patches, show your interest.

Understood and I am...

Phil P.


-- 
Philip Pokorny, RHCE
Chief Technology Officer
PENGUIN COMPUTING, Inc
www.penguincomputing.com

Changing the world through technical innovation
