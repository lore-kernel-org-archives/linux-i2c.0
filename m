From: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/2] i2c-designware-pci: Add Haswell ULT device support
Date: Sun, 20 Oct 2013 20:26:48 -0700
Message-ID: <1382326010-4554-1-git-send-email-bleung@chromium.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dlaurie-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add the Haswell ULT device IDs for i2c-designware-pci. These are used,
for example, in Haswell generation Chromebooks, the HP Chromebook 14
and the Acer C720.

[PATCH 1/2] i2c-designware-pci: Add Haswell ULT device IDs
[PATCH 2/2] i2c-designware-pci: Index Haswell ULT bus names from 0
