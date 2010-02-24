From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: my i2c-patches for 2.6.34
Date: Wed, 24 Feb 2010 12:00:44 +0100
Message-ID: <20100224110044.GB15181@pengutronix.de>
References: <1257754721-17325-1-git-send-email-u.kleine-koenig@pengutronix.de> <1258658141-30340-1-git-send-email-u.kleine-koenig@pengutronix.de> <1258658141-30340-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1258658141-30340-2-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Ben,

this mail is the fourth try to get some comments on the pxa patches.
Can you please consider to take them for 2.6.34?  Or do you think they
need an ack by someone?

I'll resend them as a reply to this mail, or you can get them via git,
see below.

Best regards
Uwe

The following changes since commit 75ef7cdda2daa35be9e070ac8e5258759ac0=
3d06:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../davem/net-2.6

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git next/i2c

Uwe Kleine-K=F6nig (2):
      i2c/pxa: remove unused macro
      MAINTAINERS: add i2c tree for embedded platforms

Wolfram Sang (1):
      i2c/pxa: only define 'blue_murder'-function if DEBUG is #defined

 MAINTAINERS                  |    1 +
 drivers/i2c/busses/i2c-pxa.c |   26 ++++++++++++++------------
 2 files changed, 15 insertions(+), 12 deletions(-)

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
