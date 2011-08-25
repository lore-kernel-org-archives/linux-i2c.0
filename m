From: James <james-Xcvh2ycssiFmbZtjAW+qKA@public.gmane.org>
Subject: Re: NXP SC16IS752 dual-UART driver?
Date: Thu, 25 Aug 2011 19:46:24 +0000 (UTC)
Message-ID: <loom.20110825T214316-984@post.gmane.org>
References: <AANLkTim6+ccRvJunhofBeYhtniLW83dLA52a-LW2w0Gm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Steve Sakoman <sakoman@...> writes:


> I will soon be working with an ARM based system that incorporates an
> NXP SC16IS752 dual-UART on the i2c bus.

Steve, have you made any progress on a I2C driver for SC16IS7X2? We are
in the same boat as you were and don't have much linux driver experience.
We can talk to the chip over I2C using user land functions but would really
like to have the linux kernel see it as a serial port so we can do pop and
other similar stuff using the chip serial port.

Thanks,
James Armstrong
