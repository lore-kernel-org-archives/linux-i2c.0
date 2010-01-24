From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c-fixes
Date: Sun, 24 Jan 2010 15:33:32 +0000
Message-ID: <E1NZ4Sy-0007hj-CB@kira.home.fluff.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 92dcffb916d309aa01778bf8963a6932e401=
4d07:
  Linus Torvalds (1):
        Linux 2.6.33-rc5

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/i2c

Uwe Kleine-K=C3=B6nig (1):
      i2c: imx: call ioremap only after request_mem_region

Valentin Longchamp (1):
      i2c: mxc: let time to generate stop bit

 drivers/i2c/busses/i2c-imx.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)
