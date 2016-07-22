From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: Re: DT connectors, thoughts
Date: Fri, 22 Jul 2016 14:16:06 +1000
Message-ID: <20160722041606.GK15941@voom.fritz.box>
References: <577ACE0D.9050700@gmail.com>
 <20160718142037.GS16769@voom.fritz.box>
 <442C02A9-582D-4FD8-8F05-7A6FCD5B6BCA@konsulko.com>
 <20160721134208.GD12120@voom.fritz.box>
 <A1018E27-B604-4DD5-ADBA-95EF76F6DDAC@konsulko.com>
 <CAL_JsqLc0N8o2Nc_dEcZChJqWyN3UtZEgzLd=j6dR=1y3xOvdA@mail.gmail.com>
 <2C63DCA2-385A-4EE3-A957-F1DBEF7929F8@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWJxWxNlJUNgDlXi"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2C63DCA2-385A-4EE3-A957-F1DBEF7929F8-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--pWJxWxNlJUNgDlXi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2016 at 10:15:36PM +0300, Pantelis Antoniou wrote:
> Hi Rob,
>=20
> > On Jul 21, 2016, at 22:09 , Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >=20
> > On Thu, Jul 21, 2016 at 9:14 AM, Pantelis Antoniou
> > <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org> wrote:
> >> Hi David,
> >>=20
> >>> On Jul 21, 2016, at 16:42 , David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org=
> wrote:
> >>>=20
> >>> On Wed, Jul 20, 2016 at 11:59:44PM +0300, Pantelis Antoniou wrote:
> >>>> Hi David,
> >>>>=20
> >>>> Spent some time looking at this, and it looks like it=E2=80=99s goin=
g to the right direction.
> >>>>=20
> >>>> Comments inline.
> >>>>=20
> >>>>> On Jul 18, 2016, at 17:20 , David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6rL0yjEaa7Ru@public.gmane.org=
au> wrote:
> >>>>>=20
> >>>>> Hi,
> >>>>>=20
> >>>>> Here's some of my thoughts on how a connector format for the DT cou=
ld
> >>>>> be done.  Sorry it's taken longer than I hoped - I've been pretty
> >>>>> swamped in my day job.
> >>>>>=20
> >>>>> This is pretty early thoughts, but gives an outline of the approach=
 I
> >>>>> prefer.
> >=20
> > [...]
> >=20
> >>>>>            i2c: i2c@... {
> >>>>>            };
> >>>>>            intc: intc@... {
> >>>>>                    #interrupt-cells =3D <2>;
> >>>>>            };
> >>>>>    };
> >>>>>=20
> >>>>>    connectors {
> >>>>>            widget1 {
> >>>>>                    compatible =3D "foo,widget-socket";
> >>>>>                    w1_irqs: irqs {
> >>>>>                            interrupt-controller;
> >>>>>                            #address-cells =3D <0>;
> >>>>>                            #interrupt-cells =3D <1>;
> >>>>>                            interrupt-map-mask =3D <0xffffffff>;
> >>>>>                            interrupt-map =3D <
> >>>>>                                    0 &intc 7 0
> >>>>>                                    1 &intc 8 0
> >>>>>> ;
> >>>>>                    };
> >>>>=20
> >>>> This is fine. We need an interrupt controller node.
> >>>=20
> >>> Actually I think we only need an interrupt nexus, not an interrupt
> >>> controller (in IEEE1275 terminology).  (An interrupt controller would
> >>> generally require it's own driver, to ack/mask irqs, whereas this just
> >>> demonstrates the routing to an existing interrupt controller).  Which
> >>> makes that example slightly incorrect (it shouldn't have the
> >>> interrupt-controller property).
> >>=20
> >> Hmm, as far as I can tell we only have a concept of an interrupt contr=
oller
> >> in the kernel. An interrupt nexus is something new. We should get by w=
ithout
> >> a driver but hacking the interrupt lookup path at DT.
> >=20
> > Interrupt nexus is the interrupt-map property which is fully
> > supported. I'd expect we'll end up with a gpio nexus (i.e. gpio-map)
> > for connector gpios, too.
> >=20
>=20
> Is interrupt-map enough to cover all our cases? On all the cases that I s=
ee it

That's the most common use, but it's pretty general.  It basically
maps (source irq desc, source unit address) tuples to (dest interrupt
controller, dest irq desc) tuples.  The interrupt-map-mask lets us
ignore some parts of that input.

One of the weirder uses was in the DTs for the DMA controller used for
the Ethernet on many PPC 4xx chips.  Those had multiple irqs, wired to
different interrupt controllers on some SoCs, but the DT only allows
to specify a single interrupt-parent for a device.  We worked around
that by including an interrupt nexus in the node itself, which mapped
a fake local irq number (just an index) to the right irqs and
controllers.

> Is the example above well defined? As far as I can tell interrupt-control=
ler is not
> needed.

The 'interrupt-controller' property should not be there, that was an
error on my part.  The rest should be ok.

The plugin piece would need to specify the interrupt-parent as w1_irs
on all its nodes, otherwise they'd just inherit from the parent bus
for their fragment, which might have odd results.

We should probably see if we can figure out a way to enforce that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pWJxWxNlJUNgDlXi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkZ4GAAoJEGw4ysog2bOSz8oP/3Q6HNUo7uN37L99ZxdB3JNv
FovLzlS7D2jhQlnyl8GQmXPXgUDVndGZxaPyJvcfEStdTay49SJ643nW0zVo4zWo
tgw7elvqkvKv39eXNAQdeOtTv8WtlJTMnYy1JG+6I3x8U4/YhJ6g69bTCAnJ4C2O
OtZX0P7vrxfL9KAg/Y7ASejHWlQAxFBzcfkRkVd711CD9+tWKybAlPWeifbCKIPw
+SCDnmgLL8RpO94THnsa0XpW+3lSsybWpkCvCzDrppmu5mOkYqWvpBWBxsf9wbt/
XMxpKi8gadEHHh7L6hTy87n96XSFJ37TZOZNiEVCunyIw4jMb8DvA0VzsW2pkEh2
l7gmh66UYgtgMqo1BbyuxeVoN59l/xiGi5vjvs2tmo8x9OEgy35Jv8okxx19pD38
0TXh8zOx/WQlVPXtV8V1AL5U6BPSZ8HJz0PFfE2JKAzN46F8LmzvA3PNyi4X13B/
i1h5A+1IFCfRrANIPUrIP86DBHE/78/L8bsnIe+QoSTIDxkaONeE4rrlLkLUA67H
ILtchl4c0Zj1kPrQwYulCmC64gcwzhbMxf7rLIfkox/6iuzefx0ASj4hgf55W0iT
hrJwe7qlYFE2WQgB4zIduI5ARngUIX5QqIO1oJcM5fTa/5AkU0IVRmMLUnQ4EImd
LEzN50DxdGFd5FOG50J+
=yUYP
-----END PGP SIGNATURE-----

--pWJxWxNlJUNgDlXi--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
