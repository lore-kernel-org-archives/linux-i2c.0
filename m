From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Fix failure on baytrail
Date: Tue, 13 Feb 2018 16:35:50 +0200
Message-ID: <c5d4a7fc-2d52-9ab5-2a6f-5a5d4e20055c@linux.intel.com>
References: <1518113569-19991-1-git-send-email-gardner.ben@gmail.com>
 <945d4119-5aaf-520f-de2c-a9293f236f13@linux.intel.com>
 <CAE7DoPbMMMbTV5i-fmfhrzKTVoj8Up8aXRYZU9jMh7hKNkkejQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:54884 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933651AbeBMOfa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 13 Feb 2018 09:35:30 -0500
In-Reply-To: <CAE7DoPbMMMbTV5i-fmfhrzKTVoj8Up8aXRYZU9jMh7hKNkkejQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi

On 02/09/2018 05:07 PM, Ben Gardner wrote:
> I bisected the kernel to try to find where this broke, but the answer
> I kept on getting didn't make any sense.
> I think t was this commit:
> 
> 4d6d5f1d08d2138dc43b28966eb6200e3db2e623 i2c: designware: fix rx fifo
> depth tracking
> > Of course, reverting that one commit didn't fix anything.
> So I added a log to the dw_readl() and dw_writel() functions in both a
> working and broken kernel and compared.
> 
Yeah, it's not unusual that bisect diverts into wrong commit especially 
with issues that don't reproduce easily or if some unrelated thing is 
causing also failure at certain step leading to a wrong good/bad guess.

Can you test does reverting my guessed commit 2702ea7dbec5 ("i2c: 
designware: wait for disable/enable only if necessary") fix it?

For linux-stable it is good info to know exactly the commit causing 
regression and mark that in your changelog. It allows linux-stable folks 
to apply fix to earlier kernels and know versions this fix will still 
apply if cannot apply where regression was introduced. Fox example:

Fixes: commit 2702ea7dbec5 ("i2c: designware: wait for disable/enable 
only if necessary")
Cc: linux-stable <stable@vger.kernel.org> # 4.13+

-- 
Jarkko
