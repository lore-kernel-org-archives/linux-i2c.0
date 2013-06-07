From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: designware: fix race between subsequent xfers
Date: Fri, 7 Jun 2013 10:16:37 +0200
Message-ID: <20130607081636.GC11875@ab42.lan>
References: <1370526216-10060-1-git-send-email-christian.ruppert@abilis.com>
 <20130607052353.GB11878@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130607052353.GB11878-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 07, 2013 at 08:23:53AM +0300, Mika Westerberg wrote:
> Hi Christian,
>=20
> On Thu, Jun 06, 2013 at 03:43:35PM +0200, Christian Ruppert wrote:
> > The designware block is not always properly disabled in the case of
> > transfer errors. Interrupts from aborted transfers might be handled
> > after the data structures for the following transfer are initialise=
d but
> > before the hardware is set up. This might corrupt the data structur=
es to
> > the point that the system is stuck in an infinite interrupt loop (w=
here
> > FIFOs are never emptied).
> > This patch cleanly disables the designware-i2c hardware at the end =
of
> > every transfer, successful or not.
>=20
> Have you tried with the latest mainline driver? There is a commit tha=
t
> solves similar problem:
>=20
> 2a2d95e9d6d29e7	i2c: designware: always clear interrupts before enabl=
ing them
>=20
> Maybe it helps?

Hi Mika,

Thanks for the hint but I have checked both main line and Wolfram's
branch and I saw this patch. I actually hoped it would fix our problem
but it didn't.

Here some more details: We experienced system lockups (complete lock up=
,
no reaction whatsoever) in long-term tests under heavy system load with
lots of scheduling and forking/killing. These lockups could be traced t=
o
the I2C driver which after some time ended up in an incoherent state:
i2c_dw_isr was being called with DW_IC_INTR_RX_FULL but
dev->msg_read_idx =3D=3D dev->msgs_num. This resulted in the FIFO never
being emptied by i2c_dw_read. Since the DW_IC_INTR_RX_FULL interrupt is
cleared by emptying the FIFO, this situation results in an IRQ loop
locking up the system.

We found that the situation systematically occurs just after the
originating process is interrupted (premature return of
wait_for_completion_interruptible_timeout) and further analysis showed
the race condition: Interrupts from the previous transfer are sometimes
triggered after the initialisation of dev in the beginning of
i2c_dw_xfer, thus corrupting the state. If these interrupts occur befor=
e
dev is initialised everything works fine.

An alternative solution would probably be to make sure the hardware is
disabled before initialising the dev structure in i2c_dw_xfer.

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
