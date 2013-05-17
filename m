From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 1/9] I2C: mv64xxx: work around signals causing I2C
	transactions to be aborted
Date: Fri, 17 May 2013 09:31:13 +0100
Message-ID: <20130517083113.GZ18614@n2100.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk> <E1Ud4pH-0004JQ-Jq@rmk-PC.arm.linux.org.uk> <20130517083743.31af4eb0@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130517083743.31af4eb0@armhf>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Mark A. Greer" <mgreer-luAo+O/VEmrlveNOaEYElw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 17, 2013 at 08:37:43AM +0200, Jean-Francois Moine wrote:
> On Thu, 16 May 2013 21:30:59 +0100
> Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> 
> > Do not use interruptible waits in an I2C driver; if a process uses
> > signals (eg, Xorg uses SIGALRM and SIGPIPE) then these signals can
> > cause the I2C driver to abort a transaction in progress by another
> > driver, which can cause that driver to fail.  I2C drivers are not
> > expected to abort transactions on signals.
> 
> Hi Russell,
> 
> I had the same problem with my dove drm driver, but I don't fully agree
> with your solution.
> 
> Using wait_event_timeout() stops the system, and reading the EDID from
> an external screen may take some time.

It doesn't stop the system.  It stops the process until that has completed.
Using the DRM TDA19988 driver, things are nice and quick while reading
the EDID, because it does reads an entire EDID block using one message.

Blocking the signals like you do has exactly the same effect - you
prevent the I2C driver being interrupted by signals.
