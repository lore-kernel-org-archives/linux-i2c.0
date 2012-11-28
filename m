From: wfp5p-A/mCt7huS1Rvw44tLj6iNJvpjmsXDcsSh13vi7wywA4@public.gmane.org (Bill Pemberton)
Subject: Re: [PATCH 14/16] i2c-ali1563: remove __dev* attributes
Date: Wed, 28 Nov 2012 08:48:16 -0500
Message-ID: <20121128134816.79BE380134@viridian.itc.virginia.edu>
References: <20121128133153.700e84a8@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121128133153.700e84a8-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare writes:
> 
> Hi Bill,
> 
> On Tue, 27 Nov 2012 15:59:51 -0500, Bill Pemberton wrote:
> > CONFIG_HOTPLUG is going away as an option.  As result the __dev*
> > markings will be going away.
> > 
> > Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
> > and __devexit.
> > 
> > Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
> > Cc: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
> > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-ali1563.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
> > index e02d9f8..5b17c9f 100644
> > --- a/drivers/i2c/busses/i2c-ali1563.c
> > +++ b/drivers/i2c/busses/i2c-ali1563.c
> > @@ -326,7 +326,7 @@ static u32 ali1563_func(struct i2c_adapter * a)
> >  }
> >  
> >  
> > -static int __devinit ali1563_setup(struct pci_dev * dev)
> > +static int ali1563_setup(struct pci_dev * dev)
> 
> While you're here, it would be great if you could fix the checkpatch
> errors on the lines you touch:
> 

The changes are done with a script, so it doesn't know to touch
anything else on the same line.  But it's no problem for me to go back
with checkpatch and manually fix up the this stuff.

I'll fix those and resend this patch.

-- 
Bill
