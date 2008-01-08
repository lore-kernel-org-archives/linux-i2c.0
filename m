From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Tue, 8 Jan 2008 20:57:42 +0100
Message-ID: <20080108205742.7b7ceaf9@hyperion.delvare>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200801061130.31774.david-b@pacbell.net>
	<20080108151817.35e05c6c@hyperion.delvare>
	<200801081052.31413.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801081052.31413.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Tue, 8 Jan 2008 10:52:31 -0800, David Brownell wrote:
> On Tuesday 08 January 2008, Jean Delvare wrote:
> > > Good point. =A0I didn't like this part much, and that function can
> > > have other uses. =A0I updated kobj_to_i2c_client() to use it too.
> >
> > I wouldn't change kobj_to_i2c_client(). Drivers using it already know
> > that their kobj is an i2c_client, so there's no need to check for that,
> > and the use cases I've seen are in runtime paths that should be fast, I
> > don't want to slow them down without a good reason.
> =

> Hmm, Mr. Grep says all the users of that are in drivers/i2c/chips ...
> basically mapping an eeprom binary attribute's kobj to the i2c_client
> of the base device.  I have to say that not only would I not call
> those "should be fast" paths (how often does anyone read eeproms??),

Sorry, I expressed myself incorrectly, I didn't mean to intend that
these were hot paths, just that this was run-time code and not
initialization code, which means that the speed matters a little more.
But the key argument here is that the current code is not broken so I
couldn't see the rationale for touching it.

> but I also have no problem using
> =

>         client =3D to_i2c_client(container_of(kobj, struct device, kobj));
> =

> instead of a fancy kobj_to_i2c_client() ... in fact, I would never
> have thought to look for any kobj_to_*() utilities.  Although Mr. Grep
> tellse me there are a few others floating around; back it out if you
> feel strongly about it.

I seem to remember that kobj_to_i2c_client() was originally declared
inside one of these drivers by the driver author and I suggested to
move it to i2c.h.

> > -=A0=A0=A0=A0=A0=A0=A0return device_for_each_child(&adapter->dev, &addr=
, i2cdev_check);
> > +=A0=A0=A0=A0=A0=A0=A0return i2c_for_each_client(adapter, &addr, i2cdev=
_check);
> >
> >		...
> > =

> > Admittedly it will slow down things a bit as each iteration of the loop
> > will have one additional level of indirection. This makes the calling
> > code somewhat simpler though. Whether it is worth the additional
> > runtime cost, I just don't know. What do you think?
> =

> My bias in such cases is towards interfaces that force less policy.
> So in this case that would be to expose i2_verify_client() instead
> of an i2c-specific iterator.  The fact that it's got lower callstack
> overhead is a bonus.  :)

OK, fine with me, I'll forget about it then.

-- =

Jean Delvare
