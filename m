From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 03/14] net: davicom: dm9000: allow to pass MAC address through mac_addr module parameter
Date: Wed, 12 Feb 2020 09:13:52 +0100
Message-ID: <C7991495-F233-4186-82A2-43C39898C8B3@goldelico.com>
References: <cover.1581457290.git.hns@goldelico.com> <4e11dd4183da55012198824ca7b8933b1eb57e4a.1581457290.git.hns@goldelico.com> <20200211222506.GP19213@lunn.ch> <CAMuHMdX6f+aGZjQSQqVjT=npojq5xH2k2Js8qxG5=n26Z4uFBw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdX6f+aGZjQSQqVjT=npojq5xH2k2Js8qxG5=n26Z4uFBw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Paul Cercueil <paul@crapouillou.net>, Paul Boddie <paul@boddie.org.uk>, Alex Smith <alex.smith@imgtec.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "David S. Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Andi Kleen <ak@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Miquel Raynal <miquel.raynal@bootlin.com>, =?utf-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>, Richard Fontana <rfontana@redhat.com>, Allison Randal <allison@lohutok.net>
List-Id: linux-i2c@vger.kernel.org


> Am 12.02.2020 um 09:07 schrieb Geert Uytterhoeven =
<geert@linux-m68k.org>:
>=20
> On Tue, Feb 11, 2020 at 11:25 PM Andrew Lunn <andrew@lunn.ch> wrote:
>> On Tue, Feb 11, 2020 at 10:41:20PM +0100, H. Nikolaus Schaller wrote:
>>> This is needed to give the MIPS Ingenic CI20 board a stable MAC =
address
>>> which can be optionally provided by vendor U-Boot.
>>>=20
>>> For get_mac_addr() we use an adapted copy of from ksz884x.c which
>>> has very similar functionality.
>>>=20
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>=20
>> Hi Nikolaus
>>=20
>> Please split these patches by subsystem. So this one patch needs to =
go
>> via netdev.
>>=20
>>> +static char *mac_addr =3D ":";
>>> +module_param(mac_addr, charp, 0);
>>> +MODULE_PARM_DESC(mac_addr, "MAC address");
>>=20
>> Module parameters are not liked.
>>=20
>> Can it be passed via device tree? The driver already has code to get
>> it out of the device tree.
>=20
> Yep, typically U-Boot adds an appropriate "local-mac-address" property =
to the
> network device's device node, based on the "ethernet0" alias.
>=20
> However, the real clue here may be "vendor U-Boot", i.e. no support =
for the
> above?

Yes. It is a fallback solution like it is implemented for ksz884x.c to =
make it
work with existing (older) U-Boot installation.

Maybe I should better clarify this in the commit message for v2 (which =
goes
to netdev only).

BR and thanks,
Nikolaus
