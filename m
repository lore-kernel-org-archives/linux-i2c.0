From: Thadeu Lima de Souza Cascardo <cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org>
Subject: Re: [PATCH] i2c: do not use device name after device_unregister
Date: Wed, 13 Jan 2010 13:45:45 -0200
Message-ID: <20100113154544.GA1400@holoscopio.com>
References: <1263332203-5542-1-git-send-email-cascardo@holoscopio.com>
 <20100113112515.3c73ceee@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100113112515.3c73ceee-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2010 at 11:25:15AM +0100, Jean Delvare wrote:
> Hi Thadeu,
>=20
> On Tue, 12 Jan 2010 19:36:43 -0200, Thadeu Lima de Souza Cascardo wrote:
> > dev_dbg outputs dev_name, which is released with device_unregister. Thi=
s bug
> > resulted in output like this:
> >=20
> > [ 7860.470713] i2c Xy2=EF=BF=BD0: adapter [SMBus I801 adapter at 1880] =
unregistered
> >=20
> > The right output would be:
> > [   60.639233] i2c i2c-0: adapter [SMBus I801 adapter at 1880] unregist=
ered
>=20
> I can't reproduce this bug. Do you have a specific memory poisoning
> option enabled by any chance? And which kernel version are you running
> exactly?
>=20

I'm not using any memory poisoning option that I'm aware of. However, I've =
been
using SLOB as an allocator, which may make a pretty difference, I guess.

I was running some of Linus' latest published git versions, something on to=
p of
v2.6.33-rc3, commit 2c1f1895ef2aa8f0e5497893eff71304aef332e1.

> >=20
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org>
> > ---
> >  drivers/i2c/i2c-core.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index 0ac2f90..d5db0f4 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -843,6 +843,9 @@ int i2c_del_adapter(struct i2c_adapter *adap)
> >  				 adap->dev.parent);
> >  #endif
> > =20
> > +	/* device name is gone after device_unregister */
> > +	dev_dbg(&adap->dev, "adapter [%s] unregistered\n", adap->name);
> > +
> >  	/* clean up the sysfs representation */
> >  	init_completion(&adap->dev_released);
> >  	device_unregister(&adap->dev);
> > @@ -855,8 +858,6 @@ int i2c_del_adapter(struct i2c_adapter *adap)
> >  	idr_remove(&i2c_adapter_idr, adap->nr);
> >  	mutex_unlock(&core_lock);
> > =20
> > -	dev_dbg(&adap->dev, "adapter [%s] unregistered\n", adap->name);
> > -
> >  	/* Clear the device structure in case this adapter is ever going to be
> >  	   added again */
> >  	memset(&adap->dev, 0, sizeof(adap->dev));
>=20
> The device structure is embedded in struct i2c_adapter, so its memory
> can't be reused before the i2c_adapter itself is freed, which can't
> happen before the end of function i2c_del_adapter(). Until recently,
> the device name was embedded in the device structure so the code above
> was fine. But apparently this changed some 9 months ago...
>=20

The device may not be reused, but it's name is in its kobject, which alloca=
tes
memory using kvasprintf, and releases it when device_del ends up calling
kobject_put. So, anyway, we should not access memory that has been released=
=2E I
guess trying some poisoning option or changing to SLOB may help you hit the
bug.

> --=20
> Jean Delvare

Best Regards,
Cascardo.

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktN6qgACgkQyTpryRcqtS2T3QCfbR8cvmrQM0cnCJImKJW8KgGy
RtEAn11dr7xxXlCeT+/kDyze5kvIvr5r
=LqjR
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
