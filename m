From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Warn on deprecated binding model use
Date: Tue, 13 Jan 2009 17:04:47 +0100
Message-ID: <20090113170447.2fbef7b5@hyperion.delvare>
References: <20090113144044.5b6fb53a@hyperion.delvare>
	<20090113154428.GK8032@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090113154428.GK8032-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Tue, 13 Jan 2009 15:44:29 +0000, Ben Dooks wrote:
> On Tue, Jan 13, 2009 at 02:40:44PM +0100, Jean Delvare wrote:
> > Let the kernel developers know that i2c_attach_client() and
> > i2c_detach_client() are deprecated and should no longer be used.
> > Drivers using these should be converted to the standard device
> > driver binding model (probe and remove methods.)
> > 
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> 
> This is a good idea, we should also signal a kernel date when the
> old probe method will be removed (IMHO, the next merge window).

There's an entry in feature-removal-schedule.txt already:

What:   i2c_attach_client(), i2c_detach_client(), i2c_driver->detach_client()
When:   2.6.29 (ideally) or 2.6.30 (more likely)
Why:    Deprecated by the new (standard) device driver binding model. Use
        i2c_driver->probe() and ->remove() instead.
Who:    Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

I'd say this is sufficient?

> Acked-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Thanks,
-- 
Jean Delvare
