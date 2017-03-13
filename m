From: MikeB <mabnhdev@gmail.com>
Subject: Re: i2c-mux adapter names not unique
Date: Mon, 13 Mar 2017 10:00:09 -0400
Message-ID: <CAAuRgKAYgBjk=FhQfMsGdOB+-4ObUkYgWVb-Uu+0wgM+ORWOug@mail.gmail.com>
References: <CAAuRgKAVRUKCYdZAH3Atn4d09OmubUZN2trNRQ4aEZkEey6WNg@mail.gmail.com>
 <0cf3f298-87ab-0dfc-9453-cc46e31d4979@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35027 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdCMOAL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 13 Mar 2017 10:00:11 -0400
Received: by mail-ua0-f193.google.com with SMTP id u30so19782285uau.2
        for <linux-i2c@vger.kernel.org>; Mon, 13 Mar 2017 07:00:10 -0700 (PDT)
In-Reply-To: <0cf3f298-87ab-0dfc-9453-cc46e31d4979@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org

On Mon, Mar 13, 2017 at 9:34 AM, Peter Rosin <peda@axentia.se> wrote:
>> Any suggestions on how to modify i2c-mux.c to make these names unique?
>
> Why do they have to be unique?
>
I am porting OpenSwitch (www.openswitch.net) to a new platform that
has a topology as above.  OpenSwitch uses i2c adapter names to bind
i2c adapter devices to internal i2c adapters.  It assumes that
adapters are given unique names.

The presumption based on current i2c-mux behavior was that i2c adapter
names would be unique.  I knew this would cause problems for
OpenSwitch sooner or later.  It's sooner for me.

I've patched my local kernel to add the mux address to the name -
"i2c-<parent adapter id>-mux-<mux addr> (chan_id <id>)" which does
result in unique names.  However, my patch only works on topologies
that use only pca954x muxes.  I'd prefer a patch that could work for
all topologies.

Regards, Mike
