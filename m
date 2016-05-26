From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 5/5] i2c-i801: Remove redundant code and event-drive
Date: Thu, 26 May 2016 09:17:33 +0200
Message-ID: <20160526091733.53821092@endymion>
References: <1453223377-20608-1-git-send-email-minyard@acm.org>
	<1453223377-20608-6-git-send-email-minyard@acm.org>
	<20160525145230.24f1c881@endymion>
	<5745D9B5.5000704@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39812 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbcEZHRg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 26 May 2016 03:17:36 -0400
In-Reply-To: <5745D9B5.5000704@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: linux-i2c@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

Hi Corey,

On Wed, 25 May 2016 11:58:29 -0500, Corey Minyard wrote:
> On 05/25/2016 07:52 AM, Jean Delvare wrote:
> > On Tue, 19 Jan 2016 11:09:37 -0600, minyard@acm.org wrote:
> >> From: Corey Minyard <cminyard@mvista.com>
> >>
> >> There was a lot of redundant code in the driver, basically one copy
> >> for the polled interface and one for the interrupt-driven interface.
> >> Only use the interrupt-driven interface and use a timer to check
> >> the interface periodically and time things out.
> > This patch is simply too large and messy for me to consider reviewing
> > it. It needs to be split into smaller pieces. But honestly I don't see
> > that much redundancy in the driver, and as a matter of fact your patch
> > adds more lines than it removes.
> 
> Umm:
> 
>   drivers/i2c/busses/i2c-i801.c | 582 +++++++++++++++++++++---------------------
>   1 file changed, 284 insertions(+), 298 deletions(-)
> 
> It's not a lot of lines, but it is a little smaller.

Oops, my bad, I read the diffstat wrong. My apologies.

> > This is unfortunate because some of the changes would still be good to
> > have. In particular having a single call to i801_check_post() would be
> > a nice clean-up.
> 
> Yes, looking over this some more, several of the issues have been
> addressed that these patches originally targeted.
> 
> This was originally part of a set of patches that allowed access to
> I2C devices when the system couldn't schedule, primarily for
> storing panic information and handling watchdogs at panic and
> in kgdb.  For that you have to event-drive it so you can poll.
> I've abandoned those changes, but this small set looked
> like it has some useful stuff.
> 
> Thanks for the review, I'll look at pulling out some of the good things

Thank you, I'll be happy to review and test the new series, hopefully
faster than I did for this one. Now that the i2c-i801 driver works on
my system again, it should be much easier.

> (and getting rid of hwpec from i801_block_transaction_byte_by_byte
> since it's not used there any more).

Did it ever work? And more importantly, does the hardware support it?
Before cleaning up the code, I'd like to make sure the driver supports
PEC in all cases where the hardware itself supports it. I'll do some
tests.

-- 
Jean Delvare
SUSE L3 Support
