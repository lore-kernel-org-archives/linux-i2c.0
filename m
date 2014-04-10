From: "Du, Wenkai" <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] i2c-designware: Mask interrupts during i2c controller
 enable
Date: Thu, 10 Apr 2014 23:06:01 +0000
Message-ID: <7286EAF50D3F4E4AADE7FEECEBF8B5A547FFA3F1@ORSMSX110.amr.corp.intel.com>
References: <20140404184232.GC19349@intel.com>
 <7286EAF50D3F4E4AADE7FEECEBF8B5A537A71351@ORSMSX109.amr.corp.intel.com>
 <20140405061316.GF19349@intel.com>
 <20140406185818.3aaca03d@alan.etchedpixels.co.uk>
 <20140407090403.GG19349@intel.com>
 <20140407154252.6b8f0f7e@alan.etchedpixels.co.uk>
 <20140407151107.GL19349@intel.com>
 <7286EAF50D3F4E4AADE7FEECEBF8B5A537A72207@ORSMSX109.amr.corp.intel.com>
 <20140408103006.GQ19349@intel.com>
 <7286EAF50D3F4E4AADE7FEECEBF8B5A537A73919@ORSMSX109.amr.corp.intel.com>
 <20140410090826.GW19349@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140410090826.GW19349-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Westerberg, Mika" <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> -----Original Message-----
> From: Westerberg, Mika
> Sent: Thursday, April 10, 2014 2:08 AM
> To: Du, Wenkai
> Cc: One Thousand Gnomes; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wolfram Sang; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH] i2c-designware: Mask interrupts during i2c controller enable

> Can you resend this patch with a changelog that explains the resume issue?
Updated patch descriptions in new thread: 
[PATCH V2] i2c-designware: Mask all interrupts during i2c controller enable
