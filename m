From: Nicholas Mc Guire <der.herr-kA1LtwSENNE@public.gmane.org>
Subject: Re: [PATCH] i2c: axxia: match return type of
	wait_for_completion_timeout
Date: Sun, 8 Feb 2015 16:44:29 +0100
Message-ID: <20150208154429.GA15534@opentech.at>
References: <1423391485-30367-1-git-send-email-hofrat@osadl.org> <20150208143939.GA6033@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150208143939.GA6033@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 08 Feb 2015, Wolfram Sang wrote:

> On Sun, Feb 08, 2015 at 05:31:25AM -0500, Nicholas Mc Guire wrote:
> > return type of wait_for_completion_timeout is unsigned long not int. as ret
> > is only used for wait_for_completion_timeout here the type is simply changed
> > unsigned long.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
> > ---
> > 
> > Patch was only compile tested with axm55xx_defconfig
> > (implies CONFIG_I2C_AXXIA=y)
> > 
> > Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)
> > 
> >  drivers/i2c/busses/i2c-axxia.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
> > index 1decc88..9434824 100644
> > --- a/drivers/i2c/busses/i2c-axxia.c
> > +++ b/drivers/i2c/busses/i2c-axxia.c
> > @@ -408,7 +408,7 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
> >  static int axxia_i2c_stop(struct axxia_i2c_dev *idev)
> >  {
> >  	u32 int_mask = MST_STATUS_ERR | MST_STATUS_SCC;
> > -	int ret;
> > +	unsigned long ret;
> 
> 'ret' being an int is kind of an idiom, so I'd rather see the variable
> renamed, too, like the other patches do.
>
thanks - was not renaming variables - only if a new one was introduced I
gave it a name that was related to the timeout use. Will consider that 
for some of the other cleanups then as well.
 
> Also, please combine the two axxia patches into one.
> 
done and resent.

thx!
hofrat
