From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-designware: make *CNT values configurable
Date: Wed, 10 Jul 2013 18:56:35 +0200
Message-ID: <20130710165634.GA30693@ab42.lan>
References: <1373283927-21677-1-git-send-email-mika.westerberg@linux.intel.com>
 <20130708134216.GB6402@ab42.lan>
 <20130709084402.GF4898@intel.com>
 <20130709161927.GC30236@ab42.lan>
 <20130710105215.GY4898@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130710105215.GY4898-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 10, 2013 at 01:52:15PM +0300, Mika Westerberg wrote:
> On Tue, Jul 09, 2013 at 06:19:28PM +0200, Christian Ruppert wrote:
> > What I meant is the following: The clock cycle time Tc is composed =
of
> > the four components
> >=20
> >   Tc =3D Th + Tf + Tl + Tr
> >=20
> > where
> >   Th: Time during which the signal is high
> >   Tf: Falling edge transition time
> >   Tl: Time during which the signal is low
> >   Tr: Rising edge transition time
> >=20
> > The I2C specification specifies a minimum for Tl and Th and a range=
 (or
> > maximum) for Tr and Tf. A maximum frequency is specified as the
> > frequency obtained by adding the minima for Th and Tl to the maxima=
 of
> > Tr ant Tf.
> > Since as you said, transition times are very much PCB dependent, on=
e way
> > to guarantee the max. frequency constraint (and to achieve a consta=
nt
> > frequency at its max) is to define the constants
> > Th' =3D Th + Tf :=3D Th_min + Tf_max
> > Tl' =3D Tl + Tr :=3D Tl_min + Tr_max
> >=20
> > and to calculate the variables
> > Th =3D Th' - Tf
> > Tl =3D Tl' - Tr
> > in function of Tf and Tr of the given PCB.
>=20
> If I understand the above, it leaves Tf and Tr to be PCB specific and=
 then
> these values are passed to the core driver from platform data, right?

That would be the idea: Calculate Th' and Tl' in function of the desire=
d
clock frequency and duty cycle and then adapt these values using
measured transition times. What prevented me from implementing this
rather academic approach are the following comments in
i2c-designware-core.c:

/*
 * DesignWare I2C core doesn't seem to have solid strategy to meet
 * the tHD;STA timing spec.  Configuring _HCNT based on tHIGH spec
 * will result in violation of the tHD;STA spec.
 */

/* ...
 * This is just experimental rule; the tHD;STA period
 * turned out to be proportinal to (_HCNT + 3).  With this setting,
 * we could meet both tHIGH and tHD;STA timing specs.
 * ...
 */

If I interpret this right, the slow down of the clock is intentional to
meet tHD;STA timing constraints.

> I'm thinking that passing directly the "measured" *CNT values from th=
e
> platform data makes this even more accurate (given that information i=
s
> available). And if you only have the Tf and Tr for your board, you ca=
n have
> custom calculation done in the platform part of the driver that takes=
 them
> into account, and then passes these custom *CNT values to the core.

Well, as in the previous discussion on SDA hold time, Tf and Tr are
physical values whereas the register values are clock dependent and
probably not appropriate at least for device tree usage (or cases where
the clock speed might change). If I understand you correctly, ACPI is
more register oriented and able to cope with this outside of the OS?

> > > At least on Intel
> > > hardware we have an ACPI method that returns directly the optimum=
 *CNT
> > > values.
> >=20
> > I don't know ACPI very well and if it deals with register values
> > directly your patch is probably the right thing.
>=20
> Our FW people decided to have a custom ACPI method that returns the c=
orrect
> values to be used in the Windows I2C driver. It returns direct *CNT
> register values that have been measured to be good for a given PCB.
>=20
> > The timing calculation in the driver seems a bit strange to me, how=
ever
> > (see above), but I never dared touching it because I never had time=
 to
> > dive into the code deep enough and I was just wondering if it was
> > possible to fix it at the same time.
>=20
> It would be good if we can fix this for non-ACPI devices as well. Is =
it
> hard to add similar properties to the driver specific Device Tree bin=
dings?

I think it would be quite trivial to add properties for either the
register values or the transition time values. For SDA hold time we
concluded that time values would be more adequate which brings us to th=
e
question of better understanding the hack for tHD;SDA. Otherwise we
might break something. Do you think your team which determines the
tHD;SDA values could give us some guidance on that?

> Wolfram, do you have any input on this?

--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
