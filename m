From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Tue, 8 Jan 2008 14:27:12 -0800
Message-ID: <200801081427.12484.david-b@pacbell.net>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200801081344.45544.david-b@pacbell.net>
	<20080108220445.GB3873@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080108220445.GB3873-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 08 January 2008, Greg KH wrote:
> > > > > So it is supposed to work somehow...
> > > > 
> > > > Yeah, but then again ... the i2c stack does that oddball stuff with
> > > > complete(&client->released) for legacy drivers, too.

Also the i2c_adapter devices, which might have a similar issue lurking...


> > > > 		That's always 
> > > > been contrary to what the driver model expects, and I never quite
> > > > bothered to sort out the issues.  Maybe this is one of them (sigh).
> > > 
> > > I see. I doubt I'll be of much help, as I could never figure out what
> > > this completion stuff was for in the first place.
> > 
> > In which case I'm guessing it's stuff Greg did way back in the day.
> > I cc'd him in hope that he can find time to comment on that ...
> 
> Ick, sorry about that mess :(

I was *hoping* for more than just sympathy!  ;)


> > My understanding is that it was written early in sysfs conversions
> > to help ensure sysfs wasn't keeping an open handle on the device.
> > However, that early scheme proved to be quite error prone and now
> > things are set up differently.  There was a particularly annoying
> > class of problem with module removal.  Devices allocated by a driver
> > needed to be freed by that driver, which implies not unloading any
> > driver's module until device nodes it had allocated were freed.
> 
> Yes, that should not be used anymore, and I thought we had removed it
> for some reason.  I guess I was just wishing it were so...

Do you remember any particular details about how it all got removed?
Like in particular:
 
> > The simple way around that restriction involves never having modules
> > allocate such devices ... clearly not easy for legacy I2C drivers.

Was there a better solution than that near-term unattractive one?
It involves changing lots of legacy I2C code, making them provide
proper remove methods and thus changing memory management policy ...
Error prone, needs to be done slowly.


> > Another way around it was to synchronize driver removal with the
> > cleanup of those devices.  And that's what the current I2C stack is
> > (still) doing for legacy drivers, with that completion logic.
> > 
> > - Dave
> > 
> > p.s. Greg, for context:  there are two patches in Jean's I2C queue
> >      to remove some redundant I2C lists, in favor of using versions
> >      maintained by i2c-core.  $SUBJECT relates to a patch removing
> >      a third redundancy:  i2c_adapter.clients and i2c_client.list,
> >      plus (the original problem) the lock for that list.
> 
> That sounds like a good idea, if the above race doesn't happen :)
> 
> Anything I can do to help out?

Verify that could cause the hang Jean observed ... you're more on top
of this driver model stuff than most folk.  :)

I'll forward you my copies of the three patches, so you can apply them
and see the basic results of the cleanups.  Then have a look and see if
you agree with me about that one solution being "near-term unattractive",
or can otherwise suggest a clean solution.

- Dave
