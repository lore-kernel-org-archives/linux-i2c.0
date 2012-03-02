From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V3 0/2] I2C: Add bus recovery infrastructure
Date: Fri, 2 Mar 2012 11:53:41 +0530
Message-ID: <cover.1330669025.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

This patchset adds i2c bus recovery infrastructure to i2c adapters as specified
in the i2c protocol Rev. 03 section 3.16 titled "Bus clear".

http://www.nxp.com/documents/user_manual/UM10204.pdf

This patch was earlier part of a separate thread:
http://www.spinics.net/lists/linux-i2c/msg07267.html

Changes since V2:
- gpio flags are now passed from controller drivers
- added support for sda line polling
- Aligned i2c-designware driver with generic recovery support

Viresh Kumar (2):
  i2c/adapter: Add bus recovery infrastructure
  i2c/designware: Provide optional i2c bus recovery function

 drivers/i2c/busses/i2c-designware-core.c    |    7 ++-
 drivers/i2c/busses/i2c-designware-platdrv.c |   24 +++++
 drivers/i2c/i2c-core.c                      |  125 +++++++++++++++++++++++++++
 include/linux/i2c.h                         |   52 +++++++++++
 include/linux/i2c/i2c-designware.h          |   49 +++++++++++
 5 files changed, 256 insertions(+), 1 deletions(-)
 create mode 100644 include/linux/i2c/i2c-designware.h

-- 
1.7.8.110.g4cb5d
