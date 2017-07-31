From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: core: Prevent race condition when removing i2c
 devices
Date: Mon, 31 Jul 2017 16:02:01 +0200
Message-ID: <111b974f-8db7-8dd2-18fb-582af47a341b@axentia.se>
References: <20170608024344.9311-1-david.thomson@alliedtelesis.co.nz>
 <20170619143656.zigxk77vegedscjx@ninjato>
 <24ee1e30-1737-e3ef-a23e-01d41a29d45f@axentia.se>
 <2e4c5807-3d3c-1ce2-da35-3e37b2e3b08b@axentia.se>
 <20170731133814.b5lyujdl5iwhcalx@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr40117.outbound.protection.outlook.com ([40.107.4.117]:6336
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751647AbdGaOCI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 31 Jul 2017 10:02:08 -0400
In-Reply-To: <20170731133814.b5lyujdl5iwhcalx@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: David Thomson <david.thomson@alliedtelesis.co.nz>, linux-i2c@vger.kernel.org

On 2017-07-31 15:38, Wolfram Sang wrote:
> On Mon, Jun 19, 2017 at 09:30:06PM +0200, Peter Rosin wrote:
>> On 2017-06-19 18:34, Peter Rosin wrote:
>>> It would certainly be nice to know why .owner is clobbered, because I
>>> don't see it. But then again, I don't know what sources I should be
>>> reading...
>>
>> BTW, one thing I noticed when reading the current code is that I see this
>> at the end of i2c_del_adapter:
>>
>> 	/* Clear the device structure in case this adapter is ever going to be
>> 	   added again */
>> 	memset(&adap->dev, 0, sizeof(adap->dev));
>> }
>> EXPORT_SYMBOL(i2c_del_adapter);
> 
> It was added with commit bd4bc3dbded9cd ("i2c: Clear i2c_adapter.dev on
> adapter removal") with this commit message:
> 
>     i2c: Clear i2c_adapter.dev on adapter removal
> 
>     Clear i2c_adapter.dev on adapter removal. This makes it possible to
>     re-add the adapter at a later point, which some drivers
>     (i2c-amd756-s4882, i2c-nforce2-s4985) actually do.
> 
>     This fixes a bug reported by John Stultz here:
>       http://lkml.org/lkml/2008/7/15/720
>     and by Ingo Molar there:
>       http://lkml.org/lkml/2008/7/16/78
> 
> So, despite the docs, it used to be an issue actually...

What do you mean "despite the docs"? The docs says that you shouldn't
reuse struct device. When you did, you got splats. Zeroing out struct
device happens to work in this case probably because there is a
completion going on around the call to device_unregister(). Without
that completion it would have been seriously wrong to zero out the
struct device, I think. But even with it, I'm not sure it's correct
to do so and worry about rcu grace periods etc. Has any driver model
expert looked at this struct device reuse and blessed it as ok?

Cheers,
Peter
