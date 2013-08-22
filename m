From: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Subject: Re: passing two interrupts two an I2C driver
Date: Thu, 22 Aug 2013 12:44:04 +0100
Message-ID: <1377171844.10707.32.camel@hornet>
References: <520E3B8F.9010800@samsung.com> <520E7417.3090606@wwwdotorg.org>
	 <20130819084227.GC3719@e106331-lin.cambridge.arm.com>
	 <5214AA52.2060209@samsung.com> <1377088624.10707.23.camel@hornet>
	 <20130821175446.GI26118@sirena.org.uk> <1377163408.10707.29.camel@hornet>
	 <20130822112619.GD26118@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130822112619.GD26118-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org" <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, "s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2013-08-22 at 12:26 +0100, Mark Brown wrote:
> On Thu, Aug 22, 2013 at 10:23:28AM +0100, Pawel Moll wrote:
>=20
> > If the platform data used to carry the (custom) irq data, the DT-po=
wered
> > driver could interrogate the DT on is own, couldn't it? Of course t=
here
> > should be some helper available, maybe something of that sort? (war=
ning,
> > untested)
>=20
> Yes, that's probably the most straightforward thing - we'd need to
> either have the bindings specify which interrupt must be first for
> reading i2c->irq or just have the drivers always do a name based look=
up
> if there's more than one interrupt.

=2E.. or make sure that of_i2c_register_devices() does *not* set i2c->i=
rq
(or rather: set it to 0) when there is more than one interrupt in the
tree...

Pawe=C5=82
