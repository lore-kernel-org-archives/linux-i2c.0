From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 0/4] i2c: small fixes for eg20t
Date: Fri, 20 Apr 2012 22:45:13 +0200
Message-ID: <1334954717-13146-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

These flaws were found by code-checkers and I think they are right.

Wolfram Sang (4):
  i2c: eg20t: use NULL instead of 0
  i2c: eg20t: pass on return value in i2c_xfer
  i2c: eg20t: remove unused function
  i2c: eg20t: don't use strcpy but strlcpy

 drivers/i2c/busses/i2c-eg20t.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

-- 
1.7.10
