From: Oliver Neukum <oneukum@suse.com>
Subject: Re: entering the error case of i2c-designware with a timeout at
 probe
Date: Tue, 21 Mar 2017 16:37:24 +0100
Message-ID: <1490110644.8154.26.camel@suse.com>
References: <1490100731.8154.13.camel@suse.com>
         <88af9925-fea6-83af-a8ee-67feb87d59e6@suse.de>
         <657693b0-ea33-0927-752a-8e58f7c062f5@redhat.com>
         <1490103382.8154.18.camel@suse.com>
         <57e0b3a8-be5a-7b73-f47b-34d02847d3b7@redhat.com>
         <1490105111.8154.22.camel@suse.com>
         <a94f4a5c-dd31-5654-8ca6-c2cc2b22d79a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55267 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932830AbdCUPiO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Mar 2017 11:38:14 -0400
In-Reply-To: <a94f4a5c-dd31-5654-8ca6-c2cc2b22d79a@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Max Staudt <mstaudt@suse.de>
Cc: linux-i2c@vger.kernel.org

Am Dienstag, den 21.03.2017, 15:48 +0100 schrieb Hans de Goede:
> Hi,
> 
> On 21-03-17 15:05, Oliver Neukum wrote:

Hi,

> > I am quite uncomfortable with code in the kernel that will crash
> > the machine if it ever runs. Yet I am also uncomfortable with code
> > that would run forever.
> 
> That is exactly how I feel, I did not realize (yet) that taking
> the error path would always cause a freeze later, I've been assuming
> that the timeout was caused by the bus already being stuck, not
> that the timeout would cause the bus to get stuck because a
> semaphore request must be followed through on.

Those options are not mutually exclusive.

> If your theory is right we may well want to bump up the timeout
> to say 2 or 3 seconds.

We never saw a failure with 500ms. That is pretty solid.
Yet a true error would likely have catastrophic results.
It seems to me that the problem is not when to proceed
to error handling, but how the error is handled.
Do you have any documentation on that?
Should we forcibly set the semaphore to the state that signifies
a successful take over?

	Regards
		Oliver
