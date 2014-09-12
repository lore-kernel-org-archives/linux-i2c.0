From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC 0/4] i2c: slave support framework for Linux devices
Date: Fri, 12 Sep 2014 10:58:36 +0200
Message-ID: <20140912085836.GS3755@pengutronix.de>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410274470-12712-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On Tue, Sep 09, 2014 at 04:54:26PM +0200, Wolfram Sang wrote:
> Finally, here is my take on the often desired feature that Linux can =
not only
> be an I2C master, but also an I2C slave. Compared to my draft sent ou=
t last
> week, this RFC has been tested on hardware (Renesas Lager board) and =
works \o/
>=20
> One big part still missing is documentation, so brave ones need to "u=
se the
> source". However, this approach turned out to be even less intrusive =
than
> expected, so that is hopefully a good sign.
Some thoughts from reading through your patch set:

- If I understand correctly you cannot register an i2c slave without
  also registering a master, right? I don't think this is troubling in
  practice, is it?
  For abstraction I would prefer to make these different concepts
  though.

- The IMHO most (even only?) useful slave is "i2cslvdev", i.e. a
  userspace device. With that you wouldn't need device tree stuff, the
  driver would just offer the device if supported. Userspace then could
  care about the rest (slave address, functionality, ...).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
