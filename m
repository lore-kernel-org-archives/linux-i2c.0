From: "Tan, Chin Yew" <chin.yew.tan@intel.com>
Subject: RE: [PATCH] i2c: designware: Get selected speed mode sda-hold-time
 via ACPI
Date: Mon, 6 Mar 2017 12:30:34 +0000
Message-ID: <1E48613D81AD0745B344B23C7C5E26B001009DC6@PGSMSX103.gar.corp.intel.com>
References: <1487051641-31927-1-git-send-email-chin.yew.tan@intel.com>
 <1487051641-31927-2-git-send-email-chin.yew.tan@intel.com>
 <9287736c-7b7e-4fff-5126-d101044fd00f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:22167 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753258AbdCFMap (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 6 Mar 2017 07:30:45 -0500
In-Reply-To: <9287736c-7b7e-4fff-5126-d101044fd00f@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>

Hi Wolfram,

Wondering if you manage to review this patch?
It is about loading selected speed mode's sda-hold-time via ACPI.

I would like to find out if there are any additional comments?

Sincerely
Tan Chin Yew

> -----Original Message-----
> From: Jarkko Nikula [mailto:jarkko.nikula@linux.intel.com]
> Sent: Tuesday, February 14, 2017 3:01 PM
> To: Tan, Chin Yew <chin.yew.tan@intel.com>;
> andriy.shevchenko@linux.intel.com; mika.westerberg@linux.intel.com
> Cc: linux-i2c@vger.kernel.org
> Subject: Re: [PATCH] i2c: designware: Get selected speed mode sda-hold-time
> via ACPI
> 
> On 14.02.2017 07:54, chin.yew.tan@intel.com wrote:
> > From: Tan Chin Yew <chin.yew.tan@intel.com>
> >
> > Sda-hold-time is an important parameter for tuning i2c to meet the
> > electrical specification especially for high speed. I2C with incorrect
> > sda-hold-time may cause lost arbitration error. Now, the driver is
> > able to get sda-hold-time for all the speed supported.
> >
> > Signed-off-by: Tan Chin Yew <chin.yew.tan@intel.com>
> > ---
> >  drivers/i2c/busses/i2c-designware-platdrv.c | 28
> > +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> >
> 
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
