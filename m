From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] [PATCH] i2c: Use generic subsystem-level power
 management callbacks
Date: Sat, 13 Mar 2010 16:34:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003131627270.19476-100000@netrider.rowland.org>
References: <201003132204.30905.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201003132204.30905.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, pm list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 13 Mar 2010, Rafael J. Wysocki wrote:

> Please note that the "legacy" callbacks removed by this patch are already
> effectively dead, because they are not going to be called by the PM core
> anyway.  I'm not sure if this is what we want, though, so please let me know
> in case it's not.

You know, maybe we should allow bus types to use both the old and new
interfaces.  It would make life easier for other subsystems in addition
to i2c.

This doesn't mean that the core would end up calling two sets of
suspend routines.  If the bus type uses legacy routines then all the
non-runtime entries in the pm_ops structure would be empty.

The changes to the PM core necessary to do this are quite small.  Does 
it seem like a reasonable thing to do?

Alan Stern
