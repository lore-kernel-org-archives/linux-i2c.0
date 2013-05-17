From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/9] I2C: mv64xxx: work around signals causing I2C
 transactions to be aborted
Date: Fri, 17 May 2013 14:17:56 +0200
Message-ID: <20130517121752.GC2939@katana>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
 <E1Ud4pH-0004JQ-Jq@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1Ud4pH-0004JQ-Jq-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Mark A. Greer" <mgreer-luAo+O/VEmrlveNOaEYElw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, May 16, 2013 at 09:30:59PM +0100, Russell King wrote:
> Do not use interruptible waits in an I2C driver; if a process uses
> signals (eg, Xorg uses SIGALRM and SIGPIPE) then these signals can
> cause the I2C driver to abort a transaction in progress by another
> driver, which can cause that driver to fail.  I2C drivers are not
> expected to abort transactions on signals.
> 
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

Applied to for-current, thanks!

Rest will be reviewed later...
