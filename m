From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH REBASE] i2c-designware: make SDA hold time configurable
Date: Mon, 17 Jun 2013 11:23:31 +0300
Message-ID: <20130617082331.GG11878@intel.com>
References: <20130514110745.GA10906@intel.com>
 <1368536642-7158-1-git-send-email-christian.ruppert@abilis.com>
 <20130610152954.GE2987@katana>
 <20130612144743.GB8102@ab42.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130612144743.GB8102@ab42.lan>
Sender: linux-doc-owner@vger.kernel.org
To: Christian Ruppert <christian.ruppert@abilis.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Pierrick Hascoet <pierrick.hascoet@abilis.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 12, 2013 at 04:47:45PM +0200, Christian Ruppert wrote:
> On Mon, Jun 10, 2013 at 05:29:55PM +0200, Wolfram Sang wrote:
> > On Tue, May 14, 2013 at 03:04:02PM +0200, Christian Ruppert wrote:
> > > This patch makes the SDA hold time configurable through device tr=
ee.
> > >=20
> > > [rebased to i2c-current/i2c-next/mainline-3.10-rc1]
> > >=20
> > > Signed-off-by: Christian Ruppert <christian.ruppert@abilis.com>
> > > Signed-off-by: Pierrick Hascoet <pierrick.hascoet@abilis.com>
> >=20
> > Hmm, I really have problems adding a generic property. I need to be=
tter
> > understand why this is needed? What is the usecase? Can't a safe va=
lue
> > be calculated depending on the bus-speed? Is there a public datashe=
et
> > available somewhere?
>=20
> I checked with our PCB/Applications team and the data sheets for the
> peripherals in question (DVB demodulator front ends) are under NDA.
> Mika, you seem to be interested in this patch as well. Do you know of
> any publicly available data sheets for hardware requiring this
> adjustment?

Sorry for the delay, I was on vacation.

I'm not aware of any publicly available datasheets for this block,
unfortunately.

> In the case of the Designware block, the parameter both changes SDA a=
nd
> START hold times, however, and you'll find lots of data sheets for
> hardware with START hold time requirements on the net, e.g.
> http://ww1.microchip.com/downloads/en/DeviceDoc/21805B.pdf
>=20
> The empirical solution in the function i2c_dw_scl_hcnt does not seem =
to
> work in all cases: Our lab guys confirmed that we have several PCB
> designs which do not work without adjusting the sda-hold-time paramet=
er
> to an appropriate value. The value seems to be different for differen=
t
> PCBs.

Yeah, we see the same problem. Our platform guys have solved this so th=
at
they made the SDA hold time available from ACPI to the device driver.

> I suspect that this kind of configurability is not the same for all i=
2c
> bus master hardware. If you don't want to add a generic property, wou=
ld
> you accept the patch with the property renamed to dwi2c,sda-hold-time=
?
>=20
> Greetings,
>   Christian
>=20
>=20
> --=20
>   Christian Ruppert              ,          <christian.ruppert@abilis=
=2Ecom>
>                                 /|
>   Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9=
-Fleuri
>                              _// | bilis Systems   CH-1228 Plan-les-O=
uates


