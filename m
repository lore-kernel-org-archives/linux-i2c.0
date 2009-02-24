From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: i2c/pca: handle timeout
Date: Tue, 24 Feb 2009 17:22:13 +0100
Message-ID: <1235492536-31695-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

So, here are my patches to handle the timeout better with the
PCA-algorithm and -drivers. They compile (for me ;)) and with the
platform-driver I can still access an eeprom & rtc.

Please review.

Regards,

   Wolfram
