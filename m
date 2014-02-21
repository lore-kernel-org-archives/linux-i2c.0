From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: I2C dummy adapter driver ?
Date: Fri, 21 Feb 2014 12:45:21 +0100
Message-ID: <53073C51.5010401@samsung.com>
References: <5305382E.9050902@gmail.com>
 <CAJe_ZhcMMVRTErH3ctbnZyn30_cp9XXjEfUZXdWaVWUHqs4CRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CAJe_ZhcMMVRTErH3ctbnZyn30_cp9XXjEfUZXdWaVWUHqs4CRw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 21/02/14 06:57, Jassi Brar wrote:
> On 20 February 2014 04:33, Sylwester Nawrocki
> <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi All,
>>
>> I was wondering whether it would be reasonable to create a generic
>> Linux dummy I2C bus controller driver. The rationale behind it is
>> there might be hardware configurations where I2C communication is
>> handled by firmware but still it is useful to have I2C slave devices
>> instantiated by a Linux I2C bus adapter driver.
>> It would be useful to have the common devicetree I2C binding scheme
>> working regardless of where the I2C communication is handled - in
>> firmware or by the host CPU.
>>
>> Currently we have a somewhat dummy I2C adapter driver at drivers/media/
>> platform/exynos4-is/fimc-is-i2c.c.
>>
> The driver does seem 'dummy' because it doesn't implement the
> i2c_algorithm.master_xfer()
> Perhaps your remote f/w contains the client driver for the slave chip
> and it abstracts out the controls for you over mailbox? If so, I think
> you can do even without this dummy driver.

Yes, you got it right. I could do without this driver, but it simplifies
code of the whole camera subsystem driver. Since normally image sensors
are I2C clients, for these F/W controller sensors I would have to introduce
additional code, which might have complicated the camera subsystem driver
a bit. And there is a push to write image sensor drivers in V4L2 as
reusable modules, and I2C is one of the standard interfaces already used
there.
The I2C bus driver with empty i2c_algorithm.master_xfer() helps WRT to
using standard DT binding and v4l2_subdev interface.

> OTOH if the remote doesn't know how to drive the slave and it simply
> read/write the registers over i2c just as you ask it over mailbox,
> then we do need a 'virtual pass-through' driver that maps Linux I2C
> API onto remote's api in the i2c_algorithm.master_xfer()  Such a
> virtual driver may indeed be shared across platforms but if it works
> over some common mailbox api. (my platform will share that with yours)

Hmm, that's (unfortunately;)) not my case. If the host was to access the
I2C slave over I2C the I2C bus controller and the I2C slave drivers could
be well implemented as regular drivers on the host CPU side.
However it could be also possible that the firmware exposes fine grained
control interface for an I2C slave, alongside the higher level interface.
Then what you describe above could be useful. Presumably that wouldn't
be very practical though.

--
Regards,
Sylwester
