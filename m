From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 11/15] drivers/mfd: Enable Device Tree for ab8500-core
	driver
Date: Thu, 10 May 2012 11:26:57 +0100
Message-ID: <20120510102657.GD3190@n2100.arm.linux.org.uk>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org> <1336155805-18554-12-git-send-email-lee.jones@linaro.org> <CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Mattias WALLIN <mattias.wallin-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 09, 2012 at 11:02:27AM +0200, Linus Walleij wrote:
> On Fri, May 4, 2012 at 8:23 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrot=
e:
>=20
> > This patch will allow the ab8500-core driver to be probed and set u=
p
> > when booting when Device Tree is enabled. This includes platform ID
> > look-up which identifies the machine it is currently running on. If
> > we are undergoing a DT enabled boot, we will refuse to setup each o=
f
> > the other ab8500-* devices, as they will be probed individually by =
DT.
> >
> > Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> (...)
> > + =A0 =A0 =A0 else if (np)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D of_property_read_u32(np, "ste=
ricsson,irq-base", &ab8500->irq_base);
> > +
> > + =A0 =A0 =A0 if (ab8500->irq_base =3D=3D 0) {
>=20
> Shouldn't this be (av8500->irq_base =3D=3D NO_IRQ) now that we're tra=
nisitioning to
> use 0 as NO_IRQ?

No it shouldn't.  We want new drivers to be rejecting on explicitly zer=
o
IRQ numbers and not using NO_IRQ at all.  We want to get rid of NO_IRQ
entirely.

At the moment, NO_IRQ is a marker for "this is a mistake which needs
fixing" and allows them to be found by grep.

What we need is more of an effort so that platforms do not start number=
ing
IRQs at zero, but start at one.

(I could fix up SA11x0, which would then allow the SA1111 code to be fi=
xed,
but I've not had time to look at that during this last cycle.  Others n=
eed
their maintainers who know the code to fix them.)

I brought up the issue of the new introduction of NO_IRQ in the previou=
sly
clean versatile express code, and failed to get any reply.

So, I think what I'll do when I've eliminated all those that I can do i=
s
to remove the definition from our asm/irq.h and cause a load of build
errors in linux-next.  This seems to be the _only_ way to motivate peop=
le
into fixing these kinds of issues.  Which is awfully sad.  I'd much
rather people just had the carrot instead but as ever its proven many
times that people just ignore such things.
