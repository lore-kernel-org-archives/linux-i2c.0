From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 0/2] nomadik-i2c fixes for v3.1
Date: Tue, 28 Jun 2011 10:37:46 +0200
Message-ID: <1309250266-19180-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This is a resend of the pending patches for i2c-nomadik that
should apply cleanly on 3.0-rc4.

Linus Walleij (1):
  i2c-nomadik: fix kerneldoc warning

srinidhi kasagar (1):
  i2c-nomadik: Do not use _interruptible_ variant call

 drivers/i2c/busses/i2c-nomadik.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

-- 
1.7.3.2
