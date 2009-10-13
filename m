From: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] Modify code name SB900 to Hudson-2
Date: Tue, 13 Oct 2009 10:22:26 +0800
Message-ID: <20091013022226.GB28434@crane-desktop>
References: <20091012020518.GA19626@crane-desktop> <20091012125151.2d0ef7bc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091012125151.2d0ef7bc-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Mon, Oct 12, 2009 at 12:51:51PM +0200, Jean Delvare wrote:
> Hi Crane,
> 
> On Mon, 12 Oct 2009 10:05:18 +0800, Crane Cai wrote:
> > Hi Jean,
> > We have changed the name of SB900 chip, and the source needs change also.
> > Please apply.
> > Thanks,
> > - Crane
> > 
> > ---
> > Change SB900 to its formal code name Hudson-2.
> > 
> > Signed-off-by: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  Documentation/i2c/busses/i2c-piix4 |    2 +-
> >  drivers/i2c/busses/Kconfig         |    2 +-
> >  drivers/i2c/busses/i2c-piix4.c     |    4 ++--
> >  include/linux/pci_ids.h            |    2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> Applied, thanks. Will go in kernel 2.6.32.
> 
> I have also added support to sensors-detect.
Thanks.

-- 
Best Regards,
- Crane
