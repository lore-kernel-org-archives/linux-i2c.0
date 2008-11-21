From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.27-rc7] i2c: smbalert# support
Date: Fri, 21 Nov 2008 08:24:55 -0800
Message-ID: <200811210824.55601.david-b@pacbell.net>
References: <200804161434.54335.laurentp@cse-semaphore.com> <200811181401.34809.david-b@pacbell.net> <20081121151808.324ca78c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081121151808.324ca78c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday 21 November 2008, Jean Delvare wrote:
> --- linux-2.6.28-rc6.orig/drivers/i2c/i2c-core.c=A0=A0=A0=A0=A0=A0=A0=
=A02008-11-21 11:01:53.000000000 +0100
> +++ linux-2.6.28-rc6/drivers/i2c/i2c-core.c=A0=A0=A0=A0=A02008-11-21 =
14:55:29.000000000 +0100
> @@ -446,6 +446,7 @@ static int i2c_do_alert(struct device *d
> =A0static void smbus_alert(struct work_struct *work)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0struct i2c_adapter=A0=A0=A0=A0=A0=A0*bus;
> +=A0=A0=A0=A0=A0=A0=A0unsigned short=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pre=
v_addr =3D 0;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0bus =3D container_of(work, struct i2c_adapter=
, alert);
> =A0=A0=A0=A0=A0=A0=A0=A0for (;;) {
> @@ -465,11 +466,18 @@ static void smbus_alert(struct work_stru
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0data.flag =3D (status=
 & 1) !=3D 0;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0data.addr =3D status =
>> 1;
> +
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (data.addr =3D=3D pr=
ev_addr) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
dev_warn(&bus->dev, "Duplicate SMBALERT# from dev "
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0"0x%02x, skipping\n", data.addr);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
break;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_dbg(&bus->dev, "S=
MBALERT# %s from dev 0x%02x\n",
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0data.flag ? "true" : "false", data.addr);
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Notify driver for =
the device which issued the alert. */
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0device_for_each_child=
(&bus->dev, &data, i2c_do_alert);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0prev_addr =3D data.addr=
;
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0/* We handled all alerts; reenable level-trig=
gered IRQs. */
>=20
> What do you think?

It's a start.  If this is a level-triggered IRQ and the device is
still raising the IRQ ... we'd need something more drastic, since
the IRQ itself would be stuck on; wouldn't want to re-enable it.
Edge triggered IRQs would be easier to cope with.

Do you have a handle on why the device was malfunctioning?

- Dave
