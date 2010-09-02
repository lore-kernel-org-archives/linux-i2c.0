From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: i2c Mux support for LTC4306 multiplexers
Date: Thu, 2 Sep 2010 10:07:08 +0200
Message-ID: <20100902080708.GC28869@enneenne.com>
References: <4C7ECF6D.30602@cyanoptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4C7ECF6D.30602-h+EFgaI/KG7uufBYgWm87A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Ghalam <joe.ghalam-h+EFgaI/KG7uufBYgWm87A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 01, 2010 at 03:10:53PM -0700, Joe Ghalam wrote:
>    Hi,
>    I have been trying to include you i2c changes to bring in support for the
>    i2c muxes in my system. I'm using Linux 2.6.33.2 with an MPC8547E. There
>    are two IC2 buses hanging off the host processor. The 2nd I2C bus has 3
>    LT4306 multiplexers (4 ch per device).
> 
>    My current setup (without the i2c-mux) uses the buses/i2c-mpc.c to create
>    two adapters mapped to /dev/i2c-0 and /dev/i2c-1 (these devices are
>    services by an i2c proxy). I would like to move away from this setup by
>    using i2c-mux + mux specific drivers.
> 
>    I have ported your changes in my version of Linux as best as I could, and
>    I also used pca542x related files as templates to create support for
>    ltc4306. During the system boot up, as usual, I see two "MPC adapter"
>    adapters, 0 and 1, getting registered, and I also see my LTC4306 device
>    registered. But I haven't been able to change the i2c-mpc to probe the
>    already discovered buses for any muxes.

Maybe you should provide some code and/or debugging messages... I'm
sorry but I don't understand your problem.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
