From: Oliver Neukum <oneukum@suse.com>
Subject: Re: entering the error case of i2c-designware with a timeout at
 probe
Date: Tue, 21 Mar 2017 15:05:11 +0100
Message-ID: <1490105111.8154.22.camel@suse.com>
References: <1490100731.8154.13.camel@suse.com>
         <88af9925-fea6-83af-a8ee-67feb87d59e6@suse.de>
         <657693b0-ea33-0927-752a-8e58f7c062f5@redhat.com>
         <1490103382.8154.18.camel@suse.com>
         <57e0b3a8-be5a-7b73-f47b-34d02847d3b7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43381 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757240AbdCUOnn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Mar 2017 10:43:43 -0400
In-Reply-To: <57e0b3a8-be5a-7b73-f47b-34d02847d3b7@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Max Staudt <mstaudt@suse.de>
Cc: linux-i2c@vger.kernel.org

Am Dienstag, den 21.03.2017, 14:55 +0100 schrieb Hans de Goede:
> Hi,
> 
> On 21-03-17 14:36, Oliver Neukum wrote:
> > 
> > Am Dienstag, den 21.03.2017, 14:01 +0100 schrieb Hans de Goede:
> > > 
> > > Hi,
> > > 
> > > On 21-03-17 13:57, Max Staudt wrote:

Hello,

> > > > In other words, whether we should rather wait for lock acquisition,
> > > > unconditionally. No timeout, just wait. That's what our hardware
> > > > seems to need.
> > > > 
> > > > It feels like once the lock has been requested by the Linux driver,
> > > > we can't cancel that request and have to actually follow through
> > > > with accepting the lock and only giving it back after that.
> > > > Resetting the "request" bit to 0 as it is done now doesn't work as
> > > > it leads to the hung system sometime soon after that.
> > > 
> > > Hmm, interesting theory. I would say give it a test and if it
> > > helps then maybe increase the timeouts to say 10 seconds or
> > > such, so that e.g. on poweroff we at least report an error
> > > rather then just sitting there ?
> > 
> > I did some testing. Unconditionally taking the error path without waiting
> > for the semaphore crashes or freezes the machine in about 3/4 of all
> > tests.
> > As I said, with a timeout of 500ms, this issue is not seen.
> 
> Ah ok, so that patch is enough to fix this ? Then as I already

Yes, it is enough.

> said I'm fine with that patch, needing long timeouts unfortunately
> seems normal when dealing with embedded micro-controllers, I've
> seen the same with e.g. ACPI embedded-controllers.

I am quite uncomfortable with code in the kernel that will crash
the machine if it ever runs. Yet I am also uncomfortable with code
that would run forever.

> > Do you have reliable information that the error handling works
> > on BayTrail?
> 
> No, Bay Trail actually is known to not always be stable with Linux.

So this code is best effort just in case?

	Regards
		Oliver
