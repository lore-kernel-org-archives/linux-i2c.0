From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/6]  Make return type of i2c_del_adapter() (and
 i2c_del_mux_adapter())  void
Date: Sun, 31 Mar 2013 09:56:23 +0200
Message-ID: <20130331095623.146f65db@endymion.delvare>
References: <1362853009-20789-1-git-send-email-lars@metafoo.de>
	<20130330211352.07530db7@endymion.delvare>
	<51574E71.7010403@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51574E71.7010403-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 30 Mar 2013 21:43:29 +0100, Lars-Peter Clausen wrote:
> On 03/30/2013 09:13 PM, Jean Delvare wrote:
> > I see:
> > 
> > struct device_driver {
> > 	(...)
> > 	int (*probe) (struct device *dev);
> > 	int (*remove) (struct device *dev);
> >
> > So the driver core does allow remove functions to return an error.
> 
> Well, the return type is int, but the return value is never checked. So you
> can return an error value, but the device driver core is going to care and
> the device is still removed. So any code which does return an error in it's
> probe function in the assumption that this means the device will still be
> present is broken and leaves the system in an undefined state. So if that
> happens the kernel will probably crash sooner or later, or if you are lucky
> you only created a few resources leaks.
> 
> And no we can't change the core to handle errors from a drivers remove
> callback. It's a basic inherent property of the Linux device driver model
> that any device can be removed at any time.
> 
> > Are you going to fix all subsystems as you are doing for i2c now, and then
> > change device_driver.remove to return void? If not, I don't see the
> > point of changing it in i2c.
> 
> As I said it's a bug if a driver returns an error in its remove function.
> And the fact that the return type of the remove callback is int is pretty
> much misleading in this regard, so the long term goal is to make the return
> type void. But that's a long way to go until we get there, fixing the return
> type of i2c_del_adapter() is kind of the low hanging fruit.

OK, makes sense, thanks for the clarification.

-- 
Jean Delvare
