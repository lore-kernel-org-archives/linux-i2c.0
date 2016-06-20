From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] i2c-smbus: Don't report duplicate alerts
Date: Mon, 20 Jun 2016 11:31:31 +0200
Message-ID: <20160620093131.GL24234@mail.corp.redhat.com>
References: <1453222848-20457-1-git-send-email-minyard@acm.org>
 <20160303205754.GE1711@katana>
 <1457086557.4527.15.camel@chaos.site>
 <5720CC77.2080507@acm.org>
 <20160619120619.GA3072@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56658 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501AbcFTJbh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 20 Jun 2016 05:31:37 -0400
Content-Disposition: inline
In-Reply-To: <20160619120619.GA3072@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

On Jun 19 2016 or thereabouts, Wolfram Sang wrote:
> On Wed, Apr 27, 2016 at 09:28:07AM -0500, Corey Minyard wrote:
> > On 03/04/2016 04:15 AM, Jean Delvare wrote:
> > >Le Thursday 03 March 2016 =C3=A0 21:57 +0100, Wolfram Sang a =C3=A9=
crit :
> > >>On Tue, Jan 19, 2016 at 11:00:48AM -0600, minyard@acm.org wrote:
> > >>>From: Corey Minyard <cminyard@mvista.com>
> > >>>
> > >>>Getting the same alert twice in a row is legal and normal,
> > >>>especially on a fast device (like running in qemu).  Kind of
> > >>>like interrupts.  So don't report duplicate alerts, and deliver
> > >>>them normally.
> > >>>
> > >>>Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > >>Looks plausible to me, but I never used SMBALERT myself. Any chan=
ce this
> > >>can cause a regression? Jean, what do you think?
> > >I'm afraid I had a good reason to add this check back then. I'll t=
est
> > >with my ADM1032 evaluation board when I get back home (tomorrow at=
 the
> > >earliest.) Maybe my hardware was misbehaving, in which case I agre=
e any
> > >filtering should be done at the device driver level. But I must do=
uble
> > >check what the SMBus specification says too.
> >=20
> > I looked at the SMBus specification and I couldn't find anything th=
at
> > would speak to this particular issue.  It says it has to stop asser=
ting
> > the interrupt when the ack is received on the bus, but it doesn't s=
ay
> > when it can re-assert the interrupts.
> >=20
> > I will say that without this change SMBus alerts are fairly useless
> > with IPMI over SMBus on both real hardware and in qemu.  It just
> > spews out these warning messages in qemu, and it prints them out
> > periodically on real hardware.
> >=20
> > To give an idea of what's happening here, on IPMI over SMBus, the
> > IPMI controller (BMC) will signal that it needs the host to do some=
thing
> > using an alert.  The driver does an I2C write to send a request to =
the
> > BMC to find out what it needs.  The BMC performs the request then
> > signals with an SMBus alert that the response is ready.  If the BMC=
 is
> > very fast (like in the qemu case) or the host gets delayed enough b=
efore
> > coming back to this loop, the BMC will have the response ready and
> > reassert alert before the next check in the loop.
> >=20
> > I don't see a way to fix this that handles both scenarios.
>=20
> Jean: any news on this?
>=20
> Adding Benjamin to CC since he dealt with alerts recently, maybe he h=
as
> something to add?

Not much. I can see why Corey has such a patch but I miss why this chec=
k
was in in the first place. Given the scheduling and the irq and the
worker, I'd say having a duplicate alert is valid in case the device
reassert the line as soon as it gets contacted by the host.

I think we need Jean to check whether the invalid duplicate alert was a
misbehavior, just an extra check, or actually required in some cases.

Cheers,
Benjamin

>=20
> >=20
> > -corey
> >=20
> > >Either way the patch's subject is misleading. Should be "Don't fil=
ter
> > >out duplicate alerts" or something like that.
> > >
> > >>>---
> > >>>  drivers/i2c/i2c-smbus.c | 7 -------
> > >>>  1 file changed, 7 deletions(-)
> > >>>
> > >>>diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> > >>>index 94765a8..cecd423 100644
> > >>>--- a/drivers/i2c/i2c-smbus.c
> > >>>+++ b/drivers/i2c/i2c-smbus.c
> > >>>@@ -75,7 +75,6 @@ static void smbus_alert(struct work_struct *wo=
rk)
> > >>>  {
> > >>>  	struct i2c_smbus_alert *alert;
> > >>>  	struct i2c_client *ara;
> > >>>-	unsigned short prev_addr =3D 0;	/* Not a valid address */
> > >>>  	alert =3D container_of(work, struct i2c_smbus_alert, alert);
> > >>>  	ara =3D alert->ara;
> > >>>@@ -99,18 +98,12 @@ static void smbus_alert(struct work_struct *=
work)
> > >>>  		data.flag =3D status & 1;
> > >>>  		data.addr =3D status >> 1;
> > >>>-		if (data.addr =3D=3D prev_addr) {
> > >>>-			dev_warn(&ara->dev, "Duplicate SMBALERT# from dev "
> > >>>-				"0x%02x, skipping\n", data.addr);
> > >>>-			break;
> > >>>-		}
> > >>>  		dev_dbg(&ara->dev, "SMBALERT# from dev 0x%02x, flag %d\n",
> > >>>  			data.addr, data.flag);
> > >>>  		/* Notify driver for the device which issued the alert */
> > >>>  		device_for_each_child(&ara->adapter->dev, &data,
> > >>>  				      smbus_do_alert);
> > >>>-		prev_addr =3D data.addr;
> > >>>  	}
> > >>>  	/* We handled all alerts; re-enable level-triggered IRQs */
> > >
> >=20
