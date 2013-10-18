From: srinivas kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH v5 1/4] i2c: busses: i2c-st: Add ST I2C controller
Date: Fri, 18 Oct 2013 09:22:52 +0100
Message-ID: <5260EFDC.804@st.com>
References: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>  <1381754813-4679-2-git-send-email-maxime.coquelin@st.com>  <20131016151419.GA14104@ns203013.ovh.net> <525F915D.9020501@st.com>  <525FAEED.7030207@st.com> <20131017141957.GE14104@ns203013.ovh.net>  <525FF498.3060202@st.com> <1382021369.4093.44.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382021369.4093.44.camel-WzVe3FnzCwFR6QfukMTsflXZhhPuCNm+@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stephen GALLIMORE <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, Stuart MENEFY <stuart.menefy-qxv4g6HH51o@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gabriel FERNANDEZ <gabriel.fernandez-qxv4g6HH51o@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 17/10/13 15:49, Lucas Stach wrote:
> Am Donnerstag, den 17.10.2013, 15:30 +0100 schrieb srinivas kandagatl=
a:
> [...]
>> Sorry to ask this but, Where is this requirement coming from?
>> I have not spotted any thing as such in ePAPR specs.
>>
>>
>> All the spec says is.
>> =3D=3D=3D
>> The compatible property value consists of one or more strings that
>> define the specific programming model for the device. This list of
>> strings should be used by a client program for device driver selecti=
on.
>> The property value consists of a concatenated list of null terminate=
d
>> strings, *from most specific to most general.* They allow a device t=
o
>> express its compatibility with a family of similar devices, potentia=
lly
>> allowing a single device driver to match against several devices.
>> The recommended format is =E2=80=9Cmanufacturer,model=E2=80=9D, wher=
e manufacturer is a
>> string describing the name of the manufacturer (such as an OUI), and
>> model specifies the model number.
>>
>> Example:
>> compatible =3D =E2=80=9Cfsl,mpc8641-uart=E2=80=9D, =E2=80=9Cns16550"=
;
>> In this example, an operating system would first try to locate a dev=
ice
>> driver that supported fsl,mpc8641-uart. If a driver was not found, i=
t
>> would then try to locate a driver that supported the more general
>> ns16550 device type.
>> =3D=3D=3D
>>
>> The more general compatible string in this case is "st,comms-ssc-i2c=
",
>> rather than the first soc name.
>> How can a first SOC name be more general?
>>
>> As this driver is not very specific to StiH415, it is generic driver=
 for
>> ST comms-ssc-i2c block.
>>
>=20
> You just can't know if someone in the future decides to subtly change
> the register layout or make some other incompatible change to the
> comms-ssc-i2c block.
>=20
This is not the case for comms-ssc-i2c block, This IP is kind of reused
from past 10+ years(I think!!). Am not predicting the future here, but =
I
am making a informed guess from past experience that this IP would not
change in future.

Am still not happy with the idea of using first SoC for the compatible
for following reasons:

1> Generic IPs can be integrated into various vendor SoCs. For example
synopsis IP can be integrated by ST parts and other non-ST parts. What
would be the first SoC name in this case?

2> Looking at example like "arm,pl310-cache", "arm,l220-cache"... or an=
y
other generic ips, why are these IPs not encoding the first SoC name in
there compatible string? I think the answer is generic IP.

3> IMHO, the idea of first SoC might solve the problem you described,
but why would some one know about the first SoC when this was available=
=2E
In this case this IP was available may be 10+ years back on an ST40
platform. Having such old SoC names in compatible strings in the device
trees for a modern chip looks bit confusing.

4> ST generic drivers which are in kernel still use st,<IP> name, so I
would like this consistency across all the st drivers (at least the one=
s
which are going to be used by mach-sti platforms).

5> ePAPR spec clearly says that compatible string should contain "most
specific to most general" names. In this case using more generic name
makes more sense than having a specific name because its generic IP.
Allowing a single device driver to match against several devices.

6> IMHO, the compatible string should be "vendor,<IP-name>-<IP-version>=
"
rather than first SoC.


Thanks,
srini

> So as a general rule of thumb you take the first SoC where a particul=
ar
> IP block appeared as the compatible string, so you can just pick the
> name of the SoC where the incompatible change was made as the next
> string and not need to invent generic and unspecific comms-ssc-i2c-v2
> compatibles.
>=20
> Regards,
> Lucas
>=20
