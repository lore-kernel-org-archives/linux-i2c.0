From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.25-git] i2c_adapters:  return -Errno not -1
Date: Sun, 11 May 2008 09:23:43 -0700
Message-ID: <200805110923.44693.david-b@pacbell.net>
References: <200805012046.07885.david-b@pacbell.net>
	<200805110117.23023.david-b@pacbell.net>
	<20080511122647.1e04c9c0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080511122647.1e04c9c0-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sunday 11 May 2008, you wrote:

> > > Given the comment above I'd make this -ENODEV. 99% of the time, no ack
> > > means no device.
> > 
> > Either ENODEV or ENXIO for "it didn't ACK the address".  Any
> > other code will make the driver core emit diagnostics when the
> > probe() fails ... diagnostics we want to avoid, when probe()
> > code does the Right Thing and just returns such fault codes.
> > 
> > That's probably an issue with most of these updates.
> 
> My point exactly. I am fine with both -ENXIO and -ENODEV, pick the one
> you like, then make sure all drivers are using it consistently.

I'll go with ENXIO "no such device or address" as being a bit more
appropriate for addressing issues.  Driver probe() code can return
ENODEV in the case where there is a device there ... but the wrong
one for that driver.


> As for "how do I know": check whether the code is using dev_err() or
> dev_dbg(). Each time a driver uses dev_dbg(), chances are good that the
> error in question isn't really an error, and we've turned the error
> message into a debug message to avoid log fills and user complaints. So
> basically, when I see a dev_dbg() in these SMBus "access" functions, I
> can be almost sure that the error in question is what that controller
> returns when a transaction isn't acked. But that's only a heuristic - I
> could be wrong, too.

Makes sense to me.


> > > > --- g26.orig/drivers/i2c/busses/i2c-i801.c	2008-05-01 16:01:38.000000000 -0700
> > > > +++ g26/drivers/i2c/busses/i2c-i801.c	2008-05-01 16:02:58.000000000 -0700
> > 
> > Though didn't I see a patch removing this driver?
> 
> Hell no. You saw i2c-i810 go away, not i2c-i801.

10, 01 ... it's just an off-by-one error (in binary).  ;)


> > > > -			return -1;
> > > > +			return -EILSEQ;
> > > 
> > > Huh, definitely not. This error code has to so with multi-byte
> > > character encoding, that's inappropriate here.
> > 
> > No; most of the errno values get recycled.  "Illegal Byte Sequence"
> > is exactly what we got there, in fact!  I know that USB has used
> > EILSEQ for some years (indicating a lowlevel bit protocol failure),
> > and MMC is using it too.
> > 
> > So if you want to say "not", it should be for some better reason
> > than that...
> 
> When calling strerror on EILSEQ, you get: "Invalid or incomplete
> multibyte or wide character".

While "man 1 errno" says "Illegal byte sequence" ...

In any case:  as a rule, strerror() is not expected to give good
diagnostics.  Those "standard strings" are generated without any
context whatever, and so their messages have mostly been useful for
distinguishing faults rather than diagnosing them.

You may recall the case of "ENOTTY" --> "Not a TTY", for example.
That's also a good example of how code semantics evolve over time.
(Sure it's not a TTY ... that code means *other* things too.)


> This has nothing to do with the error in 
> question, and that's what I am worried about. I don't know whether it
> makes sense or not in the USB and MMC code, but in the I2C/SMBus
> context, I'm sure it does not.

It most certainly *is* an illegal byte sequence though...

 
> > > I'd return -EINVAL, or 
> > > -EREMOTEIO if you think EINVAL is unfair for the caller.
> > 
> > It's not an I/O error; the I/O actually worked, it's the bytes
> 
> True...
> 
> > that were wrong.  It's not an "argument" provided by the caller.
> > So neither of those codes seems appropriate.
> 
> The returned value depends on an argument provided by the caller,
> though.

Among an arbitrary number of other things.  It could also be
just bad device firmware ... I have in fact seen such cases:
perfectly valid SMBus requests generating bogus responses.

(This happened to be on shipping hardware, but of course it's
also easy to imagine that in developer setups too...)

Rule of thumb:  make the fault report reflect observation, not
guesses about what caused the behavior.  It's harder to get it
wrong that way.


> > > But most 
> > > likely, if the returned length is not within the SMBus specifications,
> > > it means that the caller ran an SMBus block transaction at the wrong
> > > offset or on a device that doesn't support it, so -EINVAL seems
> > > reasonable to me.
> > 
> > That's only a guess though.  All we *know* is that we saw an
> > illegal byte sequence...
> 
> That's not an illegal "sequence", sorry. The length byte by itself is
> either valid or not valid. What we saw is an illegal byte value.

It's part of a sequence.  The length byte will usually be the fourth
byte of the sequence:

    S addr/w [A] command [A] S addr/r [A] [length] A ... P

That value is perfectly legal ... it's just that in that location
within *THIS* byte sequence, it's trouble.  Mostly because that
byte is being interpreted; in other contexts, that sequence is fine.


> If you are still worried that -EINVAL has a small chance of not being
> correct, I'd rather go for -EMSGSIZE (Message too long), although the
> error message would be confusing in the 0 case.

Right...

> Even -EOVERFLOW (Value too large for defined data type)

... also confusing in the 0 case, and also wrong for PMBus (where
values 1..255 are all valid so it can't be "too large").


> would be more appropriate than -EILSEQ, I think.

How about "-EPROTO" for protocol error, then, if you're so
strongly opposed to "illegal byte sequence"?  The reason I
avoided EPROTO in that case is that it's so generic; while
we could use EILSEQ to indicate this specific case.

- Dave


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
