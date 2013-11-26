From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-designware-pci: Index Haswell ULT bus names from
 0
Date: Tue, 26 Nov 2013 14:09:59 +0100
Message-ID: <20131126130959.GI7427@katana>
References: <1382326010-4554-1-git-send-email-bleung@chromium.org>
 <1382326010-4554-3-git-send-email-bleung@chromium.org>
 <20131021065804.GX3521@intel.com>
 <CANLzEksGqD30Cefh3r2urH-ToxWzkxAnTJZiY07yX2Py58FQPw@mail.gmail.com>
 <20131114180538.GK11022@katana>
 <CANLzEksP1nRfBaQ3-sSouOYL4C+oLKiE75eHfFdEzLmrQKn3dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4BlIp4fARb6QCoOq"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANLzEksP1nRfBaQ3-sSouOYL4C+oLKiE75eHfFdEzLmrQKn3dQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Duncan Laurie <dlaurie-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--4BlIp4fARb6QCoOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2013 at 06:14:18PM -0800, Benson Leung wrote:
> Hi Wolfram,
>=20
> On Thu, Nov 14, 2013 at 10:05 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> >> In the chromeos_laptop driver, I do by-name matching of i2c busses to
> >> find busses and instantiate devices, so there is value to have each
> >> named something predictable.
> >
> > Any why don't you use fixed bus numbers which you can attach the devices
> > to?
>=20
> On this particular set of systems, there are two other classes of i2c
> adapters that use dynamically assigned bus numbers, specifically the
> i915 gmbus adapters, and the i801_smbus adapter. This is why
> chromeos_laptop uses the name matching, as some of the boards that it
> supports have devices on those dynamic busses.

I am not sure I get the problem. If you use i2c_register_board_info() to
register the known devices on the designware busses the dynamically
assigned numbers are guaranteed to be enumarated higer than the static
ones. Check drivers/i2c/i2c-boardinfo.c.

Regards,

   Wolfram


--4BlIp4fARb6QCoOq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSlJ2nAAoJEBQN5MwUoCm29e8P/1XOhNVeFaCfPRiMYYaplfOt
l3GSUiAJmZrlBc8dNTcsQj23Oj/+34/JD/LyAxZRA1CWU7/QugsLWEbMsUpkHwp1
NRA5HTzQNJZK5Lxb8Z0R6EXKIdPE4ZRINVdAkm9ECregzXQrIa4k8laRAHil6RND
OLl+Y6rdSQx6BFkMMoJju3ySqom0iArxIWNm0SgdnSCDVrez9ZmKx1TAV3bZ9ORI
biLuPBk88nrtYwAMIeX39hldOtmlLVev4iwOLIMGoMPX3+pTFBLrNKaOEhNEiniy
Skc+LPLJ5RRpu8KR4y+xWGOwqb5GMiCuWS+Z6y7Zjet4Bhstqh4FX4mebGvUS6tW
/0tIjs0Rfjhv2Nn4qdJy0aju+k2XBj/2Y7g9Thg7NAsF60h9sGVynE/prq3ClEM7
gUhmUCGR5aL/J/E12h8BHlL16MbieAgNr9966LQ6YLsqwnbAG/MWbv1tBKhNYol8
S8AOPNwHAojJP+uRVLnYGqHUMdyGtHpSQ6tI/ddycHrEtns1iq3q7TapWIFtkSi2
lad/63khK64XKcyfevuGlqIjmWWJqQPPJevakeLp4tgMsH7+E/QEDEzfIrkcZvBw
HVLwZMXtTfxYAEa0TvCmMqo0Ncix0Kfesckn+7PuFRhgPTiHP9M6i+9U38d3AaEF
giu3TRWUi6I3eVejmF0e
=iI6l
-----END PGP SIGNATURE-----

--4BlIp4fARb6QCoOq--
