From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Subject: RE: [PATCH 0/2] davinci i2c fixes for 2.6.31
Date: Wed, 15 Jul 2009 12:59:03 +0530
Message-ID: <1247642943.5981.76.camel@localhost.localdomain>
References: <1246920516-31462-1-git-send-email-khilman@deeprootsystems.com>
	 <20090707231938.GA9907@fluff.org.uk> <87skh79uai.fsf@deeprootsystems.com>
	 <A69FA2915331DC488A831521EAE36FE40144D8117B@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A69FA2915331DC488A831521EAE36FE40144D8117B-UmuGNrFEPrGIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Murali,
	
	I will send a patch out to address this problem.

Regards,
Philby


On Wed, 2009-07-08 at 10:25 -0500, Karicheri, Muralidharan wrote:
> Hi Kevin,
> 
> When we do a video loopback with MT9T031, we get i2c timeouts when application is killed using Cntrl C. Is it being addressed in any of the patches?  We had the same issue with TI LSP releases (1.20, 2.00, 2.1o etc).
> The board has to be rebooted to recover from this.
> 
> Murali Karicheri
> Software Design Engineer
> Texas Instruments Inc.
> Germantown, MD 20874
> Phone : 301-515-3736
> email: m-karicheri2-l0cyMroinI0@public.gmane.org
> 
> >-----Original Message-----
> >From: davinci-linux-open-source-bounces+m-
> >karicheri2=ti.com-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org [mailto:davinci-linux-open-source-
> >bounces+m-karicheri2=ti.com-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org] On Behalf Of Kevin Hilman
> >Sent: Wednesday, July 08, 2009 9:30 AM
> >To: Ben Dooks
> >Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; linux-
> >i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >Subject: Re: [PATCH 0/2] davinci i2c fixes for 2.6.31
> >
> >Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> writes:
> >
> >> On Mon, Jul 06, 2009 at 03:48:34PM -0700, Kevin Hilman wrote:
> >>> Here are a couple fixes for the i2c driver on the TI DaVinci family
> >>> of SoCs.  These have been tested for awhile in the DaVinci git
> >>> repo are needed for 2.6.31.
> >>>
> >>> These apply on v2.6.31-rc2.
> >>
> >> ok, do you have a git branch to pull, or should I apply
> >> them from the mailing list>
> >
> >You can take from the list.  My git branch has a bunch of other
> >non-i2c changes in it as well.
> >
> >Thanks,
> >
> >Kevin
> >
> >>> David Brownell (1):
> >>>   i2c-davinci: behave with i2cdetect
> >>>
> >>> Kevin Hilman (1):
> >>>   i2c-davinci: convert clock usage after clkdev conversion
> >>>
> >>>  drivers/i2c/busses/i2c-davinci.c |   20 +++++++++++++++-----
> >>>  1 files changed, 15 insertions(+), 5 deletions(-)
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> >>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >> --
> >> Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)
> >>
> >>   'a smiley only costs 4 bytes'
> >
> >_______________________________________________
> >Davinci-linux-open-source mailing list
> >Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> >http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
