From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 1/5] i2c: designware: Rename accessor_flags to flags
Date: Mon, 12 Dec 2016 16:02:26 +0200
Message-ID: <b3f2179f-e07b-4cb9-2b62-16530e7a128b@linux.intel.com>
References: <20161210224350.10290-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:6638 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752135AbcLLOCc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 12 Dec 2016 09:02:32 -0500
In-Reply-To: <20161210224350.10290-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Vincent Gerris <vgerris@gmail.com>, linux-i2c@vger.kernel.org

On 11.12.2016 00:43, Hans de Goede wrote:
> Rename accessor_flags to flags, so that we can use the field for
> other flags too. This is a preparation patch for adding cherrytrail
> support to the punit semaphore code.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.c    | 14 +++++++-------
>  drivers/i2c/busses/i2c-designware-core.h    |  2 +-
>  drivers/i2c/busses/i2c-designware-platdrv.c |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
