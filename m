From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 0/2] i2c: designware: Never suspend i2c-busses used for system PMICs
Date: Wed,  8 Mar 2017 09:47:11 +0100
Message-ID: <20170308084713.4815-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751941AbdCHIrW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 8 Mar 2017 03:47:22 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org

Hi All,

Here is a v2 of this patch-set rebased on top of 4.11-rc1 +
drm-intel/topic/designware-baytrail :
https://cgit.freedesktop.org/drm-intel/log/?h=topic/designware-baytrail

Note these patches depend on changes in drm-intel/topic/designware-baytrail
and will not apply cleanly without that branch being merged first.

Regards,

Hans
