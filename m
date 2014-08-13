From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] I2C: Make I2C core able to be module when I2C_ACPI is
 selected.
Date: Wed, 13 Aug 2014 10:07:59 +0300
Message-ID: <20140813070759.GB1657@lahna.fi.intel.com>
References: <1407740455-21269-1-git-send-email-tianyu.lan@intel.com>
 <20140812095321.GU1657@lahna.fi.intel.com>
 <20140813020250.GA2853@katana>
 <53EAD278.2010003@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53EAD278.2010003-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 13, 2014 at 10:50:32AM +0800, Lan Tianyu wrote:
> On 2014=E5=B9=B408=E6=9C=8813=E6=97=A5 10:03, Wolfram Sang wrote:
> > On Tue, Aug 12, 2014 at 12:53:21PM +0300, Mika Westerberg wrote:
> >> On Mon, Aug 11, 2014 at 03:00:55PM +0800, Lan Tianyu wrote:
> >>> Commit da3c6647(I2C/ACPI: Clean up I2C ACPI code and Add CONFIG_I=
2C_ACPI
> >>> config) adds a new kernel config I2C_ACPI and make I2C core built=
 in
> >>> when the config is selected. This is wrong because distributions
> >>> etc generally compile I2C as a module and the commit broken that.
> >>> This patch is to make I2C core able to be a module when I2C_ACPI =
is
> >>> selected. Original issue the commit da3c6647 tried to avoid will
> >>> be fixed in ACPICA and it's rarely triggered during unloading mod=
ule.=20
> >>>
> >>> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >>
> >> I wonder if we can do
> >>
> >> 	depends on I2C=3Dy
> >>
> >> here? If I understand it right, then we only build the ACPI_I2C if=
 I2C
> >> is compiled into the kernel. That way the problem da3c6647 tried t=
o
> >> solve doens't re-appear.
> >>
> >> We can later on relax this once ACPICA has been fixed. Thoughts?
> >=20
> > I had the same idea yet my travel to Chicago interrupted thinking a=
bout
> > it further. Once I get rid of my jetlag, I'll have a closer look. U=
nless
> > you already came up with the perfect solution until then, of course=
 ;)
> >
>=20
> Hi Mika & Wolfram:
> 	I have one concern about "depends on I2C=3Dy". If distribution confi=
g
> file selects I2C core as a module, the original code can enumerate I2=
C
> slave devices from ACPI table. But now I2C_ACPI depends on I2C core
> built in, the I2C module can't enumerate devices from ACPI table. Thi=
s
> maybe a regression for distribution?

True, but only the I2C OpRegion parts needs to have I2C=3Dy. Does it ma=
ke
sense to name ACPI_I2C to ACPI_I2C_OPREGION (or something like that)
and only enable it when I2C=3Dy? Then we would have ACPI I2C enumeratio=
n
still in place.
