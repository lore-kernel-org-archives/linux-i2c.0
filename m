From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpio: pca953x: add a comment explaining the need for a lockdep subclass
Date: Mon, 26 Sep 2016 11:54:14 +0200
Message-ID: <1474883655-15824-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38485 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935070AbcIZJyY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 26 Sep 2016 05:54:24 -0400
Received: by mail-wm0-f54.google.com with SMTP id l132so139712335wmf.1
        for <linux-i2c@vger.kernel.org>; Mon, 26 Sep 2016 02:54:23 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since there's an rc8 I thought I'd send a follow-up patch to the
series addressing the lockdep false positive in pca953x.

The reason for setting the subclass in the probe function is not
explained in the code nor is it obvious at first glance. This patch
adds a comment explaining the problem.

Rebased on top of current i2c/for-next.

Bartosz Golaszewski (1):
  gpio: pca953x: add a comment explaining the need for a lockdep
    subclass

 drivers/gpio/gpio-pca953x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.7.4
