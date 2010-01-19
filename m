From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 0/3] i2c-designware: Allow mixed endianness
Date: Tue, 19 Jan 2010 09:02:34 -0500
Message-ID: <20100119140234.689304000@octasic.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


This is the v2 version of the patch which adds support
for the i2c Designware controller when its endianness
differs from that of the cpu.

---
Changelog v1->v2
- rename i2c_dw_(read|write)l to dw_(read|write)l (Shinya Kuribayashi)
- rename dw_(read|write)l's addr argument to offset (Shinya Kuribayashi)
- replace (if constant == x) with (if x == constant) (Ben Dooks)
---


Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>


-- 
