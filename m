From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c-smbus: Don't report duplicate alerts
Date: Fri, 04 Mar 2016 11:15:57 +0100
Message-ID: <1457086557.4527.15.camel@chaos.site>
References: <1453222848-20457-1-git-send-email-minyard@acm.org>
	 <20160303205754.GE1711@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39919 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756431AbcCDKP7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 4 Mar 2016 05:15:59 -0500
In-Reply-To: <20160303205754.GE1711@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: minyard@acm.org, linux-i2c@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

Le Thursday 03 March 2016 =C3=A0 21:57 +0100, Wolfram Sang a =C3=A9crit=
 :
> On Tue, Jan 19, 2016 at 11:00:48AM -0600, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> >=20
> > Getting the same alert twice in a row is legal and normal,
> > especially on a fast device (like running in qemu).  Kind of
> > like interrupts.  So don't report duplicate alerts, and deliver
> > them normally.
> >=20
> > Signed-off-by: Corey Minyard <cminyard@mvista.com>
>=20
> Looks plausible to me, but I never used SMBALERT myself. Any chance t=
his
> can cause a regression? Jean, what do you think?

I'm afraid I had a good reason to add this check back then. I'll test
with my ADM1032 evaluation board when I get back home (tomorrow at the
earliest.) Maybe my hardware was misbehaving, in which case I agree any
filtering should be done at the device driver level. But I must double
check what the SMBus specification says too.

Either way the patch's subject is misleading. Should be "Don't filter
out duplicate alerts" or something like that.

> > ---
> >  drivers/i2c/i2c-smbus.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >=20
> > diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> > index 94765a8..cecd423 100644
> > --- a/drivers/i2c/i2c-smbus.c
> > +++ b/drivers/i2c/i2c-smbus.c
> > @@ -75,7 +75,6 @@ static void smbus_alert(struct work_struct *work)
> >  {
> >  	struct i2c_smbus_alert *alert;
> >  	struct i2c_client *ara;
> > -	unsigned short prev_addr =3D 0;	/* Not a valid address */
> > =20
> >  	alert =3D container_of(work, struct i2c_smbus_alert, alert);
> >  	ara =3D alert->ara;
> > @@ -99,18 +98,12 @@ static void smbus_alert(struct work_struct *wor=
k)
> >  		data.flag =3D status & 1;
> >  		data.addr =3D status >> 1;
> > =20
> > -		if (data.addr =3D=3D prev_addr) {
> > -			dev_warn(&ara->dev, "Duplicate SMBALERT# from dev "
> > -				"0x%02x, skipping\n", data.addr);
> > -			break;
> > -		}
> >  		dev_dbg(&ara->dev, "SMBALERT# from dev 0x%02x, flag %d\n",
> >  			data.addr, data.flag);
> > =20
> >  		/* Notify driver for the device which issued the alert */
> >  		device_for_each_child(&ara->adapter->dev, &data,
> >  				      smbus_do_alert);
> > -		prev_addr =3D data.addr;
> >  	}
> > =20
> >  	/* We handled all alerts; re-enable level-triggered IRQs */


--=20
Jean Delvare
SUSE L3 Support
