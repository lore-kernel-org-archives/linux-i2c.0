From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH 0/3] i2c/at91: add support PM functions
Date: Mon, 20 Oct 2014 11:42:11 +0800
Message-ID: <1413776535-10123-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, ludovic.desroches@atmel.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, wenyou.yang@atmel.com
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

The patches is to add support to PM functions for the at91 i2c controller.

It is based on the i2c/for-next branch of 
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git.

Could you help review it?

Best Regards,
Wenyou Yang

Wenyou Yang (3):
  i2c/at91: add support for runtime PM
  i2c/at91: add support for system PM
  i2c/at91: adopt pinctrl support

 drivers/i2c/busses/i2c-at91.c |   86 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 9 deletions(-)

-- 
1.7.9.5
