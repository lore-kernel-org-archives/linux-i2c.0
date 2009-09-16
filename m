From: Mika Kuoppala <mika.kuoppala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] Better i2c access latencies in high load situations
Date: Wed, 16 Sep 2009 14:17:08 +0300
Message-ID: <1253099829-17655-1-git-send-email-mika.kuoppala@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Kuoppala <mika.kuoppala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

If low priority thread is holding the bus lock while more high
priority threads needs the same i2c bus, priority inversion occurs and
access latency can grow quite large. In my setup i have seen as high as
150ms access latencies in some workloads when the actual physical
transaction is finished in less than 5ms.

The following patch (in separate email) fixes the priority
inversion problem described above by converting the i2c bus lock mutex
to rt_mutex. rt_mutex uses priority inheritance: low priority thread
holding the mutex will get a kick if high priority thread is trying
to acquire the lock.

Thanks,
-- Mika

Mika Kuoppala (1):
  i2c: Prevent priority inversion on top of bus lock by converting it
    to rt_mutex

 drivers/i2c/i2c-core.c |   13 +++++++------
 include/linux/i2c.h    |    3 +--
 2 files changed, 8 insertions(+), 8 deletions(-)
