From: Peter Rosin <peda@axentia.se>
Subject: Re: i2c-mux adapter names not unique
Date: Mon, 13 Mar 2017 15:48:56 +0100
Message-ID: <26e08683-2bdb-4c8e-bd6e-b4887bc26dc3@axentia.se>
References: <CAAuRgKAVRUKCYdZAH3Atn4d09OmubUZN2trNRQ4aEZkEey6WNg@mail.gmail.com>
 <0cf3f298-87ab-0dfc-9453-cc46e31d4979@axentia.se>
 <CAAuRgKAYgBjk=FhQfMsGdOB+-4ObUkYgWVb-Uu+0wgM+ORWOug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr40100.outbound.protection.outlook.com ([40.107.4.100]:23864
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751061AbdCMOtE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 13 Mar 2017 10:49:04 -0400
In-Reply-To: <CAAuRgKAYgBjk=FhQfMsGdOB+-4ObUkYgWVb-Uu+0wgM+ORWOug@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: MikeB <mabnhdev@gmail.com>
Cc: linux-i2c@vger.kernel.org

On 2017-03-13 15:00, MikeB wrote:
> On Mon, Mar 13, 2017 at 9:34 AM, Peter Rosin <peda@axentia.se> wrote:
>>> Any suggestions on how to modify i2c-mux.c to make these names unique?
>>
>> Why do they have to be unique?
>>
> I am porting OpenSwitch (www.openswitch.net) to a new platform that
> has a topology as above.  OpenSwitch uses i2c adapter names to bind
> i2c adapter devices to internal i2c adapters.  It assumes that
> adapters are given unique names.

As indicated by the part you elided, that appears to be a bad assumption.

> The presumption based on current i2c-mux behavior was that i2c adapter
> names would be unique.  I knew this would cause problems for
> OpenSwitch sooner or later.  It's sooner for me.
> 
> I've patched my local kernel to add the mux address to the name -
> "i2c-<parent adapter id>-mux-<mux addr> (chan_id <id>)" which does
> result in unique names.  However, my patch only works on topologies
> that use only pca954x muxes.  I'd prefer a patch that could work for
> all topologies.

And why not fix the bad assumption in OpenSwitch instead and kill the
generic problem for every kind of adapter? Limiting yourself to a
band-aid for i2c-mux adapters seems short-sighted and not very helpful
for the next victim of this OpenSwitch problem...

Note that you do not need two muxing levels to get duplicate names like
this, it's enough with two parallel multiplexers on the root adapter. Or,
of course, two AT91 adapters (or similar, i.e. with a fixed name).

Cheers,
peda
