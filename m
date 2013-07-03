From: Christian Ruppert <christian.ruppert@abilis.com>
Subject: Re: [PATCH v10] i2c-designware: make SDA hold time configurable
Date: Wed, 3 Jul 2013 16:59:19 +0200
Message-ID: <20130703145918.GE3929@ab42.lan>
References: <20130625163902.GA2973@katana>
 <20130703143835.GD3929@ab42.lan>
 <201307031642.30380.arnd@arndb.de>
 <201307031644.09669.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201307031644.09669.arnd@arndb.de>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: vincent.stehle@freescale.com, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robherring2@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Pierrick Hascoet <pierrick.hascoet@abilis.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 03, 2013 at 04:44:09PM +0200, Arnd Bergmann wrote:
> On Wednesday 03 July 2013, Christian Ruppert wrote:
> > On Wed, Jul 03, 2013 at 04:20:03PM +0200, Arnd Bergmann wrote:
> > > On Wednesday 03 July 2013, Christian Ruppert wrote:
> > > > On Wed, Jul 03, 2013 at 01:43:11PM +0200, Arnd Bergmann wrote:
> > > > > On Wednesday 26 June 2013, Wolfram Sang wrote:
> > > > > >   On Wed, Jun 26, 2013 at 10:55:06AM +0200, Christian Ruppe=
rt wrote:
> > > > > > > This patch makes the SDA hold time configurable through d=
evice tree.
> > > > > > >=20
> > > > > > > Signed-off-by: Christian Ruppert <christian.ruppert@abili=
s.com>
> > > > > > > Signed-off-by: Pierrick Hascoet <pierrick.hascoet@abilis.=
com>
> > > > > >=20
> > > > > > Applied to for-next, thanks for keeping at it and providing=
 lots of
> > > > > > useful information. Much appreciated!
> > > > >=20
> > > > > Sorry, but I got a regression that I didn't find reported els=
ewhere
> > > > > so far, even though it breaks a lot of the ARM defconfig buil=
ds:
> > > > >=20
> > > > > drivers/built-in.o: In function `dw_i2c_probe':
> > > > > /git/arm-soc/drivers/i2c/busses/i2c-designware-platdrv.c:125:=
 undefined reference to `__udivdi3'
> > > > >=20
> > > > > I suspect you want something like the change below.
> > > >=20
> > > > This looks similar to a patch Vincent Stehle submitted yesterda=
y, see
> > > > https://lkml.org/lkml/2013/7/2/145
> > >=20
> > > Thanks for the link. Actually his patch looks wrong to me, becaus=
e
> > >=20
> > >  dev->sda_hold_time =3D div_u64((u64)ic_clk * ht + 500000, 100000=
0);=20
> > >=20
> > > assigns the division remainder to sda_hold_time, not the quotient=
=2E
> >=20
> > Hrmmm... At least when I tested it this morning on an ARC architect=
ure
> > it worked as intended and returned the quotient. Does that mean we =
have
> > an issue with this function on ARC? Can anyone who knows these func=
tions
> > better than I comment?
>=20
> ARC just uses the generic version of div_u64, which is defined in lib=
/div64.c.
>=20
> I suspect that the division remainder just happens to work well enoug=
h for
> you to not cause any run-time error. You could try adding a printk
> in that function to show the values you get on ARC.

That's what I did and they were identical to the original values
calculated with /. I just looked at include/linux/math64.h and found th=
e
following comment:

/**
 * div_u64 - unsigned 64bit divide with 32bit divisor
 *
 * This is the most common 64bit divide and should be used if possible,
 * as many 32bit archs can optimize this variant better than a full 64b=
it
 * divide.
 */

Although this doesn't explicitly state what the function returns to me
this sounds more like the quotient is returned rather than the remainde=
r?

--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
