From: Oliver Neukum <oneukum@suse.com>
Subject: Re: entering the error case of i2c-designware with a timeout at
 probe
Date: Tue, 21 Mar 2017 14:36:22 +0100
Message-ID: <1490103382.8154.18.camel@suse.com>
References: <1490100731.8154.13.camel@suse.com>
         <88af9925-fea6-83af-a8ee-67feb87d59e6@suse.de>
         <657693b0-ea33-0927-752a-8e58f7c062f5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58819 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756347AbdCUNhl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Mar 2017 09:37:41 -0400
In-Reply-To: <657693b0-ea33-0927-752a-8e58f7c062f5@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Max Staudt <mstaudt@suse.de>
Cc: linux-i2c@vger.kernel.org

Am Dienstag, den 21.03.2017, 14:01 +0100 schrieb Hans de Goede:
> Hi,
> 
> On 21-03-17 13:57, Max Staudt wrote:
> > 
> > On 03/21/2017 01:52 PM, Oliver Neukum wrote:
> > > 
> > > Hi Hans,
> > > 
> > > we found on our test systems with a bit of experimentation,
> > > that actually running into the timeout is bound to hang the whole
> > > system within only a few seconds.
> > > I was wondering whether the error handling needs to be changed.
> > 
> > In other words, whether we should rather wait for lock acquisition,
> > unconditionally. No timeout, just wait. That's what our hardware
> > seems to need.
> > 
> > It feels like once the lock has been requested by the Linux driver,
> > we can't cancel that request and have to actually follow through
> > with accepting the lock and only giving it back after that.
> > Resetting the "request" bit to 0 as it is done now doesn't work as
> > it leads to the hung system sometime soon after that.
> 
> Hmm, interesting theory. I would say give it a test and if it
> helps then maybe increase the timeouts to say 10 seconds or
> such, so that e.g. on poweroff we at least report an error
> rather then just sitting there ?

I did some testing. Unconditionally taking the error path without waiting
for the semaphore crashes or freezes the machine in about 3/4 of all
tests.
As I said, with a timeout of 500ms, this issue is not seen.
Do you have reliable information that the error handling works
on BayTrail?

	Regards
		Oliver
