From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Tue, 8 Jan 2008 14:04:45 -0800
Message-ID: <20080108220445.GB3873@kroah.com>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200801081112.46972.david-b@pacbell.net>
	<20080108215042.534e32fa@hyperion.delvare>
	<200801081344.45544.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200801081344.45544.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 08, 2008 at 01:44:45PM -0800, David Brownell wrote:
> On Tuesday 08 January 2008, Jean Delvare wrote:
> > > > 			device_for_each_child() relies on a 
> > > > klist_iter, and the documentation of klist_next mentions increasing the
> > > > reference count of the "active" list item. I would guess that you can't
> > > > remove a list item while its reference count is not zero, and that
> > > > would explain the lockup. The original code used list_for_each_safe(),
> > > > which explicitly allows the removal of the items while walking the list.
> > > > 
> > > > OTOH the header comment of lib/klist.c says:
> > > > 
> > > > ?*??The entire point is to provide an interface for iterating over a list
> > > > ?*??that is safe and allows for modification of the list during the
> > > > ?*??iteration (e.g. insertion and removal), including modification of the
> > > > ?*??current node on the list.
> > > >
> > > > So it is supposed to work somehow...
> > > 
> > > Yeah, but then again ... the i2c stack does that oddball stuff with
> > > complete(&client->released) for legacy drivers, too.  That's always
> > > been contrary to what the driver model expects, and I never quite
> > > bothered to sort out the issues.  Maybe this is one of them (sigh).
> > 
> > I see. I doubt I'll be of much help, as I could never figure out what
> > this completion stuff was for in the first place.
> 
> In which case I'm guessing it's stuff Greg did way back in the day.
> I cc'd him in hope that he can find time to comment on that ...

Ick, sorry about that mess :(

> My understanding is that it was written early in sysfs conversions
> to help ensure sysfs wasn't keeping an open handle on the device.
> However, that early scheme proved to be quite error prone and now
> things are set up differently.  There was a particularly annoying
> class of problem with module removal.  Devices allocated by a driver
> needed to be freed by that driver, which implies not unloading any
> driver's module until device nodes it had allocated were freed.

Yes, that should not be used anymore, and I thought we had removed it
for some reason.  I guess I was just wishing it were so...

> The simple way around that restriction involves never having modules
> allocate such devices ... clearly not easy for legacy I2C drivers.
> Another way around it was to synchronize driver removal with the
> cleanup of those devices.  And that's what the current I2C stack is
> (still) doing for legacy drivers, with that completion logic.
> 
> - Dave
> 
> p.s. Greg, for context:  there are two patches in Jean's I2C queue
>      to remove some redundant I2C lists, in favor of using versions
>      maintained by i2c-core.  $SUBJECT relates to a patch removing
>      a third redundancy:  i2c_adapter.clients and i2c_client.list,
>      plus (the original problem) the lock for that list.

That sounds like a good idea, if the above race doesn't happen :)

Anything I can do to help out?

thanks,

greg k-h
