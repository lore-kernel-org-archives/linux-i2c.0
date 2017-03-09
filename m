From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 1/2] i2c: designware: Never suspend i2c-busses used for
 accessing the system PMIC
Date: Thu, 9 Mar 2017 17:02:00 +0200
Message-ID: <40748683-5f4e-0032-c156-094f6ed05e21@linux.intel.com>
References: <20170308084713.4815-1-hdegoede@redhat.com>
 <20170308084713.4815-2-hdegoede@redhat.com>
 <728a5859-c4fe-b22c-0dd2-94c48e131134@linux.intel.com>
 <20170309143930.qd6unynjgqd27jot@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36710 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932193AbdCIPCI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Mar 2017 10:02:08 -0500
In-Reply-To: <20170309143930.qd6unynjgqd27jot@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org

On 03/09/17 16:39, Wolfram Sang wrote:
>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>  drivers/i2c/busses/i2c-designware-baytrail.c |  2 +-
>>>  drivers/i2c/busses/i2c-designware-core.c     | 11 +++++++++--
>>>  drivers/i2c/busses/i2c-designware-core.h     |  4 ++--
>>>  drivers/i2c/busses/i2c-designware-platdrv.c  | 10 ++++------
>>>  4 files changed, 16 insertions(+), 11 deletions(-)
>>>
>>
>> Jarkko Nikula <jarkko.nikula@linux.intel.com>
>
> Acked-by ?
>
Sorry, here it goes

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
