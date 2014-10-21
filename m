From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/3] i2c/at91: add support PM functions
Date: Tue, 21 Oct 2014 10:26:16 +0800
Message-ID: <1413858379-22865-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

The patches is to add the PM functions support for the at91 i2c controller.

It is based on the i2c/for-next branch of 
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git.

Best Regards,
Wenyou Yang

------
Change log:
v2.0

According to the advice from Kevin Hilman, 
1./ Wrap the runtime suspend/resume functions in CONFIG_PM instead of CONFIG_PM_RUNTIME.
2./ Call the runtime suspend/resume functions directly in the system suspend/resume.

Wenyou Yang (3):
  i2c/at91: add support for runtime PM
  i2c/at91: add support for system PM
  i2c/at91: adopt pinctrl support

 drivers/i2c/busses/i2c-at91.c |   74 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 8 deletions(-)

-- 
1.7.9.5
