From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c/mips: Fix error return codes from Sibyte i2c bus
 driver
Date: Tue, 22 Jun 2010 04:54:17 -0700
Message-ID: <20100622115417.GA14418@ericsson.com>
References: <1277056673-4305-1-git-send-email-guenter.roeck@ericsson.com>
 <20100621190252.2adc6bd8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100621190252.2adc6bd8-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org" <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 21, 2010 at 01:02:52PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sun, 20 Jun 2010 10:57:53 -0700, Guenter Roeck wrote:
> > Sibyte i2c bus driver returns non-descriptive error values.
> > Update to return error values as defined in Documentation/i2c/fault-codes.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-sibyte.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-sibyte.c b/drivers/i2c/busses/i2c-sibyte.c
> > index 3d76a18..329cbee 100644
> > --- a/drivers/i2c/busses/i2c-sibyte.c
> > +++ b/drivers/i2c/busses/i2c-sibyte.c
> > @@ -94,7 +94,7 @@ static int smbus_xfer(struct i2c_adapter *i2c_adap, u16 addr,
> >  		}
> >  		break;
> >  	default:
> > -		return -1;      /* XXXKW better error code? */
> > +		return -EOPNOTSUPP;
> >  	}
> >  
> >  	while (csr_in32(SMB_CSR(adap, R_SMB_STATUS)) & M_SMB_BUSY)
> > @@ -104,7 +104,7 @@ static int smbus_xfer(struct i2c_adapter *i2c_adap, u16 addr,
> >  	if (error & M_SMB_ERROR) {
> >  		/* Clear error bit by writing a 1 */
> >  		csr_out32(M_SMB_ERROR, SMB_CSR(adap, R_SMB_STATUS));
> > -		return -1;      /* XXXKW better error code? */
> > +		return -ENXIO;
> >  	}
> >  
> >  	if (data_bytes == 1)
> 
> Definitely an improvement. However, returning -ENXIO on all errors
> seems wrong. This error value should only be returned on missing ack
> from the slave on address byte. Isn't it possible to distinguish
> between different error kinds? M_SMB_ERROR_TYPE seems promising, but
> one would need to look up the datasheet (which I don't have) to
> discover its meaning.
> 
Makes sense. I'll dig up a copy of the datasheet and see if I can improve it.

Guenter
