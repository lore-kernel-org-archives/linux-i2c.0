From: wfp5p-A/mCt7huS1Rvw44tLj6iNJvpjmsXDcsSh13vi7wywA4@public.gmane.org (Bill Pemberton)
Subject: Re: [PATCH 00/16] i2c: remove __dev* attributes for retirement of
Date: Wed, 28 Nov 2012 08:51:46 -0500
Message-ID: <20121128135146.74D0580134@viridian.itc.virginia.edu>
References: <20121128104716.GC14238@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121128104716.GC14238-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang writes:
> 
> 
> --iFRdW5/EC4oqxDHL
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Tue, Nov 27, 2012 at 03:59:37PM -0500, Bill Pemberton wrote:
> > This is a respin of the patches to remove the __dev* attributes in the
> > i2c subsystem.
> >=20
> > The attributes __devinit, __devexit_p, __devinitdata, __devinitconst,
> > and __devexit are no longer needed since CONFIG_HOTPLUG is being
> > removed as an option.
> 
> Thanks. Will wait one more day for acks, then probably squash them into
> one and make this the last commit for 3.8. Is that okay with you?
> 

There are two where a little manual checkpatch cleanup were requested.
I'll clean those up and resend those two (unless you want the whole
series resent).

-- 
Bill
