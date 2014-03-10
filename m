From: "Chew, Chiau Ee" <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 2/2] i2c: designware-pci: set ideal HCNT, LCNT and SDA
 hold time value
Date: Mon, 10 Mar 2014 11:34:49 +0000
Message-ID: <604BF5F4C5D71041942BC7E84ED659EA0155D5C4@PGSMSX103.gar.corp.intel.com>
References: <1394201571-11681-1-git-send-email-chiau.ee.chew@intel.com>
 <1394201571-11681-3-git-send-email-chiau.ee.chew@intel.com>
 <20140309090339.GB4695@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140309090339.GB4695@katana>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: Wolfram Sang [mailto:wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org]
> Sent: Sunday, March 09, 2014 5:04 PM
> To: Chew, Chiau Ee
> Cc: Mika Westerberg; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH 2/2] i2c: designware-pci: set ideal HCNT, LCNT and SDA
> hold time value
> 
> On Fri, Mar 07, 2014 at 10:12:51PM +0800, Chew Chiau Ee wrote:
> > From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >
> > On Intel BayTrail, there was case whereby the resulting fast mode bus
> > speed becomes slower (~20% slower compared to expected speed) if using
> > the HCNT/LCNT calculated in the core layer. Thus, this patch is added
> > to allow pci glue layer to pass in optimal HCNT/LCNT/SDA hold time
> > values to core layer since the core layer supports cofigurable
> > HCNT/LCNT/SDA hold time values now.
> >
> > Signed-off-by: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Can you make use of those instead?
> 
>         u32                     sda_falling_time;
>         u32                     scl_falling_time;
> 
> This is more consistent with using sda_hold_time and lets them have a common
> (and more readable) unit.

Would like to clarify on your statement above. So you are suggesting to change the following 
variable name in the code? As in:
"u32 ss_hcnt;"   to  "u32 ss_scl_rising_time"
"u32 fs_hcnt;"   to  "u32 fs_scl_rising_time"
"u32 ss_lcnt;"    to   "u32 ss_scl_falling_time"
"u32 fs_lcnt;"     to " u32 fs_scl_falling_time"
"u32 sda_hold;"  to  "u32 sda_hold_time"
