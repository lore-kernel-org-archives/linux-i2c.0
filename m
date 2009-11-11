From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 3/4] i2c : Limit minimum jiffie timeout to 2
Date: Thu, 12 Nov 2009 00:28:13 +0100
Message-ID: <083DF309106F364B939360100EC290F804F53CC643@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F5343706@eu1rdcrdc1wx030.exi.nxp.com>
 <20091111212152.GK13398@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091111212152.GK13398-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: "vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Limit minimum jiffie timeout to 2 to prevent early timeout on systems
with low tick rates

Signed-off-by: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
---
i2c-pnx.c |    3 +++
 1 file changed, 3 insertions(+)

--- drivers/i2c/busses/i2c-pnx.c.orig	2009-11-11 14:54:30.000000000 -0800
+++ drivers/i2c/busses/i2c-pnx.c	2009-11-11 15:00:17.000000000 -0800
@@ -54,6 +54,9 @@ static inline void i2c_pnx_arm_timer(str
 	struct timer_list *timer = &data->mif.timer;
 	int expires = I2C_PNX_TIMEOUT / (1000 / HZ);
 
+	if (expires <= 1)
+		expires = 2;
+
 	del_timer_sync(timer);
 
 	dev_dbg(&adap->dev, "Timer armed at %lu plus %u jiffies.\n",
