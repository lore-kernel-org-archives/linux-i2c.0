From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: core: Prevent race condition when removing i2c
 devices
Date: Fri, 18 Aug 2017 10:04:21 +0200
Message-ID: <bab6e8e3-dca5-1d2a-309d-fe29b115ae49@axentia.se>
References: <20170608024344.9311-1-david.thomson@alliedtelesis.co.nz>
 <20170619143656.zigxk77vegedscjx@ninjato>
 <24ee1e30-1737-e3ef-a23e-01d41a29d45f@axentia.se>
 <2e4c5807-3d3c-1ce2-da35-3e37b2e3b08b@axentia.se>
 <1498688452141.89697@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0121.outbound.protection.outlook.com ([104.47.1.121]:48032
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750810AbdHRIE2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 18 Aug 2017 04:04:28 -0400
In-Reply-To: <1498688452141.89697@alliedtelesis.co.nz>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Thomson <David.Thomson@alliedtelesis.co.nz>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On 2017-06-29 00:20, David Thomson wrote:
> On 2017-06-19 18:34, Peter Rosin wrote:
>> It would certainly be nice to know why .owner is clobbered, because I
>> don't see it. But then again, I don't know what sources I should be
>> reading...
> Hi Peter
> 
> Thanks for your reply. Unfortunately we cannot reproduce the issue on a newer kernel as it requires userspace applications (for processing the hotswap) that rely on our (many) changes to the kernel. I appreciate you taking the time to consider the issue.

Still interested in what base version you have and if there are any
patches of relevance to the i2c subsystem... The oldest mainline
that had i2c_del_mux_adapter is v4.6 (May 2016), so I had a second
look at that. Could you also tell us what i2c-mux driver this is
and whether it is expected that .owner is NULL in the first place? In
other words, is the i2c-mux driver in question built-in or a loaded
module?

If you have not added any new i2c-mux driver (which I doubt, you
would surely have mentioned that) the only way that this race can
happen is if the driver is removed twice since i2c_del_mux_adapter
is only called in .remove (and in .probe on failure, but I don't
think that can race). At least that's the case for the i2c-mux drivers
that I looked at...

It seems pretty serious that a driver can have its .remove called
twice so I suspect your patch just papers over a much bigger problem?

So, why is the i2c-mux driver being removed more than once? The
module refcounting must be badly screwed up for that to happen. Or?

Cheers,
Peter
