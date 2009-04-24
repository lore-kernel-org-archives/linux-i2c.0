From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Fri, 24 Apr 2009 10:52:56 +0200
Message-ID: <20090424085256.GA26169@pengutronix.de>
References: <49ED6AD3.2060808@gmx.de> <49ED6F03.5050107@grandegger.com> <49ED9132.9050806@gmx.de> <20090421095112.GB3100@pengutronix.de> <49EDC487.8010201@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49EDC487.8010201-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> You like it more complicated? Ok, here it is:

Thanks, that gave me a bigger picture.

> You talk about my reading of the class entry from DTS?
> No, I don't understand how other systems are affected by this.
> They don't read this entry of _my_ .dts file.
> Seems there is a general misunderstanding...

DTS is convention. One convention is to keep it OS-neutral. If you use
something out of this convention like "linux,i2c-class", you motivate
others to follow you. In fact, this is exactly what happened because
i2c-cpm defined such a thing (and people who are watching the DTS not
drifting away seemed to have missed it). If other people use it, other
OS could be forced to evaluate a property which is named  "linux" and
may be, in addition, inadequate for their purpose.

DTS (or better the OF devicetree) faces the danger of so many private
extensions that there is no common thing (=3D convention) at the end of
the day rendering it unusable. This is why adding new properties is
handled with care (and should always be CCed to devicetree-discuss).

> Many adapters do initialization of .class in adapter code. A few do not.
> I haven't checked, but assume the PPC ones, as they have DTS. Thats Ok,

(Would be nice if you did. Knowledge is better than assumption in this
case)

I think most drivers are old enough to have a .class as it was useful
back then and nobody cared to remove it. Newer drivers, especially
embedded ones, usually don't have it right from the beginning, also on
ARM..., as probing is not wanted.

> as long DTS is really used. In at least one other adapter it is: Exactly
> Wolfgang Grandegger, who is responsible for removal of the original
> default initialization, showed me, that it is done in i2c-cpm!

You mean setting the class variable through DTS? Yeah, this was a good
outcome of this thread. I will submit a patch to remove it soonish. It
just slipped through, should have never been there IMHO.

> And how do you want to implement setting the class attribute?

Not at all. I see ".class" as a reminiscent to overcome some flaws of
the old binding model. If we finally got rid of that we can surely think
of a more elegant way to enforce instanciation of clients run-time. And
with that, probably get rid of .class altogether. D'accord, Jean?

> Allowing only clients that are mentioned in DTS?

For now, yes. This is still the common case (=3Davoid probing). Until a
mainline solution comes up (which is needed, I agree on that), not so
common cases could simply patch the driver to add a .class field.

> How should it work on systems without DTS?

i2c_board_info? (no offence, sometimes it is hard to tell if you know
all details and still see a valid problem or if you are just missing
details. If the first one is the case, please be a bit more elaborative
on the problem.)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknxfegACgkQD27XaX1/VRt38wCgsmhdod12zJjRQw9ybFWyJYvs
HnsAn2ChLL/LFbOL46zE4nkzmd28FmY4
=e1MY
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
