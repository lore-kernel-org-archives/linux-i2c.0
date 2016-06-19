From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-smbus: Don't report duplicate alerts
Date: Sun, 19 Jun 2016 14:06:19 +0200
Message-ID: <20160619120619.GA3072@tetsubishi>
References: <1453222848-20457-1-git-send-email-minyard@acm.org>
 <20160303205754.GE1711@katana>
 <1457086557.4527.15.camel@chaos.site>
 <5720CC77.2080507@acm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58120 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbcFSMGa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 19 Jun 2016 08:06:30 -0400
Content-Disposition: inline
In-Reply-To: <5720CC77.2080507@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org, Corey Minyard <cminyard@mvista.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2016 at 09:28:07AM -0500, Corey Minyard wrote:
> On 03/04/2016 04:15 AM, Jean Delvare wrote:
> >Le Thursday 03 March 2016 =C3=A0 21:57 +0100, Wolfram Sang a =C3=A9crit :
> >>On Tue, Jan 19, 2016 at 11:00:48AM -0600, minyard@acm.org wrote:
> >>>From: Corey Minyard <cminyard@mvista.com>
> >>>
> >>>Getting the same alert twice in a row is legal and normal,
> >>>especially on a fast device (like running in qemu).  Kind of
> >>>like interrupts.  So don't report duplicate alerts, and deliver
> >>>them normally.
> >>>
> >>>Signed-off-by: Corey Minyard <cminyard@mvista.com>
> >>Looks plausible to me, but I never used SMBALERT myself. Any chance this
> >>can cause a regression? Jean, what do you think?
> >I'm afraid I had a good reason to add this check back then. I'll test
> >with my ADM1032 evaluation board when I get back home (tomorrow at the
> >earliest.) Maybe my hardware was misbehaving, in which case I agree any
> >filtering should be done at the device driver level. But I must double
> >check what the SMBus specification says too.
>=20
> I looked at the SMBus specification and I couldn't find anything that
> would speak to this particular issue.  It says it has to stop asserting
> the interrupt when the ack is received on the bus, but it doesn't say
> when it can re-assert the interrupts.
>=20
> I will say that without this change SMBus alerts are fairly useless
> with IPMI over SMBus on both real hardware and in qemu.  It just
> spews out these warning messages in qemu, and it prints them out
> periodically on real hardware.
>=20
> To give an idea of what's happening here, on IPMI over SMBus, the
> IPMI controller (BMC) will signal that it needs the host to do something
> using an alert.  The driver does an I2C write to send a request to the
> BMC to find out what it needs.  The BMC performs the request then
> signals with an SMBus alert that the response is ready.  If the BMC is
> very fast (like in the qemu case) or the host gets delayed enough before
> coming back to this loop, the BMC will have the response ready and
> reassert alert before the next check in the loop.
>=20
> I don't see a way to fix this that handles both scenarios.

Jean: any news on this?

Adding Benjamin to CC since he dealt with alerts recently, maybe he has
something to add?

>=20
> -corey
>=20
> >Either way the patch's subject is misleading. Should be "Don't filter
> >out duplicate alerts" or something like that.
> >
> >>>---
> >>>  drivers/i2c/i2c-smbus.c | 7 -------
> >>>  1 file changed, 7 deletions(-)
> >>>
> >>>diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> >>>index 94765a8..cecd423 100644
> >>>--- a/drivers/i2c/i2c-smbus.c
> >>>+++ b/drivers/i2c/i2c-smbus.c
> >>>@@ -75,7 +75,6 @@ static void smbus_alert(struct work_struct *work)
> >>>  {
> >>>  	struct i2c_smbus_alert *alert;
> >>>  	struct i2c_client *ara;
> >>>-	unsigned short prev_addr =3D 0;	/* Not a valid address */
> >>>  	alert =3D container_of(work, struct i2c_smbus_alert, alert);
> >>>  	ara =3D alert->ara;
> >>>@@ -99,18 +98,12 @@ static void smbus_alert(struct work_struct *work)
> >>>  		data.flag =3D status & 1;
> >>>  		data.addr =3D status >> 1;
> >>>-		if (data.addr =3D=3D prev_addr) {
> >>>-			dev_warn(&ara->dev, "Duplicate SMBALERT# from dev "
> >>>-				"0x%02x, skipping\n", data.addr);
> >>>-			break;
> >>>-		}
> >>>  		dev_dbg(&ara->dev, "SMBALERT# from dev 0x%02x, flag %d\n",
> >>>  			data.addr, data.flag);
> >>>  		/* Notify driver for the device which issued the alert */
> >>>  		device_for_each_child(&ara->adapter->dev, &data,
> >>>  				      smbus_do_alert);
> >>>-		prev_addr =3D data.addr;
> >>>  	}
> >>>  	/* We handled all alerts; re-enable level-triggered IRQs */
> >
>=20

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZoq6AAoJEBQN5MwUoCm2HssP/2PzHJqEeOGsjm5KDO9MnjYa
HRc/p9wM46HaM1ji7mEFhQeTjhmTl9Oh7EfS7bGv8uPdEp/SGCaNMtZwS3ms9z45
iXYEu4GXp+X9rg0F6z+8cA/O1VQHUtFShPwmR9+bJFgMj3zXm0M/fc0gtQ2M0z0I
nSvpLvpidxqFjr9bUdQJmS4FWzbp4GLIC+WwblUIuUdVyPpG4AQx6GgD3+SYAZsQ
tivxJlUOUlpGJybSAtRomxlSKZKFiljNpsGra4Wd6hZv+viiXE1MEC3/ad2SgK+O
gKTLeqGp2FB4XlDuR+JhoS8bUv49TCtHm8kQBkA5gCOqcGRpgXlsf8EhqvEAUMS9
ZQKZClM0T27yzDf3ytW7YDPhBXhk+EU2vjuxVjLhGfx0xkxfMVYYpfIvjV427RoV
g6AlWfcOe2QAREirrZILKxJTHhXdczpNfnxslV3xk3cP6CBThKi2cZjcEvgtxXXF
szGiiOCnvZLWV+7SC09mu4o2aeNzO4XkYZa857Kox6E8mTue0Zz9XGt9HrwMqOg+
0NcIrvR5Swo4hIPPiFBORP//7fbn8yA5pMXpo3IHIBeMKwf8ZW9dgL6BzmIHGzlj
UwPV6RKfrurGYhJuydexMtPttyJcMiB3i5sbxchO/nZb/J8L0USBZxN2Ma1KFVOZ
Iv/E1EFYXYudvs4ZnM4s
=hre1
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
