From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 1/9] I2C: mv64xxx: work around signals causing I2C
 transactions to be aborted
Date: Fri, 17 May 2013 08:37:43 +0200
Message-ID: <20130517083743.31af4eb0@armhf>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
	<E1Ud4pH-0004JQ-Jq@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1Ud4pH-0004JQ-Jq-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Mark A. Greer" <mgreer-luAo+O/VEmrlveNOaEYElw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 16 May 2013 21:30:59 +0100
Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:

> Do not use interruptible waits in an I2C driver; if a process uses
> signals (eg, Xorg uses SIGALRM and SIGPIPE) then these signals can
> cause the I2C driver to abort a transaction in progress by another
> driver, which can cause that driver to fail.  I2C drivers are not
> expected to abort transactions on signals.

Hi Russell,

I had the same problem with my dove drm driver, but I don't fully agree
with your solution.

Using wait_event_timeout() stops the system, and reading the EDID from
an external screen may take some time.

Instead, as the problem occurs with the X server on HDMI exchanges,
I acted on the tda998x driver, simply masking the SIGALRM and SIGPIPE
signals on each drm driver request.

This mechanism works fine for me. Patch follows.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
