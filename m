From: "Oskar Schirmer" <os-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch] add pca9543 driver
Date: Thu, 26 Mar 2009 17:23:15 +0100
Message-ID: <20090326162315.GA26255@emlix.com>
References: <1238078818-25977-1-git-send-email-os@emlix.com> <20090326155105.5dfbd898@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090326155105.5dfbd898-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Oskar Schirmer <os-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

"

On Thu, Mar 26, 2009 at 15:51:05 +0100, Jean Delvare wrote:
> On Thu, 26 Mar 2009 15:46:58 +0100, Oskar Schirmer wrote:
> > support pca9543 i2c bus switch chip
> > 
> > Signed-off-by: Oskar Schirmer <os-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/i2c/chips/Kconfig   |    3 +
> >  drivers/i2c/chips/Makefile  |    1 +
> 
> Please read the header of these two files carefully again.

Ok, I see. But how to have PCA9543 supported then?
The PCA9543 is an I2C bus switch/mux, so following
the headers it might be placed in drivers/<functionality>,
where <functionality> is "i2c bus mux", thus drivers/i2c.

As this is obviously not the solution, we might try to do the
bus muxing manually from userland, as soon as the system is up.
This wont work either, as the video drivers need the i2c bus
switch programmed before the video stuff can be initialized,
thus during bootup.

Next, the drivers proposed by Rodolfo Giometti
( http://article.gmane.org/gmane.linux.drivers.i2c/2996/ )
might add the functionality needed. As far as I can see from
Documentation/feature-removal-schedule.txt, prerequisites for
it to be accepted are given with 2.6.30, is the driver by
Rodolfo still in the queue, i.e. being merged for 2.6.30 now?

  Oskar
