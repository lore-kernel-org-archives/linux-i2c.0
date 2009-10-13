From: "Olivares, Ricardo Perez" <richo-l0cyMroinI0@public.gmane.org>
Subject: FW: [PATCH] Modify code name SB900 to Hudson-2
Date: Tue, 13 Oct 2009 16:27:26 -0500
Message-ID: <A69FA2915331DC488A831521EAE36FE401554D745E@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

 

-----Original Message-----
From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Crane Cai
Sent: Monday, October 12, 2009 9:22 PM
To: Jean Delvare
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [PATCH] Modify code name SB900 to Hudson-2

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

--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
