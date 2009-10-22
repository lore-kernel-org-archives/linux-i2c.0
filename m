From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: i2c/janitoral: drop NO_IRQ from the subsystem
Date: Thu, 22 Oct 2009 23:11:25 +0200
Message-ID: <1256245888-25210-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

after having to deal with NO_IRQ confusion more than once, I decided to start a
bit of janitorial work and remove it from the i2c-subsystem. Detail for better
using 0 as "no irq" can be found here: http://lkml.org/lkml/2005/11/21/221

Regards,

   Wolfram
