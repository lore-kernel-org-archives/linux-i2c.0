From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 0/3] i2c-designware: Allow mixed endianness
Date: Wed, 27 Jan 2010 14:19:49 -0500
Message-ID: <20100127191949.575931000@octasic.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


This is the v3 version of the patch which adds support
for the i2c Designware controller when its endianness
differs from that of the cpu.

Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>

---
Changelog v2->v3
- use a single variable for reading COMP_TYPE and PARAM_1 (Ben Dooks)

Changelog v1->v2
- rename i2c_dw_(read|write)l to dw_(read|write)l (Shinya Kuribayashi)
- rename dw_(read|write)l's addr argument to offset (Shinya Kuribayashi)
- replace (if constant == x) with (if x == constant) (Ben Dooks)
---


-- 
