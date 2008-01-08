From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Tue, 8 Jan 2008 13:44:45 -0800
Message-ID: <200801081344.45544.david-b@pacbell.net>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200801081112.46972.david-b@pacbell.net>
	<20080108215042.534e32fa@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080108215042.534e32fa-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 08 January 2008, Jean Delvare wrote:
> On Tue, 8 Jan 2008 11:12:46 -0800, David Brownell wrote:
> > On Tuesday 08 January 2008, Jean Delvare wrote:
> > > On Tue, 8 Jan 2008 15:18:17 +0100, Jean Delvare wrote:
> > > > On Sun, 6 Jan 2008 11:30:31 -0800, David Brownell wrote:
> > > > > Though I was a bit worried it might have bugs in it, since all I =
had
> > > > > time to do was code it, and sanity check it with a couple variant=
s of
> > > > > one new-style config.  (I no longer have those monster "build all=
 I2C
> > > > > drivers" configs around.)
> > > > =

> > > > I'll give it good testing, don't worry too much about that.
> > > =

> > > Hmm, I get a lockup when removing any legacy chip driver or any bus
> > > driver with legacy clients attached. =

> > =

> > Lockup?  More details ...
> =

> There's not much to say. "rmmod lm90" (or "rmmod i2c-parport") never
> returns, that's about it.

The rest of the system behaves, or not?  A "lockup" to me implies
something so catastrophic that the hardware watchdog will soon fire
and the system will reboot.

I'm guessing that's not the case here.  Stil not-good, but not as
much of a catastrophe.


> > > It seems to remove the 1st client =

> > > (no longer visible in sysfs) but never goes on with the second one.
> > > =

> > > Call Trace:
> > >   [<ffffffff802bdbd1>] sysfs_addrm_finish+0x191/0x1e0
> > =

> > What's it doing at that line in the call?
> =

> (From another run, thus the slightly different address:)
> =

> (gdb) list *(sysfs_addrm_finish+0x191)
> 0xffffffff802bdc01 is in sysfs_addrm_finish (fs/sysfs/sysfs.h:138).
> 133     }
> 134
> 135     static inline void sysfs_put(struct sysfs_dirent *sd)
> 136     {
> 137             if (sd && atomic_dec_and_test(&sd->s_count))
> 138                     release_sysfs_dirent(sd);

This isn't wholly meaningful to me.  If release_sysfs_dirent() is
wedging, then why does the stack show it's sysfs_addrm_finish()?
I guess the right question is what's going on where the PC points.  :)


> 139     }
> 140
> 141     /*
> 142      * inode.c
> (gdb)
> =

> If you need more info, feel free to ask.
> =

> > >   [<ffffffff8041bca5>] schedule_timeout+0x95/0xd0
> > =

> > This looks like stack garbage...
> =

> What makes you think so? A second stack trace shows it as well.

Because schedule_timeout() doesn't call into sysfs.  :)

Some platforms have compiler options to make stack tracing be
more sensible -- e.g. to always force frame pointers to be used,
so that stackdump utilities don't ever need to guess.

 =

> > > 			device_for_each_child() relies on a =

> > > klist_iter, and the documentation of klist_next mentions increasing t=
he
> > > reference count of the "active" list item. I would guess that you can=
't
> > > remove a list item while its reference count is not zero, and that
> > > would explain the lockup. The original code used list_for_each_safe(),
> > > which explicitly allows the removal of the items while walking the li=
st.
> > > =

> > > OTOH the header comment of lib/klist.c says:
> > > =

> > > =A0*=A0=A0The entire point is to provide an interface for iterating o=
ver a list
> > > =A0*=A0=A0that is safe and allows for modification of the list during=
 the
> > > =A0*=A0=A0iteration (e.g. insertion and removal), including modificat=
ion of the
> > > =A0*=A0=A0current node on the list.
> > >
> > > So it is supposed to work somehow...
> > =

> > Yeah, but then again ... the i2c stack does that oddball stuff with
> > complete(&client->released) for legacy drivers, too.  That's always
> > been contrary to what the driver model expects, and I never quite
> > bothered to sort out the issues.  Maybe this is one of them (sigh).
> =

> I see. I doubt I'll be of much help, as I could never figure out what
> this completion stuff was for in the first place.

In which case I'm guessing it's stuff Greg did way back in the day.
I cc'd him in hope that he can find time to comment on that ...

My understanding is that it was written early in sysfs conversions
to help ensure sysfs wasn't keeping an open handle on the device.
However, that early scheme proved to be quite error prone and now
things are set up differently.  There was a particularly annoying
class of problem with module removal.  Devices allocated by a driver
needed to be freed by that driver, which implies not unloading any
driver's module until device nodes it had allocated were freed.

The simple way around that restriction involves never having modules
allocate such devices ... clearly not easy for legacy I2C drivers.
Another way around it was to synchronize driver removal with the
cleanup of those devices.  And that's what the current I2C stack is
(still) doing for legacy drivers, with that completion logic.

- Dave

p.s. Greg, for context:  there are two patches in Jean's I2C queue
     to remove some redundant I2C lists, in favor of using versions
     maintained by i2c-core.  $SUBJECT relates to a patch removing
     a third redundancy:  i2c_adapter.clients and i2c_client.list,
     plus (the original problem) the lock for that list.
