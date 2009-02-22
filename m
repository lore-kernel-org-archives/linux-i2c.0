From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Adapter timeout is in jiffies
Date: Sun, 22 Feb 2009 19:52:19 +0100
Message-ID: <20090222195219.303fab11@hyperion.delvare>
References: <20090222160705.63563a14@hyperion.delvare>
	<20090222152059.GI17040@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090222152059.GI17040-mfnYTeDhw6uOVk/H6u/4e9i2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>, Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "Mark A. Greer" <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Lennert,

On Sun, 22 Feb 2009 16:20:59 +0100, Lennert Buytenhek wrote:
> On Sun, Feb 22, 2009 at 04:07:05PM +0100, Jean Delvare wrote:
> 
> > From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Subject: i2c: Adapter timeout is in jiffies
> > 
> > i2c_adapter.timeout is in jiffies. Fix all drivers which thought
> > otherwise. It didn't really matter as long as the value was only used
> > inside the driver, but soon i2c-core will use it too so it must have
> > the proper unit.
> > 
> > Note: for the i2c-mpc driver, this fixes a bug in polling mode.
> > Timeout would trigger after 1 jiffy, which is most probably not what
> > the author wanted.
> > 
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
> > Cc: Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>
> > Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
> > Cc: Lennert Buytenhek <kernel-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
> > Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> > Cc: Mark A. Greer <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-ibm_iic.c |    6 +++---
> >  drivers/i2c/busses/i2c-iop3xx.c  |    2 +-
> >  drivers/i2c/busses/i2c-mpc.c     |    4 ++--
> >  drivers/i2c/busses/i2c-mv64xxx.c |    7 +++----
> >  drivers/i2c/busses/i2c-pca-isa.c |    2 +-
> >  5 files changed, 10 insertions(+), 11 deletions(-)
> 
> The i2c-mv64xxx part:
> 
> Acked-by: Lennert Buytenhek <buytenh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Thanks.

> Although I wonder if we shouldn't move away from expressing time
> intervals in jiffies.

Why? This is what time_after() and wait_event_interruptible_timeout()
want, so this is the most efficient way (as discussed recently [1]).

[1] http://marc.info/?l=linux-i2c&m=123507862624484&w=2

-- 
Jean Delvare
