From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/1] i2c: designware-baytrail: Fix race when resetting the semaphore
Date: Sun,  1 Jan 2017 12:30:21 +0100
Message-ID: <20170101113022.6791-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754973AbdAALa1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 1 Jan 2017 06:30:27 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>

Hi All,

Here is one more i2c-designware-baytrail patch fixing a (potential) issue
I noticed while looking into i915 <-> pmic-i2c-bus-semaphore code
interactions.

Note this patch applies on top of my previous i2c-designware-baytrail
patches.

Regards,

Hans
