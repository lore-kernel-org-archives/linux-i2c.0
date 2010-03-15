From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [linux-pm] [PATCH] i2c: Use generic subsystem-level power management callbacks
Date: Mon, 15 Mar 2010 20:34:12 +0100
Message-ID: <201003152034.12195.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1003142117200.7108-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1003142117200.7108-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, pm list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday 15 March 2010, Alan Stern wrote:
> On Sun, 14 Mar 2010, Rafael J. Wysocki wrote:
> 
> > On Sunday 14 March 2010, Alan Stern wrote:
> > > On Sun, 14 Mar 2010, Rafael J. Wysocki wrote:
> > > 
> > > > > You know, maybe we should allow bus types to use both the old and new
> > > > > interfaces.  It would make life easier for other subsystems in addition
> > > > > to i2c.
> > > > > 
> > > > > This doesn't mean that the core would end up calling two sets of
> > > > > suspend routines.  If the bus type uses legacy routines then all the
> > > > > non-runtime entries in the pm_ops structure would be empty.
> > > > > 
> > > > > The changes to the PM core necessary to do this are quite small.
> > > > 
> > > > Not really.  The detection that the particular callback is not present happens
> > > > in pm_op(), while the decision which framework to use is made at the
> > > > device_[suspend|resume]() level.
> > > 
> > > All you have to do is change the "else if" lines in
> > > device_[suspend|resume]() to "if".
> > 
> > Then, if a bus type implements both "new" and "old" callbacks, we'll end up
> > calling both.  Not nice.
> 
> Why would a bus type implement both?  Or looked at another way, if it 
> did implement both then wouldn't it want both sets of callbacks to be 
> invoked?
> 
> If a bus type does define both types of callback by mistake and only 
> wants one of them to be used, that's a bug -- pure and simple.  It's 
> not the PM core's fault if something goes wrong under those 
> circumstances.

In fact, I'd like the "legacy" callbacks to go, at least at the subsystem
level, so I'd prefer not to make it easier to keep them around.

How many bus types are there and how many of them actually implement power
management callbacks?  I don't really think the issue is so big.

Rafael
