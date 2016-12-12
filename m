From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 3/5] i2c: designware-baytrail: Only check
 iosf_mbi_available() for shared hosts
Date: Mon, 12 Dec 2016 16:03:08 +0200
Message-ID: <8197b9db-b43f-8ef0-9c9f-e02a9d2fba5e@linux.intel.com>
References: <20161210224350.10290-1-hdegoede@redhat.com>
 <20161210224350.10290-3-hdegoede@redhat.com>
 <1481537990.7188.15.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:6363 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752320AbcLLODM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 12 Dec 2016 09:03:12 -0500
In-Reply-To: <1481537990.7188.15.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Vincent Gerris <vgerris@gmail.com>, linux-i2c@vger.kernel.org

On 12.12.2016 12:19, Andy Shevchenko wrote:
> On Sat, 2016-12-10 at 23:43 +0100, Hans de Goede wrote:
>> If (!shared_host) simply return 0, this avoids delaying the probe if
>> iosf_mbi_available() returns false when an i2c bus is not using the
>> punit semaphore.
>>
>> Also move the if (!iosf_mbi_available()) check to above the
>> dev_info, so that we do not repeat the dev_info on every probe
>> until iosf_mbi_available() returns true.
>>
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
