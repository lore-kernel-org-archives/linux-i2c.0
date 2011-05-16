From: Lars Michael <lh_post-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: How to use one I2C device from two modules?
Date: Mon, 16 May 2011 01:10:22 -0700 (PDT)
Message-ID: <184526.31465.qm@web30201.mail.mud.yahoo.com>
References: <20110513104650.3d1b3ea6@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110513104650.3d1b3ea6-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--- On Fri, 13/5/11, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Fri, 13 May 2011 00:47:37 -0700 (PDT), Lars Michael
> wrote:
> > --- On Sat, 7/5/11, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> wrote:
> > > On Fri, 6 May 2011 04:30:33 -0700 (PDT), Lars
> Michael
> > > wrote:
> > > > But how do I access the same I2C device from
> several
> > > modules? Ideally I want to specify the adapter
> and slave
> > > address. If a client is found, I get the
> i2c_client
> > > otherwise I have to create it by i2c_new_device
> (or probe
> > > it). Is it possible?
> > > > 
> > > 
> > > In general I would have pointed you to
> drivers/mfd and told
> > > you to
> > > write a mfd core driver for your chip. However in
> your case
> > > I don't
> > > think you have a multifunction device. You have a
> single
> > > function
> > > device (GPIO) with multiple users. So I suggest
> that you
> > > simply write a
> > > proper gpio driver for your chip, and get the
> device
> > > registered as an
> > > I2C GPIO device. Then, in your function drivers
> (power
> > > supply control
> > > and button control) get a reference to the gpio
> device in
> > > question, and
> > > use it.
> > 
> > Thanks for the advice. I wrote a simple driver for my
> chip and
> > instantiated it in the platform code. In order to
> access the
> 
> Please submit your driver for integration in the upstream
> kernel.
> Others are certainly using the same device!

Please note that my driver has no device specific functions. It
only allows the device to be registered so that my function
modules can use the smbus commands and the i2c client handle to
use the device. The GPIO device/lib is not supported. So, I don't
think it's worth submitting it at this point...
 
> > device from the function modules, I exported an
> i2c_client get
> > function, in order to get a reference to the client:
> > 
> > struct i2c_client *pca950x_get_i2c_client(void)
> > .....
> > EXPORT_SYMBOL(pca950x_get_i2c_client);
> > 
> > Not sure this is the perfect way to do it, but it
> works.
> 
> No, this doesn't seem right. A given system may have more
> than one
> PCA950x chip. And symbol dependencies are a hell to handle
> as soon as
> things get more complex. Such an export will never be
> accepted upstream.

You are right, and this quick solution was not meant to be submitted.
 
> I can think of 2 ways to handle your problem.
> 
> If neither works for you for whatever reason, maybe we can
> add a helper
> function to i2c-core to retrieve an i2c_client by bus
> number and
> address. Maybe others would find it useful as well.

I was looking for such a function, it could be very handy. And btw
a get adapter by id already exists. 

Thanks and regards,
- Lars 
