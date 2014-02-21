From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: I2C dummy adapter driver ?
Date: Fri, 21 Feb 2014 11:27:43 +0530
Message-ID: <CAJe_ZhcMMVRTErH3ctbnZyn30_cp9XXjEfUZXdWaVWUHqs4CRw@mail.gmail.com>
References: <5305382E.9050902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5305382E.9050902-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 20 February 2014 04:33, Sylwester Nawrocki
<sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi All,
>
> I was wondering whether it would be reasonable to create a generic
> Linux dummy I2C bus controller driver. The rationale behind it is
> there might be hardware configurations where I2C communication is
> handled by firmware but still it is useful to have I2C slave devices
> instantiated by a Linux I2C bus adapter driver.
> It would be useful to have the common devicetree I2C binding scheme
> working regardless of where the I2C communication is handled - in
> firmware or by the host CPU.
>
> Currently we have a somewhat dummy I2C adapter driver at drivers/media/
> platform/exynos4-is/fimc-is-i2c.c.
>
The driver does seem 'dummy' because it doesn't implement the
i2c_algorithm.master_xfer()
Perhaps your remote f/w contains the client driver for the slave chip
and it abstracts out the controls for you over mailbox? If so, I think
you can do even without this dummy driver.

OTOH if the remote doesn't know how to drive the slave and it simply
read/write the registers over i2c just as you ask it over mailbox,
then we do need a 'virtual pass-through' driver that maps Linux I2C
API onto remote's api in the i2c_algorithm.master_xfer()  Such a
virtual driver may indeed be shared across platforms but if it works
over some common mailbox api. (my platform will share that with yours)

Cheers,
Jassi
