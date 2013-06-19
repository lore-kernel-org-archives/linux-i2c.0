From: Christian Ruppert <christian.ruppert@abilis.com>
Subject: Re: [PATCH REBASE] i2c-designware: make SDA hold time configurable
Date: Wed, 19 Jun 2013 15:58:56 +0200
Message-ID: <20130619135855.GB16483@ab42.lan>
References: <20130514110745.GA10906@intel.com>
 <1368536642-7158-1-git-send-email-christian.ruppert@abilis.com>
 <20130610152954.GE2987@katana>
 <20130612144743.GB8102@ab42.lan>
 <20130619094540.GA2950@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130619094540.GA2950@katana>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Pierrick Hascoet <pierrick.hascoet@abilis.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 19, 2013 at 11:45:40AM +0200, Wolfram Sang wrote:
> Hi,
>=20
> On Wed, Jun 12, 2013 at 04:47:45PM +0200, Christian Ruppert wrote:
> > On Mon, Jun 10, 2013 at 05:29:55PM +0200, Wolfram Sang wrote:
> > > On Tue, May 14, 2013 at 03:04:02PM +0200, Christian Ruppert wrote=
:
> > > > This patch makes the SDA hold time configurable through device =
tree.
> > > >=20
> > > > [rebased to i2c-current/i2c-next/mainline-3.10-rc1]
> > > >=20
> > > > Signed-off-by: Christian Ruppert <christian.ruppert@abilis.com>
> > > > Signed-off-by: Pierrick Hascoet <pierrick.hascoet@abilis.com>
> > >=20
> > > Hmm, I really have problems adding a generic property. I need to =
better
> > > understand why this is needed? What is the usecase? Can't a safe =
value
> > > be calculated depending on the bus-speed? Is there a public datas=
heet
> > > available somewhere?
> >=20
> > I checked with our PCB/Applications team and the data sheets for th=
e
> > peripherals in question (DVB demodulator front ends) are under NDA.
> > Mika, you seem to be interested in this patch as well. Do you know =
of
> > any publicly available data sheets for hardware requiring this
> > adjustment?
>=20
> So, I looked around and found:
> http://www.maximintegrated.com/app-notes/index.mvp/id/3268
>=20
> which after thinking further about it gives me the following
> conclusions:
>=20
> - sda-hold-time is a property/requirement of a device not following
>   the I2C spec. It is not a property of the master!

Actually, in a protocol like I2C, every device on the bus must respect
timing constraints like hold time etc. These parameters apply at the
same time to the master and to all slaves.

> - It should not be encoded in the devicetree, since the flaw is impli=
cit
>   to the device, so only the driver needs to know about it. I wonder
>   about something like this in the i2c slave driver:
>=20
> 	ret =3D i2c_request_sda_hold_time(client);
>=20
>   The core then can collect the requests and forward them to the host
>   driver. This driver then can set up the hardware or return -EOPNOTS=
UPP
>   and we can even warn the user that there might be problems ahead.

This might be a solution but given that many I2C drivers are written as
an afterthought by device manufacturers and are released under more or
less open terms of licensing into the wild I doubt this would work very
well in practise.

> - I wonder if we really need to have a parameter time-in-ns? The
>   specs cleary say 300ns, so I'd think this is the value we should
>   always use. This is from a theorhetical pov though, maybe your
>   practical experience is different. What values do you need?

In reality, the I2C specification is more subtle than that: The "data
hold time" is specified as 0ns with a footnote [3] stating that devices
"must internally provide a hold time of at least 300ns for the SDA
signal...".

Revision 5 contains a relatively understandable explanation about how t=
o
interpret this but earlier versions are less helpful. I think this
confusion is at the root of many timing issues encountered with I2C (an=
d
the reason why Synopsys made this configurable). In fact, especially
earlier specs are _all but_ clear in this point and we cannot assume
that all peripherals were designed after Revision 5 was released in
October 2012.

> > In the case of the Designware block, the parameter both changes SDA=
 and
> > START hold times, however, and you'll find lots of data sheets for
> > hardware with START hold time requirements on the net, e.g.
> > http://ww1.microchip.com/downloads/en/DeviceDoc/21805B.pdf
>=20
> What I couldn't find is a reference manual for a designware IP that
> supports sda hold time? I found some spear SoC which do not have that
> register, so that should surely be reflected in the patchset, too.

If you have access to DesignWare documentation, check out the
"DesignWare DW_apb_i2c Databook" Version 1.17a from March 2012.
Unluckily, I clearly don't have the right to share this document with
you. Do you know the version of the blocks in the spear SoC which do no=
t
support this register?

> > The empirical solution in the function i2c_dw_scl_hcnt does not see=
m to
> > work in all cases: Our lab guys confirmed that we have several PCB
> > designs which do not work without adjusting the sda-hold-time param=
eter
> > to an appropriate value. The value seems to be different for differ=
ent
> > PCBs.
>=20
> I'd hope that 300ns is a safe value for all PCBs?

Not according to our PCB guys. The highest value I have found in a quic=
k
check of our device trees is 650ns with others being just slightly abov=
e
300ns.

> > I suspect that this kind of configurability is not the same for all=
 i2c
> > bus master hardware.
>=20
> Yeah, maybe some do sda-holding by default? Dunno, never checked for
> that detail.
>=20
> Regards,
>=20
>    Wolfram
>=20



--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
