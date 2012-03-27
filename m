From: Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 0/2] i2c: Don't assume bus nr 0 if none was specified
Date: Tue, 27 Mar 2012 11:10:26 +0200
Message-ID: <1332839428-29705-1-git-send-email-k.lewandowsk@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Changes since v1:
 - Dropped reduntant i2c-octeon change

i2c controller drivers used to assume bus number 0 when none (-1) was
specified.

This worked on non-device tree systems, where one could explicitly
specify bus number via platform data.  On DT-enabled systems bus
number is always -1.

This patchset reworks few remaining drivers to use dynamic bus
allocation when no id has been provided.

[ I've found out this when I've tried to instantiate more than one
  i2c-gpio instance on DT-enabled system. I've, hopefully, fixed few
  other drivers too. ]

Karol Lewandowski (2):
  i2c-pxa: Drop leftover comment
  i2c: Dynamically assign adapter id if it wasn't explictly specified

 drivers/i2c/busses/i2c-gpio.c         |    7 +------
 drivers/i2c/busses/i2c-pca-platform.c |    2 +-
 drivers/i2c/busses/i2c-pxa.c          |    5 -----
 drivers/i2c/busses/i2c-versatile.c    |    9 ++-------
 4 files changed, 4 insertions(+), 19 deletions(-)

-- 
1.7.9.1
