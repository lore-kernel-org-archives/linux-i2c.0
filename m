From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] i2c: at91: fix code checker warnings
Date: Thu, 11 Jun 2015 11:16:31 +0200
Message-ID: <cover.1434013494.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ChangeLog

v1:
This patch fixes somes code checker warnings reported by Wolfram Sang:

drivers/i2c/busses/i2c-at91.c:213: style: Checking if unsigned variable 'buf_len' is less than zero.
drivers/i2c/busses/i2c-at91.c:254: style: Checking if unsigned variable 'buf_len' is less than zero.
drivers/i2c/busses/i2c-at91.c:293: style: Checking if unsigned variable 'buf_len' is less than zero.

Thanks for reporting!

Cyrille Pitchen (1):
  i2c: at91: fix code checker warnings

 drivers/i2c/busses/i2c-at91.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.2.2
