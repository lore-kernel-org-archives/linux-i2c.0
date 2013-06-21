From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: Fix transfer error code
Date: Thu, 20 Jun 2013 17:16:27 -0700
Message-ID: <20130621001627.GA25889@roeck-us.net>
References: <1371678832-26889-1-git-send-email-linux@roeck-us.net>
 <20130620192337.GB2961@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130620192337.GB2961@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 20, 2013 at 09:23:37PM +0200, Wolfram Sang wrote:
> On Wed, Jun 19, 2013 at 02:53:52PM -0700, Guenter Roeck wrote:
> > The driver returns -ENODEV as error code if it did not get an ACK
> > from the device. Per Documentation/i2c/fault-codes, it should
> > return -ENXIO.
> > 
> > Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> 
> Thanks, have you checked the other error codes as well while you were
> there?
> 
Other error codes are ok as far as I can see.

Guenter

> > ---
> >  drivers/i2c/busses/i2c-mv64xxx.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> > index 1a3abd6..6972032 100644
> > --- a/drivers/i2c/busses/i2c-mv64xxx.c
> > +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> > @@ -227,7 +227,7 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
> >  		/* Doesn't seem to be a device at other end */
> >  		drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
> >  		drv_data->state = MV64XXX_I2C_STATE_IDLE;
> > -		drv_data->rc = -ENODEV;
> > +		drv_data->rc = -ENXIO;
> >  		break;
> >  
> >  	default:
> > -- 
> > 1.7.9.7
> > 
