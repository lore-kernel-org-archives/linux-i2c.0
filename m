From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c Mux support for LTC4306 multiplexers
Date: Thu, 2 Sep 2010 14:02:23 +0200
Message-ID: <20100902140223.14fac60a@hyperion.delvare>
References: <4C7ECF6D.30602@cyanoptics.com>
	<20100902080708.GC28869@enneenne.com>
	<4C7F80FF.5050005@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C7F80FF.5050005-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Joe Ghalam <joe.ghalam-h+EFgaI/KG7uufBYgWm87A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 02 Sep 2010 12:48:31 +0200, Michael Lawnick wrote:
> Rodolfo Giometti said the following:
> > On Wed, Sep 01, 2010 at 03:10:53PM -0700, Joe Ghalam wrote:
> >> Hi, I have been trying to include you i2c changes to bring in 
> >> support for the i2c muxes in my system. I'm using Linux 2.6.33.2
> >> with an MPC8547E.There are two IC2 buses hanging off the host
> >> processor. The 2nd I2C bus has 3 LT4306 multiplexers (4 ch per
> >> device).
> >> 
> >> My current setup (without the i2c-mux) uses the buses/i2c-mpc.c to
> >> create two adapters mapped to /dev/i2c-0 and /dev/i2c-1 (these
> >> devices are services by an i2c proxy). I would like to move away
> >> from this setup by using i2c-mux + mux specific drivers.
> >> 
> >> I have ported your changes in my version of Linux as best as I
> >> could, and I also used pca542x related files as templates to create
> >> support for ltc4306. During the system boot up, as usual, I see two
> >> "MPC adapter" adapters, 0 and 1, getting registered, and I also see
> >> my LTC4306 device registered. But I haven't been able to change the
> >> i2c-mpc to probe the already discovered buses for any muxes.
> 
> There should be no need to change the (original) adapter code.
> You either need to enable automatic detection of your LT4306 via
> normal_i2c + proper class declaration in your lt4306 module or register

Note that there is no detection class for mux chips yet, because the
only I2C-based mux chip family we support today can't be detected. It
could be added if needed, but my feeling is that multiplexer chips
aren't too common and often need platform data for proper operation
anyway, so they'd rather be declared than detected.

> it at startup via i2c_register_board_info() (e.g. in setup.c and/or
> using device tree).
> For testing you can add it dynamically from shell with something like:
> echo "lt4306 0x70" > /sys/bus/i2c/devices/i2c-1/new-device"

-- 
Jean Delvare
