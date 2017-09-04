From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 0/3] i2c: Hookup typec power-negotation to the PMIC and charger
Date: Mon,  4 Sep 2017 15:47:00 +0200
Message-ID: <20170904134703.25663-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753574AbdIDNrH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 4 Sep 2017 09:47:07 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

Hi All,

Almost all patches from my patch series for hooking up typec
power-negotation to the PMIC and charger drivers have been
queued for merging into 4.14, here is a v5 of the 3 remainig patches.

The only change from v4 is a small improvement to the Kconfig help
text in the 3th patch.

Regards,

Hans
