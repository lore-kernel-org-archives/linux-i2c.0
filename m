From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/2] i2c: i2c-ocores: clock improvements
Date: Mon,  2 Feb 2015 18:28:11 +0300
Message-ID: <1422890893-30989-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Peter, Wolfram,

this series fixes clock-frequency attribute usage by i2c-ocores driver and
adds optional common clock framework support.

Changes v1->v2:
- add cleanup patch for clock-frequency attribute that implements options
  2 and 3, as was suggested here: https://lkml.org/lkml/2015/1/22/527
- make CCF support optional

Max Filippov (2):
  i2c: i2c-ocores: fix clock-frequency binding usage
  i2c: i2c-ocores: add common clock support

 .../devicetree/bindings/i2c/i2c-ocores.txt         | 42 +++++++++-
 drivers/i2c/busses/i2c-ocores.c                    | 95 +++++++++++++++++++---
 2 files changed, 122 insertions(+), 15 deletions(-)

-- 
1.8.1.4
