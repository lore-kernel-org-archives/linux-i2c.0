From: Marc Dietrich <Marc.Dietrich-wkdnK3oF/XPYtB+G+YtuwQgYPMzSbZxj@public.gmane.org>
Subject: implementing a slave driver
Date: Sat, 19 Feb 2011 22:53:12 +0100
Message-ID: <201102192253.40287.marc.dietrich@ap.physik.uni-giessen.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

the HW I'm using (tegra) can be configured to act as a slave. This function is 
needed to communicate with an embedded controller (which is the master). I 
like to know if this slave function can/should be implemented in the 
i2c/busses/i2c-tegra.c driver or better outside, e.g. in the driver for the 
embedded controller.

I haven't found any other hw so far which has this function and it seems that 
the i2c layer does not provide any interface for the communication with a 
master.

Thanks for an advice

Marvin
