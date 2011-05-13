From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: How to use one I2C device from two modules?
Date: Fri, 13 May 2011 10:46:50 +0200
Message-ID: <20110513104650.3d1b3ea6@endymion.delvare>
References: <20110507152832.25276ac6@endymion.delvare>
	<135179.26946.qm@web30203.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <135179.26946.qm-XzixtO+UlYSvuULXzWHTWIglqE1Y4D90QQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars Michael <lh_post-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Lars,

On Fri, 13 May 2011 00:47:37 -0700 (PDT), Lars Michael wrote:
> --- On Sat, 7/5/11, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > On Fri, 6 May 2011 04:30:33 -0700 (PDT), Lars Michael
> > wrote:
> > > But how do I access the same I2C device from several
> > modules? Ideally I want to specify the adapter and slave
> > address. If a client is found, I get the i2c_client
> > otherwise I have to create it by i2c_new_device (or probe
> > it). Is it possible?
> > > 
> > 
> > In general I would have pointed you to drivers/mfd and told
> > you to
> > write a mfd core driver for your chip. However in your case
> > I don't
> > think you have a multifunction device. You have a single
> > function
> > device (GPIO) with multiple users. So I suggest that you
> > simply write a
> > proper gpio driver for your chip, and get the device
> > registered as an
> > I2C GPIO device. Then, in your function drivers (power
> > supply control
> > and button control) get a reference to the gpio device in
> > question, and
> > use it.
> 
> Thanks for the advice. I wrote a simple driver for my chip and
> instantiated it in the platform code. In order to access the

Please submit your driver for integration in the upstream kernel.
Others are certainly using the same device!

> device from the function modules, I exported an i2c_client get
> function, in order to get a reference to the client:
> 
> struct i2c_client *pca950x_get_i2c_client(void)
> .....
> EXPORT_SYMBOL(pca950x_get_i2c_client);
> 
> Not sure this is the perfect way to do it, but it works.

No, this doesn't seem right. A given system may have more than one
PCA950x chip. And symbol dependencies are a hell to handle as soon as
things get more complex. Such an export will never be accepted upstream.

I can think of 2 ways to handle your problem.

1* Use gpiochip_find(). It is currently only available to drivers if
gpiolib is built into the kernel, but I consider this a bug, patch
submitted [1] but no reply so far.

2a* Install a bus notifier on i2c bus type, and catch event
BUS_NOTIFY_BIND_DRIVER. This only works if you can install the notifier
before the pca950x driver binds to the GPIO chip.

2b* Use i2c_for_each_dev() to get a handle to your i2c client. This
only works if you are certain that the GPIO chip driver is loaded
before the drivers which need it.

Option 1* seems much cleaner to me, as it abstracts the bus type
completely. After all, sub-drivers should only care about the GPIO
functionality and not the technical implementation details.

If neither works for you for whatever reason, maybe we can add a helper
function to i2c-core to retrieve an i2c_client by bus number and
address. Maybe others would find it useful as well.

[1] http://marc.info/?l=linux-kernel&m=130293906304999&w=2

-- 
Jean Delvare
