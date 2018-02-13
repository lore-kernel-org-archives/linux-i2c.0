From: Ben Gardner <gardner.ben@gmail.com>
Subject: Re: [PATCH] i2c: designware: Fix failure on baytrail
Date: Tue, 13 Feb 2018 10:31:04 -0600
Message-ID: <CAE7DoPY8z=dWcTxumkLfwtNhCa-NfEnuXGW=1y2A2B+YzdKjzA@mail.gmail.com>
References: <1518113569-19991-1-git-send-email-gardner.ben@gmail.com>
 <945d4119-5aaf-520f-de2c-a9293f236f13@linux.intel.com> <CAE7DoPbMMMbTV5i-fmfhrzKTVoj8Up8aXRYZU9jMh7hKNkkejQ@mail.gmail.com>
 <c5d4a7fc-2d52-9ab5-2a6f-5a5d4e20055c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:37428 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934651AbeBMQbG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 13 Feb 2018 11:31:06 -0500
Received: by mail-it0-f43.google.com with SMTP id d10so5574656itj.2
        for <linux-i2c@vger.kernel.org>; Tue, 13 Feb 2018 08:31:05 -0800 (PST)
In-Reply-To: <c5d4a7fc-2d52-9ab5-2a6f-5a5d4e20055c@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

> Can you test does reverting my guessed commit 2702ea7dbec5 ("i2c:
> designware: wait for disable/enable only if necessary") fix it?

I verified that reverting 2702ea7dbec5 ("i2c: designware: wait for
disable/enable only if necessary") also fixes the issue.
Not waiting when disabling the adapter seems perfectly fine. Not
waiting when enabling is the problem.

> For linux-stable it is good info to know exactly the commit causing
> regression and mark that in your changelog. It allows linux-stable folks to
> apply fix to earlier kernels and know versions this fix will still apply if
> cannot apply where regression was introduced. Fox example:
>
> Fixes: commit 2702ea7dbec5 ("i2c: designware: wait for disable/enable only
> if necessary")
> Cc: linux-stable <stable@vger.kernel.org> # 4.13+

Do you want me to resubmit this patch with the above lines (Fixes and
Cc) added or are you willing to add the appropriate lines and take
care of it?
I suppose the commit message could use some rewording, now that the
issue seems a bit clearer.

Thanks,
Ben
