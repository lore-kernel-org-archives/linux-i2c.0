From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c: cdev lock_kernel() pushdown
Date: Tue, 15 Jul 2008 19:45:50 +0200
Message-ID: <20080715194550.79dbb226@hyperion.delvare>
References: <20080715174155.2d52e6f6@hyperion.delvare>
	<20080715101406.6b4517e3@bike.lwn.net>
	<20080715183552.7e1b797a@hyperion.delvare>
	<9e4733910807151001r88ed121o4f13546e1d3d93ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910807151001r88ed121o4f13546e1d3d93ff-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Tue, 15 Jul 2008 13:01:07 -0400, Jon Smirl wrote:
> On 7/15/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > On Tue, 15 Jul 2008 10:14:06 -0600, Jonathan Corbet wrote:
> >  > Hi, Jean,
> >  >
> >  > > I am looking at this patch of yours:
> >  > > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3db633ee352bfe20d4a2b0c3c8a46ce31a6c7149
> >  > >
> >  > > I believe that no locking is needed in i2cdev_open(). Do you have any
> >  > > reason to think it does? If not, can I simply revert this patch?
> >  >
> >  > Before now, i2cdev_open() has always had the protection of the BKL.
> >  > When I pushed that locking down into the individual open() functions, I
> >  > really had to take a pretty conservative approach and assume that the
> >  > BKL was needed unless that was really obviously not the case.  In
> >  > i2cdev_open(), for example, there's:
> >  >
> >  >       i2c_dev = i2c_dev_get_by_minor(minor);
> >  >
> >  > and I really don't know what keeps *i2c_dev from going away during the
> >  > rest of the call.  I'm *not* saying there is a problem here; I just
> >  > don't know.  So the only thing I could really do is to push the BKL
> >  > down and let the maintainers sort it out.
> >  >
> >  > ...all of which is my long-winded way of saying that, if you're
> >  > convinced that i2cdev_open() is safe in the absence of the BKL, feel
> >  > free to take it out.
> >
> >
> > Good point. i2c_dev is guaranteed to stay thanks to the call to
> >  i2c_get_adapter(), however it happens _after_ the call to
> >  i2c_dev_get_by_minor(), so without additional locking, this is racy.
> >  That being said, I'm not sure how lock_kernel() is supposed to help. Is
> >  the BKL held when i2cdev_detach_adapter() is called? If not, then I
> >  suspect that the current code is already racy.
> >
> >  I'll look into this, thanks for the hint.
> 
> Is i2c-dev vulnerable to the i2c device disappearing, for example
> rmmod it?

In general no, but there is a race where this can actually happen.

> Would combining i2c-dev into i2c core and integrating it
> with the core's lock protection make things easier to lock?

Definitely. That's something I want to do for other reasons anyway.

> You could
> make a compile time option to remove it for small systems. If it's in
> the core is attach/detach adapter still needed?

i2c-dev will probably soon be the last user of
i2c_adapter.attach_adapter and i2c_adapter.detach_adapter, and this is
indeed one of my incentives to look into how things could be rearranged.

> I haven't looked at
> any of this in detail, but i2c-dev is only 6K of code. Half of the 6K
> might disappear if integrated into the core.

I doubt we can remove 3 kB just by moving things around. The
book-keeping is relatively small. But this isn't my goal anyway. My
goal is to make things cleaner and possibly safer.

One thing we may do if size is a concern, is keep the functional part
of i2c-dev in its separate module, and only merge the book-keeping and
char device creation into i2c-core.

> What happens if user space and an in-kernel user both try using the
> device? I've never tried doing that. Should the presence of an
> in-kernel user make the user space device disappear?

What do you mean by "device"? The i2c bus, or a specific i2c device
(client)? The i2c bus can be used by any amount of users, in-kernel or
user-space. For i2c devices, it's more complex, depending on whether an
i2c_client is registered or not. Only one i2c_client can be registered
at a given address, but nothing prevents "raw" accesses to the devices.
i2c-dev makes such "raw" accesses, even though it has an initial check
whether the i2c address is in used by a registered client or not. This
needs to be cleaned up from the ground up, the current approach is not
satisfactory at all and things are getting worse with the advent of
new-style i2c devices, because the have a different notion of business.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
