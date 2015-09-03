From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
Date: Thu, 3 Sep 2015 11:39:12 +0200
Message-ID: <20150903093910.GA4151@ulmo.nvidia.com>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=WvUp7xhsmXJgVzm1Awqej12hNF_QPJhrQq7z=Fa4Nnuw@mail.gmail.com>
 <20150902225008.GQ21084@n2100.arm.linux.org.uk>
 <CAD=FV=VuyQXNGt7dgF-YF7D7MDu31B-QuBdGpeC_+0b1F2=dKg@mail.gmail.com>
 <20150903091900.GX21084@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150903091900.GX21084-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2015 at 10:19:00AM +0100, Russell King - ARM Linux wrote:
> On Wed, Sep 02, 2015 at 04:43:38PM -0700, Doug Anderson wrote:
> > Russell,
> >=20
> > On Wed, Sep 2, 2015 at 3:50 PM, Russell King - ARM Linux
> > <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> > > Never copy the of_node from one device to another.  That allows the
> > > bus matching to unintentionally match the of_node against the wrong
> > > driver.
> >=20
> > Can you be more specific about what problems you'd expect.  It seems
> > like a terribly common practice to do this, but maybe I'm
> > misunderstanding:
>=20
> The problem with copying an of_node from one struct device to another
> struct device is of_match_device().
>=20
> Devices in a DT setup are bound to drivers using dev->of_node - when a
> new device or driver is registered onto a bus, the new object is matched
> against all un-bound objects (devices or drivers as appropriate)
> comparing the compatible string gained from dev->of_node against the
> list of of_device_id strings provided by the driver.
>=20
> When a match is found, the two are attempted to be bound together.
>=20
> Consider what happens when you have a platform device with an of_node,
> and you bind that to a driver matched via the compatible string.  The
> driver creates a new platform device, and copies the of_node to this
> new device so the new device can have access to the properties of the
> of_node.
>=20
> What happens next?  Does the new device bind to the same driver (and
> thus we enter an infinite loop) or does it bind to some other driver
> as the author originally hoped?  Depends whether the other driver is
> earlier in the list of drivers or later, whether it's in the kernel
> or not.
>=20
> It's less of a problem when you copy the of_node between two different
> buses, because they won't match the same driver, but this is a dangerous
> act - if stuff copies it in one direction, what's to stop someone copying
> it back to a new device on the original bus.  As soon as that happens,
> things can go awol.
>=20
> It would be a good idea if either:
> 1) this never happened
> or
> 2) we had a flag which said "ignore the of_node for driver matching"
>=20
> And yes, we do have drivers which do exactly what I said above.  They
> work through luck rather than design.

Perhaps the I2C core needs to be taught to look at the adapter's
->dev.parent->of_node in of_find_i2c_adapter_by_node(). As I understand
it the purpose for registering a separate struct device for each I2C
controller is so that there's an I2C parent for all slaves. At the same
time every controller sets up ->dev.parent, and that parent's OF node is
what we really want when we look up an I2C adapter by OF node. In other
words, the OF node by which I2C adapters are referenced is always that
of its parent device, as far as I can tell.

Wolfram, do you know of any cases where adapter->dev.of_node would not
be the same as adapter->dev.parent->of_node?

Thierry

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV6BU8AAoJEN0jrNd/PrOhZgIP/0yTBWOPyY2jqiEhIsaSkpy4
CfkWVFOHI7qjUnJJkF7srwiAfUa8RuKuDOysYFSubAHIQ+ALSO1g3Ncz0nx2RIoQ
fiBcGkA9/nTqd4L5+Um833O+vzrOly/qPr5KeePxyu1OKmTDvp9XZtF4blaJ2uiu
JpsYH7xG+AASeR0D8+rmfjG6OTmy116XRkHwxgOeK1SQ2fUSw+LFkG8LuWGMOhgN
7m/+4FHeRGTJrXbI1JwRPTYJ54F6CxfBZzWt9/eiY7xDtKfkXNNt6QxZHQsaoZLZ
8zmRHFDae703nrXTU7+scriO62eAfWdsIeJDn2sdj3E43h8b3TwAeFlnoSPmPi4s
I5yqmHpf4yRDVQk+GxQRMXvnBE7r3QD0ZvXd0JaAMrOf2N1rw6ac4pti3lLYLiHr
sBEn/346+Lz3CBSMk2nnS4bRIeLlyXveBzRFEteoU/fdz4SwDiT/kew7vAosQPvI
X9NSpKj0bB2/xXCh7cgLX9cyIX+A3dvbgQLhFimZez1rtHpg3FbHgrKOGifJULQw
iAZVxxTxWVLlzZ0g56A8cr8l7C1mItgPV7yypBSIYjAO7+lpUhypSvMLVm5B0Nny
EuxG+ULBJVLsJTN/IoYS7NObWryAjmCTzTJhR6PQSG5SQt9ByXJfcMHwMJ2m1wZj
3mTYjELb5qGk4NHWudrg
=5ikB
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
