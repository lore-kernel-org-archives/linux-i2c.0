From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.25-git] i2c_adapters:  return -Errno not -1
Date: Mon, 12 May 2008 16:05:37 +0200
Message-ID: <20080512160537.13e7739a@hyperion.delvare>
References: <200805012046.07885.david-b@pacbell.net>
	<200805110117.23023.david-b@pacbell.net>
	<20080511122647.1e04c9c0@hyperion.delvare>
	<200805110923.44693.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805110923.44693.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Sun, 11 May 2008 09:23:43 -0700, David Brownell wrote:
> On Sunday 11 May 2008, you wrote:
> > My point exactly. I am fine with both -ENXIO and -ENODEV, pick the one
> > you like, then make sure all drivers are using it consistently.
> 
> I'll go with ENXIO "no such device or address" as being a bit more
> appropriate for addressing issues.  Driver probe() code can return
> ENODEV in the case where there is a device there ... but the wrong
> one for that driver.

OK, fine with me.

> > (...)
> > When calling strerror on EILSEQ, you get: "Invalid or incomplete
> > multibyte or wide character".
> 
> While "man 1 errno" says "Illegal byte sequence" ...

Yes, it's unfortunately inconsistent. Ideally man 1 errno would be
generated automatically by calling strerror on all error codes.

> > (...)
> > The returned value depends on an argument provided by the caller,
> > though.
> 
> Among an arbitrary number of other things.  It could also be
> just bad device firmware ... I have in fact seen such cases:
> perfectly valid SMBus requests generating bogus responses.
> 
> (This happened to be on shipping hardware, but of course it's
> also easy to imagine that in developer setups too...)
> 
> Rule of thumb:  make the fault report reflect observation, not
> guesses about what caused the behavior.  It's harder to get it
> wrong that way.

I have to agree...

> > (...)
> > That's not an illegal "sequence", sorry. The length byte by itself is
> > either valid or not valid. What we saw is an illegal byte value.
> 
> It's part of a sequence.  The length byte will usually be the fourth
> byte of the sequence:
> 
>     S addr/w [A] command [A] S addr/r [A] [length] A ... P
> 
> That value is perfectly legal ... it's just that in that location
> within *THIS* byte sequence, it's trouble.  Mostly because that
> byte is being interpreted; in other contexts, that sequence is fine.

Going down that route, everything is part of a sequence, so we would
have to stop using -EINVAL and use -EILSEQ everywhere. Numbers by
themselves are never invalid, what makes them invalid is the context in
which they are encountered, and for a computer, a given context has to
come from a sequence of some kind.

So I'm not buying this, sorry. Especially when the first 3 bytes are
emitted by the master and the 4th one comes from the slave, calling
them a sequence as a whole is almost dishonest ;)

> > If you are still worried that -EINVAL has a small chance of not being
> > correct, I'd rather go for -EMSGSIZE (Message too long), although the
> > error message would be confusing in the 0 case.
> 
> Right...
> 
> > Even -EOVERFLOW (Value too large for defined data type)
> 
> ... also confusing in the 0 case, and also wrong for PMBus (where
> values 1..255 are all valid so it can't be "too large").
> 
> > would be more appropriate than -EILSEQ, I think.
> 
> How about "-EPROTO" for protocol error, then, if you're so
> strongly opposed to "illegal byte sequence"?  The reason I
> avoided EPROTO in that case is that it's so generic; while
> we could use EILSEQ to indicate this specific case.

-EPROTO sounds good to me. We're not using it anywhere in the i2c
subsystem so there's no need to worry about it being "too generic".

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
