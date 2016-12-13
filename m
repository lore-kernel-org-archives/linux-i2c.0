From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v4 5/5] i2c: designware-baytrail: Add support for
 cherrytrail
Date: Tue, 13 Dec 2016 15:45:18 +0200
Message-ID: <0adf44b7-caa5-5feb-13cb-85e37d606cc2@linux.intel.com>
References: <20161212215612.9262-1-hdegoede@redhat.com>
 <20161212215612.9262-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:17795 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932977AbcLMNpW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 13 Dec 2016 08:45:22 -0500
In-Reply-To: <20161212215612.9262-5-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>

On 12/12/2016 11:56 PM, Hans de Goede wrote:
> The cherrytrail punit has the pmic i2c bus access semaphore at a
> different register address.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Tested-by: Takashi Iwai <tiwai@suse.de>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> Changes in v2:
> -Adjust for accessor_flags -> flags rename
> -Add flags field to struct dw_pci_controller
> -Add get_sem_addr() helper replacing MODEL_CHERRYTRAIL flag checking in
>  PUNIT_SEMAPHORE macro
> Changes in v3:
> -Add a gap between ACCESS_* and MODEL_* flags as reserved space for
>  future ACCESS_* flags
> Changes in v4:
> -s/CHV/CHT/
> ---
>  drivers/i2c/busses/i2c-designware-baytrail.c | 22 +++++++++++++++++-----
>  drivers/i2c/busses/i2c-designware-core.h     |  2 ++
>  drivers/i2c/busses/i2c-designware-pcidrv.c   | 26 +++++++++++++++++++-------
>  drivers/i2c/busses/i2c-designware-platdrv.c  |  2 +-
>  4 files changed, 39 insertions(+), 13 deletions(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
