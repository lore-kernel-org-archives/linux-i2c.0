From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 3/3] i2c: add support for i2c bus on Freescale
	CPM1/CPM2 controllers
Date: Tue, 3 Jun 2008 13:13:06 -0700
Message-ID: <200806031313.07289.david-b@pacbell.net>
References: <200805142314.m4ENEjPV026316@imap1.linux-foundation.org>
	<20080602221923.GF6226@fluff.org.uk>
	<20080603120625.7bde7698@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080603120625.7bde7698-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 03 June 2008, Jean Delvare wrote:

> > > This is one of those cases where the I2C programming interface is
> > > insufficient.  As noted in the comment added to i2c_transfer() by
> > > the patch updating fault code passthrough handling in i2c-core.c:
> > > 
> > > > >          *  - When we get a NAK after transmitting N bytes to a slave,
> > > > >          *    there is no way to report "N" ... or to let the master
> > > > >          *    continue executing the rest of this combined message, if
> > > > >          *    that's the appropriate response.
> > 
> > I thought the i2c_msg flag to ignore NAK was the way to let the master
> > continue, although this does mean that you loose the fact that a NAK
> > actually happened.

My understanding is that it's a protocol tweaking option which
would not act that way.


> > The case of letting the master continue after such an error still
> > makes reporting the amount of data written difficult, how do you
> > indicate I wrote m bytes, got an error, and then continued on to
> > write all n bytes of the i2c_msgs provided?

"wrote N bytes then got an error" --> report N, then either
	(a) discard the fault code, which is the typical solution, OR
	(b) also record the fault code

As I commented, recording N is easy since i2c_msg has some bytes
that are currently wasted for use as padding ... on any 32-bit
system using "natural" alignment.  Additionally recording a fault
code could be a problem.  Possibly worth addressing both issues
at the same time, but I'm not sure.


> > Can anyone think of 
> > an actual example of where this would be useful?

I mentioned it because it came up in the context of implementing
the PMBus "group protocol".  Briefly, one I2C combined transaction
sends messages to several slaves ... and they hold off execution
until the terminating STOP.  That achieves synchronized changes;
you may need to coordinate several supply voltage updates.

That clearly opens the door to situations where it might be more
important to ensure that, say, the first and third commands are
both received than to allow a fault on the second command make
the first execute without the third.

In my mind that's more useful as an example of current limitations
(ergo the comment) than something critical to address right now.

However, inability to report N seems more significant to me.
(It's also easier to address.)


> > > As I mentioned earlier, the best way to address this issue would
> > > be to carve a 16 bit field out of the existing struct padding and
> > > use that from updated i2c_adapter drivers to report N (actual_len).
> > 
> > So you are suggesting adding a done field to the i2c_msg structure
> > that is updated by the bus driver as it goes along? For arm, this
> > should fit, but are there any other architectures out there that are
> > going to be affected by this change in structure (it does, iirc, get
> > exported to userspace).
> 
> Yes, it is exported to user-space. But I guess that the binary
> compatibility constraints are the same for user-space and kernel-space.

Well, the struct padding rules are ISTR now incorporated into
the C spec rather than being compiler-specific.  So in that sense
the rules are the same ... both for kernel-space and between
platforms, at least for stuff as simple as i2c_msg.

 
> > If you add a __u16 done field to the i2c_msg, then you either have to
> > find a special value for 'not filled in' and have the i2c core fill
> > in the i2c_msg array at start time?

Simplest would be "__u16 actual_len" which can be initialized to zero.
SMBus "quick command" would be a minor glitch.  Drivers looking at that
would presumably need to cope with adapters that haven't been fixed to
update that field ... e.g. if it comes back as zero, they'll assume
it's the same as the requested length.  (Might be better if i2c-core
patched that and emitted a single runtime warning for that i2c adapter
driver; details TBD.)

(There could be other approaches of course, but that one seems likely
to cause the least overall trouble.)


> > > The standard way to report short writes is not via errno values...
> > > but by reporting how many bytes were written.  See "man 2 write".
> > > It's not what the I2C stack does now, though.
> > 
> > Yes, that does make sense to return the amount of data written to
> > the user, however having a quick look through all users of
> > i2c_transfer() all just want to know if all the messages where
> > sent (which is an easier check that to compute the amount of
> > data in all the messages).

Today all they *can* know is that much!

Even the code which would *want* to report the actual number of
bytes transferred (like i2c-dev, so it can correctly implement
read/write syscall semantics) can only cope within the limits
of the current (deficient) interface.


> > Would it better to add an new i2c_transfer-alike call which would
> > return the amount of data written, instead of going around modifying
> > all users of i2c_transfer() ? This would also make transfering from
> > one call to the other, with i2c_transfer becoming deprecated?
> > 
> > I was just wondering if it would be useful to add an extra field
> > after the buffer to indicate the error that happened to the message
> > such as NAK, bus arbitration, etc.

If we all concur with the observation that this is one of the
types of fault that the current interface hides, the question
becomes what to do about it.  My initial take was to describe
the issue ... so it could be addressed later, as needed.


> The main question here is: who needs this?

i2c-dev doesn't currently implement write()/read() syscalls
correctly for partial writes or reads ... it can't detect
those cases.  (Just one datapoint.)

But the short answer is:  anyone who wants robust code will
have noticed the current interface doesn't support it.


> I2C errors don't happen frequently,

I tend to agree, but that's not unique to I2C.  And it's
orthogonal to the issue of whether it's possible to cope
well with errors when they *do* appear.


> and when they happen, how many devices are able to recover 
> with a partial transaction based on how far the initial transaction
> went? I suspect that most devices will need to restart the transaction
> from scratch anyway, and for those who could spare a few bytes, it it
> really worth it? Driver authors most certainly won't bother.

You're presuming one recovery strategy.  But another issue is
how to tell what actually happened, so that for example the
faults can be logged in enough detail to notice patterns.

 
> Given the compatibility constraints, this all looks like a lot of work
> and pain for a benefit which is essentially aesthetic. I agree that the
> current API isn't nice, but very much doubt that there's anything to
> win by reworking it in practice. So I think my time will be much better
> used for other matters.

Hence my observation that adding paths to report the value of N
are minimal ... no "rework".


> > > That could be done if i2c-core got some updates, at least with
> > > any i2c adapters that get updated to better report this fault
> > > (using that new field living in what's now struct padding).
> > 
> > As noted above, is it padding on _all_ architectures?

I believe so.  "Natural Alignment" requires it exist on 32-bit
CPUs; and even more on 64-bit ones.

  
> > > Failing such updates, I'd avoid EREMOTEIO since that's what USB
> > > uses to indicate short *reads* (not writes) when they're flagged
> > > for reporting as errors (not the default).  EFBIG (too big)
> > > would make more sense if short writes must be reported as some
> > > kind of fault.
> > 
> 
>

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
