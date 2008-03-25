From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] Wanted: i2c subsystem co-maintainer
Date: Tue, 25 Mar 2008 09:50:28 +0100
Message-ID: <20080325095028.07a73b11@hyperion.delvare>
References: <20080304184512.3f78d296@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754040AbYCYJLk@vger.kernel.org>
In-Reply-To: <20080304184512.3f78d296@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux I2C <i2c@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Ben Dooks <ben-linux@fluff.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 4 Mar 2008 18:45:12 +0100, Jean Delvare wrote:
> I have a hard time maintaining the i2c subsystem alone. New drivers
> and, more importantly, subsystem evolutions are submitted much faster
> than I can review and merge them. I am hearing complaints about this.
> It has been lasting for a while now and it doesn't seem like the
> situation is going to improve. Thus, I think it would be better if
> someone was co-maintaining the i2c subsystem with me.
> 
> So, if anyone is interested in co-maintaining the i2c subsystem with
> me, please let me know. The ideal candidate would come from the
> embedded world, as I have absolutely no experience with this myself and
> most of the new drivers are for embedded devices, and should have
> contributed to the kernel in a significant way already.

Ben Dooks agreed to become my co-maintainer for the i2c subsystem. In
particular, Ben will help with drivers for embedded systems, of which
my experience is inexistent. Thanks Ben and welcome on board!

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Ben, please give by your ack on this patch, then I will push it
upstream.

 MAINTAINERS |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.25-rc6.orig/MAINTAINERS	2008-03-21 10:58:23.000000000 +0100
+++ linux-2.6.25-rc6/MAINTAINERS	2008-03-23 15:16:11.000000000 +0100
@@ -1883,6 +1883,8 @@ S:	Maintained
 I2C SUBSYSTEM
 P:	Jean Delvare
 M:	khali@linux-fr.org
+P:	Ben Dooks
+M:	ben-linux@fluff.org
 L:	i2c@lm-sensors.org
 T:	quilt http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/
 S:	Maintained

-- 
Jean Delvare
