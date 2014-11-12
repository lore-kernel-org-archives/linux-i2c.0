From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 0/4 v2] i2c-i801: Make interrupt mode more robust
Date: Wed, 12 Nov 2014 10:19:31 +0100
Message-ID: <20141112101931.5f8c196a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

This is a patch series aiming at making the interrupt mode of the
i2c-i801 driver more robust. A number of driver lock-ups have been
reported on a few systems over the past few years, all related to
interrupt mode. So let's make it more tolerant to unreliable hardware
or whatever the actual problem is.

i2c-i801: Use wait_event_timeout to wait for interrupts
i2c-i801: Fallback to polling if request_irq() fails
i2c-i801: Check if interrupts are disabled
i2c-i801: Drop useless debug message

Changes since v1:
 * Updated according to Wolfram's review. Thanks!

-- 
Jean Delvare
SUSE L3 Support
