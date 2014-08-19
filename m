From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] I2C/ACPI: Fix possible ZERO_SIZE_PTR pointer
 dereferencing error.
Date: Tue, 19 Aug 2014 18:16:49 +0300
Message-ID: <20140819151604.GU1660@lahna.fi.intel.com>
References: <1407810818-33672-1-git-send-email-Li.Xiubo@freescale.com>
 <20140819150355.GD15371@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140819150355.GD15371@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 19, 2014 at 10:03:55AM -0500, Wolfram Sang wrote:
> On Tue, Aug 12, 2014 at 10:33:38AM +0800, Xiubo Li wrote:
> > Since we cannot make sure the 'data_len' will always be none zero here,
> > and then if 'data_len' equals to zero, the kzalloc() will return ZERO_SIZE_PTR,
> > which equals to ((void *)16).
> 
> I assume the read request with length == 0 comes from a broken BIOS?

I'm also interested. Does this trigger in a real system?

> 
> > So this patch fix this with just doing the 'data_len' zero check before calling
> > kzalloc().
> > 
> > Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> Looks good to me, yet adding ACPI experts to CC for further comments.
> 
> > ---
> >  drivers/i2c/i2c-acpi.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/i2c/i2c-acpi.c b/drivers/i2c/i2c-acpi.c
> > index e8b6196..e144c00 100644
> > --- a/drivers/i2c/i2c-acpi.c
> > +++ b/drivers/i2c/i2c-acpi.c
> > @@ -134,6 +134,9 @@ static int acpi_gsb_i2c_read_bytes(struct i2c_client *client,
> >  	int ret;
> >  	u8 *buffer;
> >  
> > +	if (!data_len)
> > +		return -EINVAL;
> > +
> >  	buffer = kzalloc(data_len, GFP_KERNEL);
> >  	if (!buffer)
> >  		return AE_NO_MEMORY;
> > -- 
> > 1.8.5
> > 
