From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-designware: make *CNT values configurable
Date: Tue, 9 Jul 2013 18:19:28 +0200
Message-ID: <20130709161927.GC30236@ab42.lan>
References: <1373283927-21677-1-git-send-email-mika.westerberg@linux.intel.com>
 <20130708134216.GB6402@ab42.lan>
 <20130709084402.GF4898@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130709084402.GF4898-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 09, 2013 at 11:44:02AM +0300, Mika Westerberg wrote:
> On Mon, Jul 08, 2013 at 03:42:17PM +0200, Christian Ruppert wrote:
> > On Mon, Jul 08, 2013 at 02:45:26PM +0300, Mika Westerberg wrote:
> > > The DesignWare I2C controller has high count (HCNT) and low count=
 (LCNT)
> > > registers for each of the I2C speed modes (standard and fast). Th=
ese
> > > registers are programmed based on the input clock speed in the dr=
iver.
> > >=20
> > > However, that is not always the most accurate way. For example on=
 Intel
> > > BayTrail we have 100MHz input clock and calculated *CNT values re=
sult as
> > > measured by one of our team:
> > >=20
> > >  Standard mode: 100.25kHz
> > >  Fast mode    : 315.41kHZ
> > >=20
> > > The fast mode speed is over 20% lower than what is expected.
> >=20
> > We have observed similar issues and I am wondering if this effect i=
s due
> > to the overly-pessimistic formulas in i2c_dw_scl_lcnt and
> > i2c_dw_scl_hcnt. The comments in these functions are a bit confusin=
g and
> > I don't pretend having fully understood what the intention is. I'm
> > having the impression that defining the arguments tf in function of=
 the
> > hardware would be the "correct" way to achieve better clock accurac=
y.
>=20
> Well, that's not the only timing parameter specified in the I2C spec.=
 We
> also have tr among other things (even though the dw driver doesn't us=
e it).

Exactly. Ant T_HD;STA which is mentioned somewhere in the comment and
one of the reasons why I never dared touching these functions. The fact
that the designware IP doesn't seem to manage all timings makes this
function quite difficult to understand.

> > > It might be
> > > that there are things like strenght of the pull-up resistors, bus
> > > capacitance etc. that are very platform specific and have an effe=
ct on the
> > > clock signal.
> >=20
> > I believe tf is supposed to model these things. I just haven't clea=
rly
> > understood how. In my understanding, transition times should be
> > subtracted rather than added to cycle times or am I getting somethi=
ng
> > fundamentally wrong here?
>=20
> I'm not sure, honestly :-) I believe tf is the same tf that is in the=
 I2C
> spec, meaning fall time of both SCL and SDA signals and the spec meas=
ures
> one clock cycle to be from end of the first tf to the end of the seco=
nd
> (fig. 27 in the I2C spec). If I'm reading it right then it means addi=
ng
> instead of substracting.
> Do you have any suggestions how we could use tf here?

What I meant is the following: The clock cycle time Tc is composed of
the four components

  Tc =3D Th + Tf + Tl + Tr

where
  Th: Time during which the signal is high
  Tf: Falling edge transition time
  Tl: Time during which the signal is low
  Tr: Rising edge transition time

The I2C specification specifies a minimum for Tl and Th and a range (or
maximum) for Tr and Tf. A maximum frequency is specified as the
frequency obtained by adding the minima for Th and Tl to the maxima of
Tr ant Tf.
Since as you said, transition times are very much PCB dependent, one wa=
y
to guarantee the max. frequency constraint (and to achieve a constant
frequency at its max) is to define the constants
Th' =3D Th + Tf :=3D Th_min + Tf_max
Tl' =3D Tl + Tr :=3D Tl_min + Tr_max

and to calculate the variables
Th =3D Th' - Tf
Tl =3D Tl' - Tr
in function of Tf and Tr of the given PCB.

> At least on Intel
> hardware we have an ACPI method that returns directly the optimum *CN=
T
> values.

I don't know ACPI very well and if it deals with register values
directly your patch is probably the right thing. The timing calculation
in the driver seems a bit strange to me, however (see above), but I
never dared touching it because I never had time to dive into the code
deep enough and I was just wondering if it was possible to fix it at th=
e
same time. If ACPI bypasses the function alltogether this is probably
not applicable.

--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
