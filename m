From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH RFC] Splitting i2c-designware.c to support PCI drivers
Date: Fri, 14 Jan 2011 21:48:39 +0000
Message-ID: <20110114214839.GC15795@trinity.fluff.org>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com> <20110114213007.58c8b237@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110114213007.58c8b237-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 14, 2011 at 09:30:07PM +0100, Jean Delvare wrote:
> Hi Dirk,
> 
> On Fri, 14 Jan 2011 11:27:27 -0800, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > 
> > This patch set splits i2c-designware.c core and bus specific portions
> > in to support the Designware core being behind a PCI device.
> > 
> > The Intel Moorsetown and Medfield SOC's are supported in the PCI
> > portion of the driver.
> 
> We already have the i2c-intel-mid driver for Moorsetown and Medfield.
> Why would we need another driver?

Maybe we could delete those and use this instead.

I wish I put my foot down and asked them to re-used the dw one otherwise
we'll just end up with driver creep....

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
