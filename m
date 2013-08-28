From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-designware: make *CNT values configurable
Date: Wed, 28 Aug 2013 17:34:31 +0200
Message-ID: <20130828153429.GB7066@ab42.lan>
References: <20130712085140.GY4898@intel.com>
 <51E0E76B.1040304@pobox.com>
 <20130716111616.GA25835@ab42.lan>
 <51E6ACBE.7000509@pobox.com>
 <20130722131706.GA24081@ab42.lan>
 <51EFE550.1000507@pobox.com>
 <20130805093126.GE20936@ab42.lan>
 <520D8B30.9000602@pobox.com>
 <20130821143915.GA3046@ab42.lan>
 <52183D87.40703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52183D87.40703-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Aug 24, 2013 at 01:58:47PM +0900, Shinya Kuribayashi wrote:
> On 8/21/13 11:39 PM, Christian Ruppert wrote:
> >On Fri, Aug 16, 2013 at 11:15:12AM +0900, Shinya Kuribayashi wrote:
> >>On 8/5/13 6:31 PM, Christian Ruppert wrote:
> >>>On Wed, Jul 24, 2013 at 11:31:44PM +0900, Shinya Kuribayashi wrote=
:
> >>>>As said before, all t_SCL things should go away.  Please forget
> >>>>about 100kbps, 400kbps, and so on.  Bus/clock speed is totally
> >>>>pointless concept for the I2C bus systems.  For example, as long
> >>>>as tr/tf, tHIGH/tLOW, tHD;STA, etc. are met by _all_ devices in a
> >>>>certain I2C bus, it doesn't matter that the resulting clock speed
> >>>>is, say 120 kbps with Standard-mode, or even 800 kbps for Fast-mo=
de.
> >>>>Nobody in the I2C bus doesn't care about actual bus/clock speed.
> >>>>
> >>>>We don't have to care about the resulting bus speed, or rather
> >>>>we should/must not check to see if it's within the proper range.
> >>>
> >>>Actually, the I2C specification clearly defines f_SCL;max (and thu=
s
> >>>implies t_SCL;min), both in the tables and the timing diagrams. Wh=
y can
> >>>we ignore this constraint while having to meet all the others?
> >>
> >>If we meet t_r, t_f, t_HIGH, t_LOW (and t_HIGH in this DW case),
> >>f_SCL;max will be met by itself.
> >
> >I'm not sure if I agree with this:
> >
> >Standard mode:
> >        t_r;min          0ns
> >        t_f;min     +    0ns
> >        t_HIGH;min  + 4000ns
> >        t_LOW;min   + 4700ns
> >        1/f_SCL     =3D 8700ns
> >    =3D=3D> f_SCL       =3D 115kHz    =3D=3D>    violation of f_SCL;=
max=3D100kHz
> >
> >Fast mode (let's assume V_DD =3D 5.5V):
> >        t_r;min         20ns
> >        t_f;min     +   20ns
> >        t_HIGH;min  +  600ns
> >        t_LIW;min   + 1300ns
> >        1/f_SCL     =3D 1940ns
> >    =3D=3D> f_SCL       =3D 515kHz    =3D=3D>    violation of f_SCL;=
max=3D400kHz
>=20
> It's more realistic to calculate with say 50ns < tr,tf < 300ns,
> than with tt =3D tf =3D 0ns or <20ns.  Even if with such real tf/tr
> times, there is cases where f_SCL can be greater than 100/400Hz.

I agree. I just used these values to illustrate my point.

> I understand what you mean, but that was not my point.  See below.
>=20
> >>And again, all I2C master and
> >>slave devices in the bus don't care about f_SCL; what they do care
> >>are t_f, t_r, t_HIGH, t_LOW, and so on.  That's why I'm saying
> >>f_SCL is pointless and has no value for HCNT/LCNT calculations.
> >
> >I partially agree: If I2C devices don't care about f_SCL but only ab=
out
> >t_r, t_f, t_HIGH and t_LOW there's no need to respect the f_SCL;max
> >constraint. If this is the case, I'm wondering why it is part of the
> >specification, though.
>=20
> With t_r;max and t_f;max,
>=20
> Standard mode:
>         t_r;max       1000ns (max time applied)
>         t_f;max     +  300ns (max time applied)
>         t_HIGH;min  + 4000ns
>         t_LOW;min   + 4700ns
>         1/f_SCL     =3D10000ns
>     =3D=3D> f_SCL       =3D 100kHz    =3D=3D> f_SCL;max for Standard-=
mode
>=20
> Fast mode:
>         t_r;max        300ns (max time applied)
>         t_f;max     +  300ns (max time applied)
>         t_HIGH;min  +  600ns
>         t_LIW;min   + 1300ns
>         1/f_SCL     =3D 2500ns
>     =3D=3D> f_SCL       =3D 400kHz    =3D=3D> f_SCL;max for Fast-mode
>=20
> f_SCL;max is defined as a resulting clock frequency with the
> combination of:
>=20
> (1) the max. conditions of t_r and t_f
> (2) the min. conditions of t_HIGH and t_LOW
>=20
> We can try to meet t_HIGH;min and t_LOW;min, but we can't meet
> t_r;min nor t_f;min in the actual systems.  The t_r and t_f are
> _minimum requisites_ for the I/O buffer characteristic of the
> master and the board designs, hence necessarily contain some
> time margin.

I agree.

> f_SCL is anything more than the resulting speed of (1) + (2),
> so I don't think we need to adjust HCNT/LCNT values at all.
> If with t_r < t_r;max and t_f < t_f;max, and you've got a faster
> clock speed than f_SCL;max, then it's a bonus and we can accept
> it gratefully.

Here I'm not sure: The I2C specification clearly states f_SCL min/max
requirements in table 10. I'm feeling a bit uneasy patching a driver
with (to date) rather pessimistic bus timings to something which might
be over-optimistic. If I submit a patch for this I would like to be sur=
e
not to break existing systems. How do other drivers manage this?

> >>I'd make a compromise proposal; it's fine to make sure whether the
> >>resulting f_SCL is within a supported range, but should not make a
> >>correction of HCNT/LCNT values.  Just report warning messages that
> >>some parameters/calculations might be mis-configured an/or wrong.
> >
> >Not sure if this is a good idea: If f_SCL is met by design I'm perfe=
ctly
> >happy with dropping the t_HIGH/t_LOW adjustment code, no need to blo=
at
> >the kernel with confusing warnings. If f_SCL is not automatically me=
t we
> >must either make sure t_HIGH/t_LOW are adjusted or we must take the
> >decision to ignore that constraint and document the reasons behind t=
hat
> >decision accordingly.
>=20
> I tried to write my thought down, not sure well-explained, though.
>=20
> Notes:
>=20
> * As long as tHD;SDA issue remains in the DW I2C core, we need to
>   have t_HIGH with a relatively lager value than necessary.  In
>   such a case, the resulting f_SCL can never exceed f_SCL;max.

Not in my calculations (Let's assume fast mode with all rise and fall
times being 50ns as you say above and f_sys =3D 50MHz):
HCNT =3D f_SYS * (t_HD;STA + t_f;SDA) - 3
-> t_HIGH =3D t_HD_STA + t_f;SDA + 4 / f_sys
          =3D 0.6us + 0.05 us + 0.08 us =3D 0.73us
LCNT =3D f_SYS * (t_f;SCL + t_LOW)
-> t_LOW  =3D 0.05us + 1.3us =3D 1.35us

-> f_SCL =3D 1 / (t_HIGH + t_LOW + t_r;SCL + t_f;SCL)
         =3D 1 / (0.73us + 1.35 us + 0.05 us + 0.05us) =3D 458MHz  > 40=
0MHz

> * I also wonder which values do you think should be adjusted to meet
>   f_SCL;max, HCNT or LCNT, and why is that?  I think it's hard to
>   explain, isn't it?

Originally I thought it would be best to adjust both in the same way.
Thinking about your question I guess it might be more in the spirit of
I2C to only adjust LCNT. The specification (table 10) allows for both,
there are no max values specified for either.

Greetings,
  Christian

--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
