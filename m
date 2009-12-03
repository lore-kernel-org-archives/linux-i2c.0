From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Subject: RE: [PATCH 0/2] davinci i2c fixes for 2.6.31
Date: Thu, 03 Dec 2009 21:42:23 +0530
Message-ID: <1259856743.24844.13.camel@localhost.localdomain>
References: <1246920516-31462-1-git-send-email-khilman@deeprootsystems.com>
	 <20090707231938.GA9907@fluff.org.uk> <87skh79uai.fsf@deeprootsystems.com>
	 <A69FA2915331DC488A831521EAE36FE40144D8117B@dlee06.ent.ti.com>
	 <1247642943.5981.76.camel@localhost.localdomain>
	 <A69FA2915331DC488A831521EAE36FE40144F1E816@dlee06.ent.ti.com>
	 <1258989866.20007.237.camel@localhost.localdomain>
	 <A69FA2915331DC488A831521EAE36FE40155B773AC@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A69FA2915331DC488A831521EAE36FE40155B773AC-UmuGNrFEPrGIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Murali,

	The patch works for DM6446 and DM355 only. To get it to work for DM365
one must update the gpio pin number variables (sda_pin and scl_pin) in
struct davinci_i2c_platform_data for each platform.

I do not have the pin number information for other Davinci platforms.
This was mentioned in the comment section of the patch v2...

"TODO: Need to add SDA and SCL pin numbers to the respective
platforms such as dm355-leopard, dm365, dm646x, da8xx etc.
What I have info on is limited to just dm355 and dm6446."

If someone can provide me with the relevant information, I could update
for all.

I used "./i2cset -y 0 0x50 0x00" cause its the only way to kill the i2c
bus on a 2.6.18 kernel with DVSDK 2.0. FYI, I do not know how to
generate cmem.ko for the Arago tree kernel that would get
"fbdev_loopback" running.

Regards,
Philby


On Thu, 2009-12-03 at 09:45 -0600, Karicheri, Muralidharan wrote:
> Philby,
> 
> Is this a generic solution which works on DM365 as well?
> 
> Why did you do the following command?
> 
> #./i2cset -y 0 0x50 0x00
> 
> Using the Arago tree kernel I was able to reproduce the issue
> by doing
> 
> ./fbdev_loopback -i2 -d0
> 
> and then press Control C. I am not sure why you run the command
> ./i2cset -y 0 0x50 0x00
> 
> 
> Murali Karicheri
> Software Design Engineer
> Texas Instruments Inc.
> Germantown, MD 20874
> phone: 301-407-9583
> email: m-karicheri2-l0cyMroinI0@public.gmane.org
> 
> >-----Original Message-----
> >From: Philby John [mailto:pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org]
> >Sent: Monday, November 23, 2009 10:24 AM
> >To: Karicheri, Muralidharan
> >Cc: Kevin Hilman; Ben Dooks; davinci-linux-open-
> >source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >Subject: RE: [PATCH 0/2] davinci i2c fixes for 2.6.31
> >
> >Hello Murali,
> >
> >On Thu, 2009-07-16 at 16:22 -0500, Karicheri, Muralidharan wrote:
> >> Philby,
> >>
> >> I tried running this patch against 2.6.31.rc2 (davinci kernel tree). But
> >I got a crash as I run the application which is given below....
> >>
> >> In my case, time out happens when I kill the capture application using
> >Cntrl-C. After Cnrtl-C, the mt9t031 i2c device couldn't be contacted by the
> >host (during cleanup, i2c commands fails). When the application is run
> >again, I get following outputs..
> >>
> >> i2c_davinci i2c_davinci.1: timeout waiting for bus ready
> >> i2c_davinci i2c_davinci.1: timeout waiting for bus ready
> >>
> >> Here are the complete log....
> >>
> >> application running and pressed Cntrl-C ====>
> >>
> >> time:105    frame:33
> >> time:105    frame:34vpfe-capture vpfe-capture: stream off failed in
> >subdev
> >>
> >> Running it again .....
> >>
> >> root-fKfTphxkbEe3Z1R/gWBstg@public.gmane.org:/opt/git# ./fbdev_loopback -i2 -d0
> >
> >
> >I have now verified the code on a DM6446 and DM355, with
> >the ./fbdev_loopback test. I had to first do a #./i2cset -y 0 0x50 0x00
> >0x0000 w to kill the bus and then run the ./fbdev_loopback test to
> >recreate the issue. Recovery seems to happen with the new patch. Could
> >you try this out at your end, with the new patch?
> >
> >Thanks and regards,
> >Philby
> >
> 
