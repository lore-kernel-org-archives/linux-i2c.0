From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/6] i2c: ignore active clients detaching during
 adapter removal.
Date: Tue, 10 Feb 2009 12:08:39 +0100
Message-ID: <20090210120839.23592e38@hyperion.delvare>
References: <1233840973-13268-1-git-send-email-giometti@linux.it>
	<1233840973-13268-3-git-send-email-giometti@linux.it>
	<1233840973-13268-4-git-send-email-giometti@linux.it>
	<200902051602.44036.david-b@pacbell.net>
	<20090206102220.GF28554@enneenne.com>
	<20090206131520.232b53c3@hyperion.delvare>
	<20090206125907.GA8581@enneenne.com>
	<20090206221519.5fc3d2b9@hyperion.delvare>
	<20090209130642.GV7975@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090209130642.GV7975-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 9 Feb 2009 14:06:42 +0100, Rodolfo Giometti wrote:
> On Fri, Feb 06, 2009 at 10:15:19PM +0100, Jean Delvare wrote:
> > That not the question. We all agree that some i2c chip drivers don't
> > need to be able to prevent the removal of the underlying bus driver.
> > The open point is whether some i2c chip drivers do. Honestly, I don't
> > know, as such cases would happen on embedded systems, which are out of
> > my realm. But maybe David has examples in mind.
> 
> I see. But in this case we should dig into the code and verify what
> each i2c drivers wish to do during driver removal and eventually fix
> it, is that right?

I simply don't know. As I have written above, I do not have any example
of an I2C device which should be allowed to prevent bus removal. But I
am a PC person and the i2c subsystem is used in a very different way on
embedded systems. So better discuss this with people who know these
systems.

> > (...)
> > How does your description differ from the current implementation? I
> > don't follow you.
> 
> Currently an i2c driver may block adpater removal procedure, my
> implementation, instead, considers i2c adapter completely separated
> from i2c clients so that no one can't interfere with adapter
> insertion/removal code.

As far as I can see this only happens for legacy i2c chip drivers,
which implement driver->detach_client() or driver->detach_adapter().
The plan is to get rid of the last few users of this model as soon as
possible, so that's not really relevant.

Do you see any other place in i2c-core where we check for error on
device removal and do something based on that, in particular for
new-style i2c chip drivers?

> > Patches welcome... but I have no clue what you want to do at this point.
> 
> If you agree I can provide a branch tree from current vanilla and
> describe my solution into linux-i2c wiki, so users may test it and
> propose enhancements without touching current stable code.

Well, you can always do that if you want, but please first clearly
define the practical problem you are trying to solve. We are not going
to change the i2c core without a good reason.

Oh, and if you have time to spend on i2c, then helping getting rid of
the remaining legacy drivers would be greatly appreciated. As long as
we have to support both models, there are many core cleanups and
improvements that are simply not possible (or so risky that nobody
wants to try.)

-- 
Jean Delvare
