From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: (mpc) Add support for SMBUS_READ_BLOCK_DATA
Date: Tue, 15 Nov 2011 13:14:40 -0800
Message-ID: <1321391680.2309.374.camel@groeck-laptop>
References: <1321338462-6138-1-git-send-email-guenter.roeck@ericsson.com>
	 <20111115095445.3d34e99e@endymion.delvare>
	 <CAOZdJXVq=0pbrPM_-+Kjf3NhON8oN3Me64R6c9qBiAEFuRsDOw@mail.gmail.com>
	 <1321384487.2309.363.camel@groeck-laptop>
	 <20111115210528.0f9a0948@endymion.delvare>
Reply-To: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111115210528.0f9a0948-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tang Yuantian-B29983 <B29983-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2011-11-15 at 15:05 -0500, Jean Delvare wrote:
> On Tue, 15 Nov 2011 11:14:47 -0800, Guenter Roeck wrote:
> > On Tue, 2011-11-15 at 14:02 -0500, Tabi Timur-B04825 wrote:
> > > I think it's very important to keep the order as-is, if at all
> > > possible.  This driver is very old and the hardware is used on all of
> > > our SOCs, dating back several years.  It would be a nightmare to test
> > > it all over again.
> >
> > I'll see if I can work around that. 1-byte block reads may be tricky,
> > though, but maybe I can get that working as well.
> 
> IMHO it's OK if 1-byte blocks are not supported. In practice the length
> of blocks seems to be known in advance and it's never 1. We can revisit
> if this is ever needed in practice for this specific bus driver.
> 
I think I have a workaround for that condition. The workaround will only
apply if the length is 1, so the risk associated with it is low. I'll
test it and let you know if it works.

Guenter
