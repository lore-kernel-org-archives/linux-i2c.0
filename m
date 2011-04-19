From: Ben Dooks <ben-i2c@fluff.org>
Subject: Re: [PATCH -next reresend] i2c: designware-pcidrv depends on PCI
Date: Tue, 19 Apr 2011 22:45:04 +0100
Message-ID: <20110419214504.GU15795@trinity.fluff.org>
References: <20110408083215.6b3b0bfe.randy.dunlap@oracle.com> <BANLkTikX_rG+6Eg4owary1YRGRG8NzyrGQ@mail.gmail.com> <20110412114722.0f2e67d6@endymion.delvare> <20110413083855.c37ddadc.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110413083855.c37ddadc.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Randy Dunlap <randy.dunlap@oracle.com>, Baruch Siach <baruch@tkos.co.il>, linux-i2c@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 13, 2011 at 08:38:55AM +1000, Stephen Rothwell wrote:
> Hi Jean, Ben,
>=20
> On Tue, 12 Apr 2011 11:47:22 +0200 Jean Delvare <khali@linux-fr.org> =
wrote:
> >
> > On Sat, 9 Apr 2011 13:34:49 +0200, Geert Uytterhoeven wrote:
> > > On Fri, Apr 8, 2011 at 17:32, Randy Dunlap <randy.dunlap@oracle.c=
om> wrote:
> > > > From: Randy Dunlap <randy.dunlap@oracle.com>
> > > >
> > > > i2c-designware-pcidrv is a PCI driver and should depend on PCI.
> > > > Fixes these build errors:
> > > >
> > > > drivers/i2c/busses/i2c-designware-pcidrv.c:256: error: implicit=
 declaration of function 'pci_request_region'
> > > > drivers/i2c/busses/i2c-designware-pcidrv.c:338: error: implicit=
 declaration of function 'pci_release_region'
> > > >
> > > > Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> > > > Cc: Baruch Siach <baruch@tkos.co.il>
> > > > ---
> > > > =A0drivers/i2c/busses/Kconfig | =A0 =A01 +
> > > > =A01 file changed, 1 insertion(+)
> > > >
> > > > Does anybody merge i2c patches???
> > >=20
> > > Yes please, it's been there since Mar 17, reported several times,=
 and probably
> > > masking other build failures.
> >=20
> > This bug only exists in linux-next, as the code in question wasn't
> > merged in Linus's tree yet. It is drawn into linux-next from Ben
> > Dooks's next-i2c branch:
> >   http://git.fluff.org/gitweb?p=3Dbjdooks/linux.git;a=3Dshortlog;h=3D=
refs/heads/next-i2c
> >=20
> > This is where it has to be fixed, so only Ben can do it. Ben, pleas=
e?
> >=20
> > Meanwhile, it should be possible to apply a hot fix to linux-next
> > directly, Stephen does it pretty often. Stephen, could you please a=
pply
> > this fix temporarily until Ben wakes up and applies it to his tree?
>=20
> I will apply this patch as a merge fixup from today (if it is still
> needed).  I also have a patch being applied to that tree to add an
> include of linux/delay.h to drivers/i2c/busses/i2c-designware-core.c =
=2E

I've not gotten around to fixing the rebase of the driver to the
latest source code, I'll try and get around to it in the next few
days unless someone sends a new copy of the patch.
=20
> Ben?
> --=20
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/

--=20
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disapp=
ear.
