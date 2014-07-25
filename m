From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: pca954x: put the mux to disconnected state after
 resume
Date: Fri, 25 Jul 2014 20:00:39 +0800
Message-ID: <20140725200039.75f38052@xhacker>
References: <1406254559-5615-1-git-send-email-jszhang@marvell.com>
	<20140725091519.4e780494@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140725091519.4e780494-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org" <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Fri, 25 Jul 2014 00:15:19 -0700
Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> wrote:

> Hi Jisheng Zhang,
> 
> On Fri, 25 Jul 2014 10:15:59 +0800, Jisheng Zhang wrote:
> > pca954x may be power lost during suspend, so after resume we also suffer
> > the issue fixed by commit cd823db8b1161ef0d756514d280715a576d65cc3,
> > 
> >  "pca954x power-on default is channel 0 connected. If multiple pca954x
> >  muxes are connected to the same physical I2C bus, the parent bus will
> >  see channel 0 devices behind both muxes by default."
> > 
> > What's more, when resume bootloader may also operate the mux, so the
> > the channel connected after that may not be the one driver thought.
> > 
> > We fix this problem by putting the mux to disconnected state and
> > clearing last_chan in the resume hook.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/i2c/muxes/i2c-mux-pca954x.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c
> > b/drivers/i2c/muxes/i2c-mux-pca954x.c index 9bd4212..c8c3d58 100644
> > --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> > +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> > @@ -273,9 +273,23 @@ static int pca954x_remove(struct i2c_client *client)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_PM_SLEEP
> > +static int pca954x_resume(struct device *dev)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct pca954x *data = i2c_get_clientdata(client);
> > +
> > +	data->last_chan = 0;
> > +	return i2c_smbus_write_byte(client, 0);
> > +}
> > +#endif
> > +
> > +static SIMPLE_DEV_PM_OPS(pca954x_pm, NULL, pca954x_resume);
> 
> I think you must include <linux/pm.h> for this.
> 
> Other than this, the change looks reasonable, you can add:
> 
> Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> 
> (Please note my new e-mail address.)


Thanks for reviewing. I have cooked patch v2.

Thanks very much,
Jisheng
