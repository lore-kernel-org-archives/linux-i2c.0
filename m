From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [GIT PULL REQUEST] at24 updates for 4.16
Date: Thu, 4 Jan 2018 10:04:57 +0100
Message-ID: <CAMRc=MfNKbykgAvhRpuk=x8PFM2JvgK6rwpPvhc+tjRbzA=f_g@mail.gmail.com>
References: <20180103160113.28561-1-brgl@bgdev.pl> <20180103215433.n5lmyzzgc5auub2m@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44645 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeADJE7 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 4 Jan 2018 04:04:59 -0500
Received: by mail-ot0-f196.google.com with SMTP id g59so793635otg.11
        for <linux-i2c@vger.kernel.org>; Thu, 04 Jan 2018 01:04:59 -0800 (PST)
In-Reply-To: <20180103215433.n5lmyzzgc5auub2m@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2018-01-03 22:54 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> On Wed, Jan 03, 2018 at 05:01:13PM +0100, Bartosz Golaszewski wrote:
>> Hi Wolfram,
>>
>> The following changes since commit 30a7acd573899fd8b8ac39236eff6468b195ac7d:
>>
>>   Linux 4.15-rc6 (2017-12-31 14:47:43 -0800)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/at24-4.16-updates-for-wolfram
>
> Thanks, pulled!
>
> Note: patchwork still doesn't recognize your pull requests, but I don't
> understand why :( So, please ping me if I don't pull within a few days.
>

Strange indeed. Is feeding the output of 'git request-pull' to 'mail'
the correct way of sending pull requests?

While we're at it - if you'll choose to pick up the series from
Heiner[1] for 4.16, you can take all three patches in, I'll leave my
Reviewed-by in patch 3/3.

Best regards,
Bartosz Golaszewski

[1] http://patchwork.ozlabs.org/project/linux-i2c/list/?series=19586
