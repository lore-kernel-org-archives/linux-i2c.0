From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 0/3] i2c: mux: pca954x: Add interrupt controller
 support
Date: Fri, 10 Feb 2017 22:46:15 +0100
Message-ID: <3632e933-6bc9-4d40-f489-1af958f0fd4b@axentia.se>
References: <1485307868-5408-1-git-send-email-preid@electromag.com.au>
 <8a11d374-a9f9-0e58-d01f-1cc72827c5e9@axentia.se>
 <20170210125205.c2gzgi65x4bi3eys@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0108.outbound.protection.outlook.com ([104.47.1.108]:33664
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750874AbdBJVqW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 10 Feb 2017 16:46:22 -0500
In-Reply-To: <20170210125205.c2gzgi65x4bi3eys@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On 2017-02-10 13:52, Wolfram Sang wrote:
> Hi Peter,
> 
>> initializer for the 'handled' variable. I amended the previously
>> posted fixup and was just about to send you the pull request when
>> you started to add patches to i2c/for-next.
> 
> Oh, sorry! I wasn't sure if we agreed that you send pull-requests for
> v4.11 already or starting with v4.12. And since there seems to be no rc8
> for 4.11 I decided to start pulling in.

FWIW, I think you did the right thing, and it was me that should have
been clearer from the start. No big thing, just a few patches.

> Build testing plus sparse+smatch testing for the patches when I apply
> them to my tree and then having my branches additionally checked by
> build bot works well for me. I will happily share my super-simple
> 'ninja-check' script with you which runs various code checkers when
> compiling. It is basically adding "W=1 C=1 CHECK='ninja-check'" to the
> kernel build command-line.
> 
> I hope you are open for this workflow. But we can discuss, of course.

No trouble at all, and I'll certainly have a look at the script, so
please send it my way. Thanks!

>> The question then becomes at approximately which point you'll need
>> a pull request? Or should you perhaps be pulling in my tree
>> on a more continuous level so that everything i2c-related is
>> available in one tree (i.e. your tree)?
> 
> I prefer pull requests a little bit. Then, I get a consistent state
> approved by you and already checked by build bot. BTW is your tree in
> linux-next as well?

Nope, it's not, but I intend to fix that for the next round. Ok, I think
we have a sane plan, people should be testing linux-next anyway...

Cheers,
Peter
