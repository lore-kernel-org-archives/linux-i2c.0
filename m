From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c devices
Date: Thu, 7 Apr 2011 10:34:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104071031590.2147-100000@iolanthe.rowland.org>
References: <20110407102544.4c34dfeb@endymion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110407102544.4c34dfeb-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 7 Apr 2011, Jean Delvare wrote:

> On Thu, 7 Apr 2011 09:00:43 +0100, Mark Brown wrote:
> > On Thu, Apr 07, 2011 at 09:55:13AM +0200, Jean Delvare wrote:
> > > On Thu, 7 Apr 2011 07:31:24 +0900, Mark Brown wrote:
> > 
> > > > You definitely don't know *anything* about the relationships for I2C,
> > > > especially in embedded systems.
> > 
> > > Can you please elaborate? The i2c subsystem uses a standard
> > > parent-children relationship. It seems fairly similar to USB for
> > > example. The only special case I can think of is with bus multiplexing,
> > > but it would be easy enough to switch off async suspend/resume in this
> > > case.
> > 
> > For I2C itself that's the case but for power and GPIO (which are very
> > common in conjunction with I2C in the embedded context) we loose the
> > tree.  This is much less of an issue with buses like PCI where
> > everything is bundled into the bus.
> 
> Out of curiosity, how is this handled in the synchronous suspend/resume
> case?

With synchronous resume, devices are resumed in the order they were
originally registered.  Since the power and GPIO controllers must have
been registered before the I2C controller (otherwise the I2C wouldn't
have been accessible when it was registered!), they will be resumed
first.

Alan Stern
