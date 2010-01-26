From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: Davinci i2c bus recovery procedure to clear the bus
Date: Tue, 26 Jan 2010 15:30:30 -0800
Message-ID: <87pr4wzbop.fsf@deeprootsystems.com>
References: <1263295036.3437.17.camel@localhost.localdomain>
	<20100124150741.GA28675@fluff.org.uk>
	<1264431608.3430.19.camel@localhost.localdomain>
	<87636p4v9l.fsf@deeprootsystems.com>
	<20100126144647.GG12774@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100126144647.GG12774-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org> (Ben Dooks's message of "Tue\, 26 Jan 2010 14\:46\:47 +0000")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> writes:

> On Mon, Jan 25, 2010 at 03:31:02PM -0800, Kevin Hilman wrote:
>> Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org> writes:
>> 
>> > On Sun, 2010-01-24 at 15:07 +0000, Ben Dooks wrote:
>> >> On Tue, Jan 12, 2010 at 04:47:16PM +0530, Philby John wrote:
>> >> > >From 2565eeda807e49376298ec895a0d9a91a7668417 Mon Sep 17 00:00:00 2001
>> >> > From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
>> >> > Date: Mon, 11 Jan 2010 22:39:44 +0530
>> >> > Subject: [PATCH 2/2] Davinci i2c bus recovery procedure to clear the bus
>> >> > 
>> >> > Come out of i2c time out condition by following the
>> >> > bus recovery procedure outlined in the i2c protocol v3 spec.
>> >> > The kernel must be robust enough to gracefully recover
>> >> > from i2c bus failure without having to reset the machine.
>> >> > This is done by first NACKing the slave, pulsing the SCL
>> >> > line 9 times and then sending the stop command.
>> >> > 
>> >> > This patch has been tested on a DM6446 and DM355
>> >> 
>> >> Still not sure whether this can be included as a bug-fix or whether
>> >> it comes under the new feature category. Also, since it has to get
>> >> new data from the platform whose tree it should really go into.
>> >
>> > This fix is for the issue that was reported here
>> > http://www.mail-archive.com/davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org/msg13560.html which IMHO is critical. The issue can be replicated easily and without it the user is left with no choice but to reset the target.
>> >
>> > Yes, it does depend on [PATCH 1/2] for platform dependent data, would
>> > fail otherwise. Could you suggest what may I do in this circumstances?
>> 
>> This patch looks OK to me, and I'm happy to merge it via DaVinci git
>> for 2.6.34 since it has a compile dependency with PATCH 1/1.
>> 
>> Ben, if you're OK with that, can I have your Ack and I can merge it?
>
> Acked-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>  

Thanks Ben,

There's a bit of a snag here in that this patch applies on top of
several other I2C patches that have been submitted for DaVinci, but
I'm not aware of the status of those.

I will re-post the whole series for your review, and you can let me
know if you'd like me to merge those via the davinci tree or your
tree.

Kevin
