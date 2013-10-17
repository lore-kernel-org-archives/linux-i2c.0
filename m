From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v5 1/4] i2c: busses: i2c-st: Add ST I2C controller
Date: Thu, 17 Oct 2013 16:49:29 +0200
Message-ID: <1382021369.4093.44.camel@weser.hi.pengutronix.de>
References: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>
	 <1381754813-4679-2-git-send-email-maxime.coquelin@st.com>
	 <20131016151419.GA14104@ns203013.ovh.net> <525F915D.9020501@st.com>
	 <525FAEED.7030207@st.com> <20131017141957.GE14104@ns203013.ovh.net>
	 <525FF498.3060202@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <525FF498.3060202-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinivas kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stephen GALLIMORE <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, Stuart MENEFY <stuart.menefy-qxv4g6HH51o@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gabriel FERNANDEZ <gabriel.fernandez-qxv4g6HH51o@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Am Donnerstag, den 17.10.2013, 15:30 +0100 schrieb srinivas kandagatla:
[...]
> Sorry to ask this but, Where is this requirement coming from?
> I have not spotted any thing as such in ePAPR specs.
>=20
>=20
> All the spec says is.
> =3D=3D=3D
> The compatible property value consists of one or more strings that
> define the specific programming model for the device. This list of
> strings should be used by a client program for device driver selectio=
n.
> The property value consists of a concatenated list of null terminated
> strings, *from most specific to most general.* They allow a device to
> express its compatibility with a family of similar devices, potential=
ly
> allowing a single device driver to match against several devices.
> The recommended format is =E2=80=9Cmanufacturer,model=E2=80=9D, where=
 manufacturer is a
> string describing the name of the manufacturer (such as an OUI), and
> model specifies the model number.
>=20
> Example:
> compatible =3D =E2=80=9Cfsl,mpc8641-uart=E2=80=9D, =E2=80=9Cns16550";
> In this example, an operating system would first try to locate a devi=
ce
> driver that supported fsl,mpc8641-uart. If a driver was not found, it
> would then try to locate a driver that supported the more general
> ns16550 device type.
> =3D=3D=3D
>=20
> The more general compatible string in this case is "st,comms-ssc-i2c"=
,
> rather than the first soc name.
> How can a first SOC name be more general?
>=20
> As this driver is not very specific to StiH415, it is generic driver =
for
> ST comms-ssc-i2c block.
>=20

You just can't know if someone in the future decides to subtly change
the register layout or make some other incompatible change to the
comms-ssc-i2c block.

So as a general rule of thumb you take the first SoC where a particular
IP block appeared as the compatible string, so you can just pick the
name of the SoC where the incompatible change was made as the next
string and not need to invent generic and unspecific comms-ssc-i2c-v2
compatibles.

Regards,
Lucas
--=20
Pengutronix e.K.                           | Lucas Stach               =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-507=
6 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
