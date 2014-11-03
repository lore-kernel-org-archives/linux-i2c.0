From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: create proper topology in sysfs
Date: Mon, 3 Nov 2014 14:18:50 -0800
Message-ID: <20141103221850.GA16026@roeck-us.net>
References: <1414960809-16860-1-git-send-email-wsa@the-dreams.de>
 <20141103205534.GA18937@roeck-us.net>
 <20141103210200.GA6242@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141103210200.GA6242@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 03, 2014 at 10:02:00PM +0100, Wolfram Sang wrote:
> > > +	WARN(sysfs_create_link(&parent->dev.kobj, &priv->adap.dev.kobj, priv->adap.dev.kobj.name),
> > > +				"can't create compatibility link for old mux name scheme\n");
> > > +
> > Something seems to be wrong with the linking.
> > 
> > I get lots of messages such as
> > 
> > sysfs: cannot create duplicate filename
> > '/devices/fff70a000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:09.0/0000:10:00.0/i2c-sam.16/i2c-88/i2c-89'
> > 
> > followed by "can't create compatibility link for old mux name scheme".
> 
> What is your muxing setup?
> 
Complicated ;-).

There are really various muxes. The one above is a multi-function FPGA connected
to a PCIe bus. The FPGA core has up to 8 i2c controllers. Each of those controllers
supports up to 8 mux channels, for a total of up to 64 virtual i2c adapters.

There are also gpio based muxes in the same system, only they are not
'simple' gpio muxes where 1 pin matches 1 channel, but complex ones where
the channel is determined by a three-bit value followed by an 8-bit mask
(so there can be up to 64 mux channels on a single adapter).

Plus of course there are some pca9548 and pca9546 based multiplexers.

This is all mixed with gpio based bus master selectors permitting access from
different boards. The overall architecture is so complex that it is actually
possible to configure the i2c bus in circles (bus master selector to mux to
another mux back to the other channel of the bus master selector).

Just don't ask me who came up with that architecture ;-)

I'll add some debugging to try to find out why the symlinks don't work.

Guenter
