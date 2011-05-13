From: Lars Michael <lh_post-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: How to use one I2C device from two modules?
Date: Fri, 13 May 2011 00:47:37 -0700 (PDT)
Message-ID: <135179.26946.qm@web30203.mail.mud.yahoo.com>
References: <20110507152832.25276ac6@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110507152832.25276ac6-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--- On Sat, 7/5/11, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Fri, 6 May 2011 04:30:33 -0700 (PDT), Lars Michael
> wrote:
> > But how do I access the same I2C device from several
> modules? Ideally I want to specify the adapter and slave
> address. If a client is found, I get the i2c_client
> otherwise I have to create it by i2c_new_device (or probe
> it). Is it possible?
> > 
> 
> In general I would have pointed you to drivers/mfd and told
> you to
> write a mfd core driver for your chip. However in your case
> I don't
> think you have a multifunction device. You have a single
> function
> device (GPIO) with multiple users. So I suggest that you
> simply write a
> proper gpio driver for your chip, and get the device
> registered as an
> I2C GPIO device. Then, in your function drivers (power
> supply control
> and button control) get a reference to the gpio device in
> question, and
> use it.

Thanks for the advice. I wrote a simple driver for my chip and
instantiated it in the platform code. In order to access the
device from the function modules, I exported an i2c_client get
function, in order to get a reference to the client:

struct i2c_client *pca950x_get_i2c_client(void)
.....
EXPORT_SYMBOL(pca950x_get_i2c_client);

Not sure this is the perfect way to do it, but it works.

Thanks and regards,
- Lars
