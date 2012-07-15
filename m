From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c: sis964: bus driver
Date: Sun, 15 Jul 2012 13:35:30 +0200
Message-ID: <20120715133530.1ffc3f36@endymion.delvare>
References: <1342172455-8530-1-git-send-email-amaury.decreme@gmail.com>
	<CAErSpo5-ou3vjmHgjiOOd57PvWg_hez80U0k3AX_ydjb0pikvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAErSpo5-ou3vjmHgjiOOd57PvWg_hez80U0k3AX_ydjb0pikvQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Amaury =?UTF-8?B?RGVjcsOqbWU=?= <amaury.decreme@gmail.com>, linux-i2c@vger.kernel.org, amalysh@web.de, nelson@sis.com, ben-linux@fluff.org, w.sang@pengutronix.de, rob@landley.net, jeffrey.t.kirsher@intel.com, akpm@linux-foundation.org, davem@davemloft.net, joe@perches.com, ralf@linux-mips.org, dirk.brandewie@gmail.com, jayachandranc@netlogicmicro.com, Xiangzhen.Ye@csr.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, suzanne.decreme@gmail.com
List-Id: linux-i2c@vger.kernel.org

Hi Bjorn,

On Fri, 13 Jul 2012 09:36:07 -0600, Bjorn Helgaas wrote:
> On Fri, Jul 13, 2012 at 3:40 AM, Amaury Decr=C3=AAme
> <amaury.decreme@gmail.com> wrote:
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index ab741b0..0ffc982 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -699,6 +699,7 @@
> >  #define PCI_DEVICE_ID_SI_961           0x0961
> >  #define PCI_DEVICE_ID_SI_962           0x0962
> >  #define PCI_DEVICE_ID_SI_963           0x0963
> > +#define PCI_DEVICE_ID_SI_964           0x0964
>=20
> Please read the comment at the top of this file; I don't think this
> addition qualifies as something that should be added.
>=20
> >  #define PCI_DEVICE_ID_SI_965           0x0965
> >  #define PCI_DEVICE_ID_SI_966           0x0966
> >  #define PCI_DEVICE_ID_SI_968           0x0968

When you reply to a large patch, please limit the quoting to the
relevant portion.

Thanks,
--=20
Jean Delvare
