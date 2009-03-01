From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: legacy drivers in staging?
Date: Sun, 1 Mar 2009 11:36:41 +0100
Message-ID: <20090301113641.33a462d2@hyperion.delvare>
References: <20090301101306.GB23093@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090301101306.GB23093-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Sun, 1 Mar 2009 11:13:06 +0100, Wolfram Sang wrote:
> when having another look at the status page of legacy drivers in the i2c-wiki,
> I stumbled over the drivers from 'staging'. Do they really need to appear
> there? I hope the removal of the legacy binding will not depend on those
> drivers ;)

I am not sure myself. I agree we don't want to delay the removal of the
legacy binding just because of these drivers. But OTOH I see little
point in having a staging directory [1] if drivers being placed there
break as soon as there is a core kernel change. I guess we are supposed
to update these drivers as we do for all other drivers.

So, ideally, someone would convert these drivers so that they do not
break when legacy drivers are removed. My hope was that the author of
these drivers would do it when seeing the warnings which i2c.h spits
out. But if this doesn't happen, someone else will have to take care.
That being said I think that there is much more work needed on these
drivers, on the V4L side.

Bottom line is that, is these drivers are the last ones blocking the
removal of the legacy i2c driver, I will either attempt to convert them
the quick-and-dirty way, or I will mark them as broken and leave it to
somebody else to fix them. They will not delay us.

[1] To be honest I was not really fond of the idea of a staging drivers
directory in the first place anyway.

-- 
Jean Delvare
