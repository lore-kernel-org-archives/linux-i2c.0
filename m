From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: append hardware lock with bus lock
Date: Wed, 11 May 2011 00:08:32 +0100
Message-ID: <20110510230832.GE634@freya.fluff.org>
References: <1304003746-12127-1-git-send-email-haojian.zhuang@gmail.com>
 <20110502092734.GV15795@trinity.fluff.org>
 <20110502114616.7813da79@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110502114616.7813da79-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, May 02, 2011 at 11:46:16AM +0200, Jean Delvare wrote:
> On Mon, 2 May 2011 10:27:34 +0100, Ben Dooks wrote:
> > On Thu, Apr 28, 2011 at 11:15:44PM +0800, Haojian Zhuang wrote:
> > > Both AP and CP are contained in Marvell PXA910 silicon. These two ARM
> > > cores are sharing one pair of I2C pins.
> > > 
> > > In order to keep I2C transaction operated with atomic, hardware lock
> > > (RIPC) is required. Because of this, bus lock in AP side can't afford
> > > this requirement. Now hardware lock is appended.
> > > 
> > > Signed-off-by: Haojian Zhuang <haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > > Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > 
> > Right, this looks like a reasonable explanation of what is going on here
> > and if Jean is happy with the core changes I'll look at where the driver
> > change can go.
> 
> Yes I am!
> 
> Let me know if you want me to take the core change in my tree or if you
> prefer to have it in yours to avoid a dependency.

if it'll go in my tree ok, then yes.
Will publish a new tree soon.
