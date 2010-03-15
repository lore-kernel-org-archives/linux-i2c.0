From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [linux-pm] [PATCH] i2c: Use generic subsystem-level power management callbacks
Date: Mon, 15 Mar 2010 23:06:42 +0100
Message-ID: <201003152306.42083.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1003151630370.1332-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1003151630370.1332-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, pm list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday 15 March 2010, Alan Stern wrote:
> On Mon, 15 Mar 2010, Rafael J. Wysocki wrote:
> 
> > In fact, I'd like the "legacy" callbacks to go, at least at the subsystem
> > level, so I'd prefer not to make it easier to keep them around.
> > 
> > How many bus types are there and how many of them actually implement power
> > management callbacks?  I don't really think the issue is so big.
> 
> I have no idea.  But I'm in the middle of implementing runtime PM for
> SCSI.  SCSI already has bus-level legacy callbacks, so to add the
> runtime methods without changing the existing system sleep behavior
> requires something like this.
> 
> The alternative is to write a bunch of tiny "shim" functions, sort of
> like what I ended up doing in the USB stack (see usb_dev_prepare() and
> the following routines in drivers/usb/core/usb.c).

I prefer this approach to changing the core.  If we changed the core, it would
defeat the whole purpose of introducing the new framework.

Rafael
