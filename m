From: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Thu, 22 Jan 2015 09:30:26 +0800
Message-ID: <1421890226.5693.4.camel@mtksdaap41>
References: <1421404418-50718-1-git-send-email-eddie.huang@mediatek.com>
	 <1421404418-50718-3-git-send-email-eddie.huang@mediatek.com>
	 <20150118101816.GF22880@pengutronix.de>
	 <1421810004.15468.825.camel@mtksdaap41>
	 <1421821809.11671.117.camel@mtksdaap41>
	 <20150121081519.GS22880@pengutronix.de>
	 <1421844580.11671.145.camel@mtksdaap41>
	 <20150121153131.GV22880@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150121153131.GV22880-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.orgAnders
List-Id: linux-i2c@vger.kernel.org


Hi,

On Wed, 2015-01-21 at 16:31 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Wed, Jan 21, 2015 at 08:49:40PM +0800, Yingjoe Chen wrote:
> > On Wed, 2015-01-21 at 09:15 +0100, Uwe Kleine-K=C3=B6nig wrote:
<...>
> > > > > > > +static int mtk_i2c_remove(struct platform_device *pdev)
> > > > > > > +{
> > > > > > > +	struct mtk_i2c *i2c =3D platform_get_drvdata(pdev);
> > > > > > > +
> > > > > > > +	i2c_del_adapter(&i2c->adap);
> > > > > > > +	free_i2c_dma_bufs(i2c);
> > > > > > > +	platform_set_drvdata(pdev, NULL);
> > > > > > > +
> > > > > > Here you need to make sure that no irq is running when i2c_=
del_adapter
> > > > > > is called.
> > > > > OK, add check here
> > > >=20
> > > > I thought after i2c_del_adapter() is complete, all i2c_transfer=
 for this
> > > > adapter is completed. If this is true, then i2c clock is alread=
y off and
> > > > we won't have any on-going transfer/pending irq.
> > > Consider that there is an ongoing transaction and before it compl=
etes
> > > the adapter-device is unbound from the driver. Then i2c_del_adapt=
er is
> > > called which frees the resources managed by the core, then the de=
vice's
> > > completion irq triggers and the freed adapter is used which proba=
bly
> > > results in an oops.
> >=20
> > Not sure if I missed anything. i2c_transfer() is a synchronize call=
=2E If
> > we fixed timeout issue you mentioned in mtk_i2c_transfer(), it will=
 turn
> > off clock before it return, which disable any transaction and clear=
 all
> > pending irq.
> There is no synchronization to prevent unbinding the i2c-bus device
> while there is a i2c transfer on the wire. i2c_del_adapter only takes
> i2c-core.c's &core_lock while i2c_transfer takes &adapter->bus_lock.
> If you want to test for it: do something like that:
>=20
> 	while true; do dd if=3D/sys/bus/i2c/.../eeprom of=3D/dev/null; done
>=20
> and while this is running do:
>=20
> 	cd /sys/bus/platform/drivers/mt-i2c
> 	while true; do
> 		echo 1100d000.i2c > unbind;
> 		sleep 1;
> 		echo 1100d000.i2c > bind;
> 		sleep 1;
> 	done
> =20
> > Your scenario can only happens when one thread is still running in
> > i2c_transfer/algo->master_xfer and the other thread is trying to re=
move
> > the device. If that happened, then every device data access in
> > mtk_i2c_transfer might cause oops. I looked at some i2c drivers and
> > can't find any checking for this case, I can't find anything preven=
t i2c
> > device removal before pending i2c_transfer complete either. Would y=
ou
> > give me an example?
> I just noticed that even "my" driver is affected. If the above recipe
> makes your driver barf there is something to fix, if not ... hmm, the=
n
> maybe there is more synchronization than I'm aware of or my recipe is
> wrong.
>=20
> At least another driver author believed me:
> http://thread.gmane.org/gmane.linux.drivers.i2c/21531/focus=3D21662

If there is no synchronization mechanism then every driver is affected.
We should add the check in the core instead of fixing it in every
driver. We could take the bus_lock in i2c_del_adapter() and check if th=
e
adapter is removed in __i2c_transfer(), this should fix the problem.

Wolfram, what do you think about this? Is there anything we are missing=
?

Joe.C


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
