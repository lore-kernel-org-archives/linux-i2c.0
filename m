From: Peter Rosin <peda@axentia.se>
Subject: Re: [PULL REQUEST] i2c for 4.13
Date: Thu, 13 Jul 2017 23:41:51 +0200
Message-ID: <190c2257-8cba-a508-e709-aa096bb97835@axentia.se>
References: <20170712154901.yrrhtwfpnokkmswe@ninjato>
 <CA+55aFzHpnRw6Vw3GNGydzQbxK5SUFKkDH-MLUWPm5r1rAHeDQ@mail.gmail.com>
 <20170713075610.ufck6nxokifamcvs@pengutronix.de>
 <e0787679-9238-8f94-522b-5cfaf4411ccd@axentia.se>
 <CA+55aFwe9wgV3714O9t96M+HZYZ-9qR58bENomi-W1BPJ_UyjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr50137.outbound.protection.outlook.com ([40.107.5.137]:46642
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751153AbdGMVmA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 13 Jul 2017 17:42:00 -0400
In-Reply-To: <CA+55aFwe9wgV3714O9t96M+HZYZ-9qR58bENomi-W1BPJ_UyjA@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 2017-07-13 23:05, Linus Torvalds wrote:
> On Thu, Jul 13, 2017 at 1:57 PM, Peter Rosin <peda@axentia.se> wrote:
>>
>> And if you, like me, sometimes take a peek at the core of several
>> subsystems using emacs, the buffers are either named "core.c<subsys>"
>> or "subsys-core.c". The latter naming is more friendly to tab-completion
>> after ctrl-x b.
> 
> Here's a nickel, Kid. Buy a real editor.

Ahh, thanks for calling me a kid, I think I'll have a shave too.

>    http://i.imgur.com/z96dZ0x.jpg
> 
> If your editor can't show directories, the limitations in your
> environment shouldn't screw over everybody else.

FWIW, I agree that your points made sense. I was just pointing out one
situation were I actually preferred the prefix.

Cheers,
Peter
