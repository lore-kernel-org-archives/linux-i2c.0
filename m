From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-dev: Create 'name' attribute automatically
Date: Wed, 25 Sep 2013 14:11:05 -0700
Message-ID: <20130925211104.GA2784@roeck-us.net>
References: <1377966619-20197-1-git-send-email-linux@roeck-us.net>
 <20130925202035.GB4290@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130925202035.GB4290@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 25, 2013 at 10:20:35PM +0200, Wolfram Sang wrote:
> On Sat, Aug 31, 2013 at 09:30:19AM -0700, Guenter Roeck wrote:
> > The 'name' attribute is needed for all i2c-dev class devices, meaning
> > it can be created automatically by pointing to it in the class data
> > structure. This simplifies the code and reduces the probability for race
> > conditions.
> 
> What race condition?
> 

Userspace trying to access the name attribute before it is created.
See http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
for details; Greg describes the problem and solution much better than I could
ever do.

> > 
> > Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> > ---
> >  drivers/i2c/i2c-dev.c |   32 ++++++++++++++++----------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> > index c3ccdea..46eea02 100644
> > --- a/drivers/i2c/i2c-dev.c
> > +++ b/drivers/i2c/i2c-dev.c
> > @@ -111,7 +111,11 @@ static ssize_t show_adapter_name(struct device *dev,
> >  		return -ENODEV;
> >  	return sprintf(buf, "%s\n", i2c_dev->adap->name);
> >  }
> > -static DEVICE_ATTR(name, S_IRUGO, show_adapter_name, NULL);
> > +
> > +static struct device_attribute i2c_dev_attributes[] = {
> > +	__ATTR(name, S_IRUGO, show_adapter_name, NULL),
> > +	{ }
> > +};
> >  
> >  /* ------------------------------------------------------------------------- */
> >  
> > @@ -538,7 +542,11 @@ static const struct file_operations i2cdev_fops = {
> >  
> >  /* ------------------------------------------------------------------------- */
> >  
> > -static struct class *i2c_dev_class;
> > +static struct class i2c_dev_class = {
> > +	.owner = THIS_MODULE,
> > +	.name = "i2c-dev",
> > +	.dev_attrs = i2c_dev_attributes,
> > +};
> 
> Have you tried this with two instances? I don't think it will work since
> class_register modifies the class struct.
> 
Half a dozen instances, actually. Unless I am missing something, seems to be
unlikely that there is a problem, since the kernel would fail all over the place
if there was a problem with class->dev_attrs (or its replacement dev_groups);

Anyway, the patch is obsolete; one is supposed to use class->dev_groups now.

Thanks,
Guenter
