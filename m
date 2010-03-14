From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [linux-pm] [PATCH] i2c: Use generic subsystem-level power management callbacks
Date: Sun, 14 Mar 2010 23:52:50 +0100
Message-ID: <201003142352.50692.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1003141620540.1752-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1003141620540.1752-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, pm list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sunday 14 March 2010, Alan Stern wrote:
> On Sun, 14 Mar 2010, Rafael J. Wysocki wrote:
> 
> > > You know, maybe we should allow bus types to use both the old and new
> > > interfaces.  It would make life easier for other subsystems in addition
> > > to i2c.
> > > 
> > > This doesn't mean that the core would end up calling two sets of
> > > suspend routines.  If the bus type uses legacy routines then all the
> > > non-runtime entries in the pm_ops structure would be empty.
> > > 
> > > The changes to the PM core necessary to do this are quite small.
> > 
> > Not really.  The detection that the particular callback is not present happens
> > in pm_op(), while the decision which framework to use is made at the
> > device_[suspend|resume]() level.
> 
> All you have to do is change the "else if" lines in
> device_[suspend|resume]() to "if".

Then, if a bus type implements both "new" and "old" callbacks, we'll end up
calling both.  Not nice.

> > > Does it seem like a reasonable thing to do?
> > 
> > Well, if someone spends time on implementing new callbacks for a bus type,
> > writing them in such a way that they will call the "legacy" callbacks from
> > drivers if necessary is not really a big deal IMO.
> 
> Sure.  But suppose you _don't_ want to spend the time implementing new
> callbacks to replace the existing legacy suspend and resume methods,
> whereas you _do_ want to implement runtime PM.  Runtime PM forces the
> bus type to have a pm_ops member,

Which is very much on purpose, because the legacy suspend and resume have no
idea about the runtime stuff.

> which as you point out, will prevent the legacy methods from being called.

Yes, that's intentional.

That said, I think we might modify the generic callbacks in generic_ops.c to
call the drivers' legacy callbacks if the "new" ones are not defined.

Rafael
