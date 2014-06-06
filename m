From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/7] OF/ACPI/I2C: Add generic match function for the
 aforementioned systems
Date: Fri, 6 Jun 2014 13:36:53 +0100
Message-ID: <20140606123653.GP24240@lee--X1>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <1401883796-17841-8-git-send-email-lee.jones@linaro.org>
 <20140605103009.85BE4C40A4D@trevor.secretlab.ca>
 <20140605103709.GE19550@lee--X1>
 <CACxGe6vLuKygv0E7yq42qe-Lh+nMZ1wrL7PW_TAeoz55wz9q8A@mail.gmail.com>
 <20140605155509.GH24240@lee--X1>
 <20140606102446.GK2520@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140606102446.GK2520-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 06 Jun 2014, Mark Brown wrote:

> On Thu, Jun 05, 2014 at 04:55:09PM +0100, Lee Jones wrote:
> > On Thu, 05 Jun 2014, Grant Likely wrote:
>=20
> > > I still think the way to do it is to emulate the missing i2c_devi=
ce_id
> > > when calling the drivers .probe() hook by having a temporary copy=
 on
> > > the stack and filling it with data from the OF or ACPI table....
>=20
> > That's the opposite of what I'm trying to achieve.  I'm trying to g=
et
> > rid of unused i2c_device_id tables, rather than reinforce their
> > mandatory existence.  I think an i2c_of_match_device() with knowled=
ge
> > of how to match via pure DT principles (of_node/compatible) and a
> > fall-back, which is able to match on a provided of_device_id table
> > alone i.e. without the requirement of an existing of_node.
>=20
> > I've also been mulling over the idea of removing the second probe()
> > parameter, as suggested by Wolfram.  However, this has quite deep
> > ramifications which would require a great deal of driver adaptions.
>=20
> If you're going to do that another option is to refactor the probe()
> function to take the driver_data as an argument and then have the cor=
e
> pass that from whatever table it matched from rather than the entire
> i2c_device_id structure.  That way the driver just needs to supply al=
l
> the ID tables mapping binding information to whatever it needs and th=
e
> core can pass in the driver data from whatever table it matched again=
st.

Unfortunately this means we're back to the aforementioned typing
issue.  For struct {platform,i2c,spi,acpi,etc}_device_id the driver
data is a kernel ulong but the of_device_id's driver data attribute is
a void*.

I've just started work on a migration over to a new probe().  I don't
think it's all that much work, but if there are any objections I'd
prefer to hear them now rather than waste any time.

I propose to convert a couple of drivers, one which doesn't use the
driver_data and one that does, but is DT only and send them for
review.  See if Wolfram et. al like the method.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
