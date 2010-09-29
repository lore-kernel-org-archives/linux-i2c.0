From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: Driver for pca9541 bus master selector
Date: Wed, 29 Sep 2010 06:54:01 -0700
Message-ID: <20100929135401.GA11771@ericsson.com>
References: <20100928143302.GA7593@ericsson.com>
 <20100928171607.395f7736@endymion.delvare>
 <20100928160746.GB7976@ericsson.com>
 <20100928184215.00f82717@endymion.delvare>
 <20100928171627.GA8415@ericsson.com>
 <20100929091928.16256bb7@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100929091928.16256bb7-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 29, 2010 at 03:19:28AM -0400, Jean Delvare wrote:
[ ... ]
> 
> I was speaking of the PCA9540. I don't think anyone ever wrote a driver
> for the PCA9541. And in all honestly I don't think the new i2c-mux
> infrastructure is ready for this. It was written with single-master
> topologies in mind. You'll have to rethink a lot of things if you want
> to add support for "inverted" multiplexers. And I don't have the time
> to help, sorry.
> 
Actually, the infrastructure works quite nicely. I use select_chan
to acquire the slave, and release_chan to initiate release.
It behaves like a one-channel multiplexer.

> I don't quite see the point of such chips, BTW. I2C supports
> multi-master already, so two masters talking to the same slave
> sequentially is already supported.
> 
Tell that to our HW team, and to them:

	http://www.lineagepower.com/oem/pdf/CPLI2C.pdf

Guenter
