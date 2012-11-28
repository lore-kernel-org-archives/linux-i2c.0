From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 0/2] i2c: remove __dev* attributes
Date: Wed, 28 Nov 2012 11:15:51 -0500
Message-ID: <1354119353-7804-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

These are checkpatch clean replacements for patches 14 and 16 from the
previous series that removed the __dev* attributes.

Bill Pemberton (2):
  i2c-ali1563: remove __dev* attributes
  i2c: SMBus: remove __dev* attributes

 drivers/i2c/busses/i2c-ali1535.c |  8 ++++----
 drivers/i2c/busses/i2c-ali1563.c | 10 +++++-----
 drivers/i2c/busses/i2c-ali15x3.c |  8 ++++----
 drivers/i2c/busses/i2c-amd756.c  |  7 +++----
 drivers/i2c/busses/i2c-amd8111.c |  7 +++----
 drivers/i2c/busses/i2c-i801.c    | 28 +++++++++++++---------------
 drivers/i2c/busses/i2c-isch.c    |  6 +++---
 drivers/i2c/busses/i2c-nforce2.c | 12 ++++++------
 drivers/i2c/busses/i2c-piix4.c   | 32 +++++++++++++++-----------------
 drivers/i2c/busses/i2c-sis5595.c |  4 ++--
 drivers/i2c/busses/i2c-sis630.c  |  8 ++++----
 drivers/i2c/busses/i2c-via.c     |  6 +++---
 drivers/i2c/busses/i2c-viapro.c  |  4 ++--
 13 files changed, 67 insertions(+), 73 deletions(-)

-- 
1.8.0.1
