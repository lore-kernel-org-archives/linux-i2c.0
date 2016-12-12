From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 2/5] i2c: designware-baytrail: Pass dw_i2c_dev into
 helper functions
Date: Mon, 12 Dec 2016 16:02:41 +0200
Message-ID: <bfeb119d-39ea-6a6d-e977-2be6318a1efb@linux.intel.com>
References: <20161210224350.10290-1-hdegoede@redhat.com>
 <20161210224350.10290-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12897 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752288AbcLLODB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 12 Dec 2016 09:03:01 -0500
In-Reply-To: <20161210224350.10290-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Vincent Gerris <vgerris@gmail.com>, linux-i2c@vger.kernel.org

On 11.12.2016 00:43, Hans de Goede wrote:
> Pass dw_i2c_dev into the helper functions, this is a preparation patch
> for the punit semaphore fixes done in the other patches in this set.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Tested-by: Takashi Iwai <tiwai@suse.de>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-baytrail.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
