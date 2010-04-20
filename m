From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c: davinci updates for 2.6.35
Date: Tue, 20 Apr 2010 06:55:18 -0700
Message-ID: <87wrw2ns8p.fsf@deeprootsystems.com>
References: <1270575738-22388-1-git-send-email-khilman@deeprootsystems.com>
	<20100420000621.GK32401@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100420000621.GK32401-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org> (Ben Dooks's message of "Tue\, 20 Apr 2010 01\:06\:21 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> writes:

> On Tue, Apr 06, 2010 at 10:42:12AM -0700, Kevin Hilman wrote:
>> This series of davinci I2C driver updates and fixes is targetted for
>> 2.6.35.  It has been tested in davinci git on multiple davinci SoCs.
>> 
>> Ben, since these changes are isolated to the davinci driver only, if
>> you prefer I can merge them upstream along with my davinci changes for
>> 2.6.35.  
>
> I'll get them into -next when I rebase it. The first in the series
> could be a -rc candidate as it looks like a useful bugfix?

Yeah, the first could be a bugfix, but at this point, I'd just prefer to
keep them all together and get them merged for 2.6.35.

Thanks,

Kevin
