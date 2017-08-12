From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: mux: rename files to not have superfluous prefixes
Date: Sat, 12 Aug 2017 23:03:56 +0200
Message-ID: <cf6096a6-c25f-86dc-d474-19accedabd36@axentia.se>
References: <20170804090736.13404-1-peda@axentia.se>
 <20170812142625.xugkg2swbuazchug@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0113.outbound.protection.outlook.com ([104.47.1.113]:65456
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752095AbdHLVEI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 12 Aug 2017 17:04:08 -0400
In-Reply-To: <20170812142625.xugkg2swbuazchug@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Peter Korsgaard <peter.korsgaard@barco.com>, Michael Hennerich <michael.hennerich@analog.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>

On 2017-08-12 16:26, Wolfram Sang wrote:
> Hi peda,
> 
>> In the light of the rant from Linus the other week [1], I thought this
>> might be a good idea?
> 
> I am still not decided on this one. I tried to do it with the core files
> and didn't find a convincing solution there. Also, the churn is quite
> high: git history becomes less usable, likely broken references, it is
> not consistent in the kernel anyhow...
> 
> So, I decided to work on real issues for now. The pain point for me is
> not reached yet. But if it is for you (or someone else), I am open to
> look at an subsystem wide solution.

Yeah, there are a few downsides and I agree that the whole i2c subsystem
should be "converted" at the same time, probably directly after some
future rc1. Feel free to use this patch (or an adjusted version) if/when
the time comes, or poke me and I'll redo it.

In other words, I'm not super-committed to this patch, and will just drop
it for now...

Cheers,
Peter
