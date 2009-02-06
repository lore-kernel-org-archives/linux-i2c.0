From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/6] i2c: ignore active clients detaching during
 adapter removal.
Date: Fri, 6 Feb 2009 22:15:19 +0100
Message-ID: <20090206221519.5fc3d2b9@hyperion.delvare>
References: <1233840973-13268-1-git-send-email-giometti@linux.it>
	<1233840973-13268-3-git-send-email-giometti@linux.it>
	<1233840973-13268-4-git-send-email-giometti@linux.it>
	<200902051602.44036.david-b@pacbell.net>
	<20090206102220.GF28554@enneenne.com>
	<20090206131520.232b53c3@hyperion.delvare>
	<20090206125907.GA8581@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090206125907.GA8581-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 6 Feb 2009 13:59:07 +0100, Rodolfo Giometti wrote:
> On Fri, Feb 06, 2009 at 01:15:20PM +0100, Jean Delvare wrote:
> > 
> > Taking the old, deprecated, notoriously broken i2c model as an example
> > doesn't necessarily serve your cause ;)
> 
> I see, but till this part is in we should consider it, shouldn't we?
> Eheheh :D

No. As I've said before, ideally I wanted legacy binding style to die
_before_ we add support for multiplexing. But if we don't want to wait,
I still want legacy binding and multiplexing to be mutually exclusive.

> > The big difference, I presume, is that USB is never a system bus. But
> > even for USB, devices can't exist without the host. If you kill the
> > host and resurrect it later, you also kill the devices and resurrect
> > them later.
> 
> But this can be done with i2c devices too! Let's think about leds
> drivers with uses an i2c GPIOs expander, they can exist without any
> adapter, even if they are not functional of course. :)

That not the question. We all agree that some i2c chip drivers don't
need to be able to prevent the removal of the underlying bus driver.
The open point is whether some i2c chip drivers do. Honestly, I don't
know, as such cases would happen on embedded systems, which are out of
my realm. But maybe David has examples in mind.

> > The debate about drivers failing device removal is an old one, not
> > specific to i2c. My opinion is that .remove() should succeed as much as
> > possible. It should really only fail if the problem is so serious that
> > the system's state would otherwise become a problem (e.g. freeing
> > memory which is still referenced.) This should be a rare case.
> 
> I think that i2c clients devices should be really separated by adapter
> ones, that is we should be free to add and remove any adapter without
> considering the clients state. Then each clients device drivers should
> free each allocated resource they use and the adapters shouldn't know
> about it.

How does your description differ from the current implementation? I
don't follow you.

> Doing like this will semply the code a lot and it allows i2c core to
> be more flexible.

Patches welcome... but I have no clue what you want to do at this point.

-- 
Jean Delvare
