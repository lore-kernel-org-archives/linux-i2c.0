From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3] [MFD] i2c-htcpld: Add the HTCPLD driver
Date: Tue, 19 Jan 2010 12:09:17 +0100
Message-ID: <20100119110916.GB554@sortiz.org>
References: <6cb013311001060647s3bce5e63mbae1a10036a14ae1@mail.gmail.com>
 <1263056154-20085-1-git-send-email-darkstar6262@gmail.com>
 <20100118124855.GB8036@sortiz.org>
 <20100118153624.GA13811@sortiz.org>
 <6cb013311001181323q79aba15dif165ff41d79734a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6cb013311001181323q79aba15dif165ff41d79734a7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Cory,

On Mon, Jan 18, 2010 at 01:23:25PM -0800, Cory Maccarrone wrote:
> On Mon, Jan 18, 2010 at 7:36 AM, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>=
 wrote:
> > On Mon, Jan 18, 2010 at 01:48:55PM +0100, Samuel Ortiz wrote:
> >> Hi Cory,
> >>
> >> I applied this patch, thanks a lot.
> >> In the future, I'd like to see the GPIO handling from this patch m=
oved to
> >> drivers/gpio. Could you please look at that ?
>=20
> Absolutely, thanks for applying it!  I'll send out a follow-on patch
> as soon as I've got that change.
>=20
> > I forgot to add that I also made it build on non ARM patforms. This=
 line:
> > set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> > became:
> > #ifdef CONFIG_ARM
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_irq_flags(irq, IRQF_VALID | IRQF=
_PROBE);
> > #else
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_irq_probe(irq);
> > #endif
> >
>=20
> Ah, cool, thanks!
After the build failure reports from linux-next, I also had to fix a co=
uple
more things:

1) htcpld_set_type(): You're not supposed to access irq_desc directly, =
you
should use irq_to_desc() instead
2) Kconfig: we need to depend on I2C=3Dy, to avoid the problematic case=
 of
having I2C_CORE=3Dm and HTC_I2CPLD=3Dy

Please let me know if you're not ok with those changes. You can grab th=
em from
the for-next branch of my kernel.org tree, at
git://git.kernel.org/pub/scm/linux/kernel/git/sameo/mfd-2.6.git for-nex=
t

Cheers,
Samuel.


> - Cory

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
