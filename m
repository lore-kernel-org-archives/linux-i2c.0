From: Darius Augulis <augulis.darius@gmail.com>
Subject: Re: [PATCH 1/5] I2C driver for MXC
Date: Mon, 30 Mar 2009 10:48:57 +0300
Message-ID: <d7f267fd0903300048p7caee6e0ne63916b986b132b@mail.gmail.com>
References: <49C89E13.7040801@gmail.com> <20090324094215.GA3471@pengutronix.de>
	<49C8ABE5.40408@gmail.com> <20090325092625.GA3029@pengutronix.de>
	<49CA017D.20005@gmail.com> <20090325104357.GB3029@pengutronix.de>
	<Pine.LNX.4.64.0903282207480.9903@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.64.0903282207480.9903@axis700.grange>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-arm-kernel@lists.arm.linux.org.uk, linux-i2c@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

I tested your driver on i.MXL with OV7670 and MT9V111 cameras. I confirm it
works.
In otherside, my driver is also tested with OV7670, MT9V111, OV7720 cameras,
PCF8575 expander and NT7651 LCD controller. All these devices work connected
to i.MXL.
If you have problems on MX3 only with single device, it may be caused by
some specific conditions.
I don't know it is good idea to replace one driver by another, because we
don't know where is the problem exactly.
Of course would be fine to watch your I2C bus with oscilloscope. So you
could see what is wrong.
IMO we should find what is wrong in my driver, to have good working driver
for all MXC SoC's.
If we replace it by your driver, we miss lot of ML comments fixed and
probably we will receive errors and problems in some different situation.

Darius A.


On Sun, Mar 29, 2009 at 12:36 AM, Guennadi Liakhovetski <
g.liakhovetski@pengutronix.de> wrote:

> On Wed, 25 Mar 2009, Wolfram Sang wrote:
>
> > > Because I hurry to submit this, because merge window is open.
>
> Ok, I waited for this driver, I really did, and I really prefer having one
> driver for as many hardware (SoC) variants as possible instead of having
> different drivers, and I really hoped its new version will work
> out-of-the-box in my setup (pcm037 with a mt9t031 camera). Unfortunately,
> it didn't. I've spent more than a full working day trying to get it to
> work, but I didn't succeed so far. It works with the on-board rtc, but it
> doesn't work with the camera, connected over a flex cable.
>
> Attached to this email is a version of the i2c driver for i.mx31 that I've
> been using with my setup for about half a year now. I adjusted it slightly
> to accept the same platform data, so, it is really a drop-in replacement
> for i2c-imx.c. Of course, you have to adjust or extend the Makefile. I
> actually added a new Kconfig entry for this driver, so I could easily
> compare them during the tests.
>
> The source of "my" version does look more logical and more clean to me on
> quite a few occasions. So, maybe someone could give it a quick spin on
> other *mx* SoCs and see if we can use this one instead? You might have to
> replace {read,write}w with readb and writeb, so, it might be a good idea
> to abstract them into inlines or macros. Otherwise, I think, it might work
> for other CPUs straight away.
>
> I just would like to avoid committing a driver and having to spend hours
> or days fixing it afterwards when a possibly more mature version exists.
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
