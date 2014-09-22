From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for AMD I2C controller
Date: Mon, 22 Sep 2014 19:22:52 +0200
Message-ID: <20140922172251.GA30685@ab42.lan>
References: <1411032367-20274-1-git-send-email-mika.westerberg@linux.intel.com>
 <1411032367-20274-2-git-send-email-mika.westerberg@linux.intel.com>
 <20140920093633.GG1612@katana>
 <20140922091207.GJ1786@lahna.fi.intel.com>
 <20140922122905.GA13321@ab42.lan>
 <C2D7FE5348E1B147BCA15975FBA230753C5DA425@IN01WEMBXA.internal.synopsys.com>
 <20140922140020.GB1786@lahna.fi.intel.com>
 <C2D7FE5348E1B147BCA15975FBA230753C5DA47D@IN01WEMBXA.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA230753C5DA47D-uUKrqVzojAgF5QVroWrzJvufCSb+aD3WLzEdoUbNIic@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 22, 2014 at 02:16:25PM +0000, Vineet Gupta wrote:
> On Monday 22 September 2014 07:30 PM, Mika Westerberg wrote:
> >>> COMMON_CLK is not selected by the ARC architecture in general. Ho=
wever,
> >>> > > we do select COMMON_CLK in the TB10x platform which uses the =
designware
> >>> > > I2C driver so this new dependency is no problem for us.
> >>> > >
> >>> > > Vineet,
> >>> > >
> >>> > > Do you see any issues with this on other existing ARC platfor=
ms, e.g.
> >>> > > arcfpga?
> >> >=20
> >> > So what needs to be done, COMMON_CLK needs to be defined in arch=
/arc/Kconfig ? And
> >> > if so why ?
> > Without COMMON_CLK, you are not able to select I2C_DESIGNWARE_PLATF=
ORM
> > anymore. So if something on ARC depends on this driver then we eith=
er
> > need the COMMON_CLK there or figure out alternative way to fix Carl=
's
> > problem.
>=20
> I have not seen the orig patch, but it seems COMMON_CLK is already be=
ing selected
> by TB10x, do we still need it in arch/arcKconfig, for all ARC platfor=
ms ?

Sorry for the confusion, I should have given you some context. Mika
has checked that designware i2c is used by some ARC platforms but he
didn't say which ones. The orig patch makes COMMON_CLK a requirement fo=
r
designware i2c.

I checked that we're fine for TB10x (we need COMMON_CLK anyway) but
since you weren't in copy I just wanted to make sure that none of the
other ARC platforms (which don't seem to select COMMON_CLK) use
designware i2c and thus run into trouble.

If there is no designware i2c in any of your platforms, simply ignore
my message. From my point of view there is no need to move "select
COMMON_CLK" up to the ARC architecture level.

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
