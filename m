From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH 5/5] i2c-i801: Remove redundant code and event-drive
Date: Wed, 25 May 2016 11:58:29 -0500
Message-ID: <5745D9B5.5000704@acm.org>
References: <1453223377-20608-1-git-send-email-minyard@acm.org>
 <1453223377-20608-6-git-send-email-minyard@acm.org>
 <20160525145230.24f1c881@endymion>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34078 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137AbcEYQ6d (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 25 May 2016 12:58:33 -0400
Received: by mail-oi0-f66.google.com with SMTP id r64so13088442oie.1
        for <linux-i2c@vger.kernel.org>; Wed, 25 May 2016 09:58:32 -0700 (PDT)
In-Reply-To: <20160525145230.24f1c881@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

On 05/25/2016 07:52 AM, Jean Delvare wrote:
> Hi Corey,
>
> On Tue, 19 Jan 2016 11:09:37 -0600, minyard@acm.org wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> There was a lot of redundant code in the driver, basically one copy
>> for the polled interface and one for the interrupt-driven interface.
>> Only use the interrupt-driven interface and use a timer to check
>> the interface periodically and time things out.
> This patch is simply too large and messy for me to consider reviewing
> it. It needs to be split into smaller pieces. But honestly I don't see
> that much redundancy in the driver, and as a matter of fact your patch
> adds more lines than it removes.

Umm:

  drivers/i2c/busses/i2c-i801.c | 582 +++++++++++++++++++++---------------------
  1 file changed, 284 insertions(+), 298 deletions(-)

It's not a lot of lines, but it is a little smaller.

>
> This is unfortunate because some of the changes would still be good to
> have. In particular having a single call to i801_check_post() would be
> a nice clean-up.

Yes, looking over this some more, several of the issues have been
addressed that these patches originally targeted.

This was originally part of a set of patches that allowed access to
I2C devices when the system couldn't schedule, primarily for
storing panic information and handling watchdogs at panic and
in kgdb.  For that you have to event-drive it so you can poll.
I've abandoned those changes, but this small set looked
like it has some useful stuff.

Thanks for the review, I'll look at pulling out some of the good things
(and getting rid of hwpec from i801_block_transaction_byte_by_byte
since it's not used there any more).

-corey

>> This also adds timeouts when using interrupt, so a failed operation
>> won't hang forever.
> As far as I can see, the current code already has these timeouts,
> although maybe it wasn't the case when you first wrote this patch? This
> was added by b3b8df9772 in November 2014.
>
