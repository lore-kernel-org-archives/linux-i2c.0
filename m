From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/2] mfd: ti-smusbdig: Add support for the TI
 SM-USB-DIG
Date: Wed, 17 Aug 2016 08:45:42 +0100
Message-ID: <20160817074542.GB4254@dell>
References: <20160809145517.22815-1-afd@ti.com>
 <20160809145517.22815-2-afd@ti.com>
 <20160809152742.GS5243@dell>
 <804acc1b-ae73-d1af-bd06-43a2e2145995@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36080 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbcHQHoM (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 17 Aug 2016 03:44:12 -0400
Received: by mail-wm0-f49.google.com with SMTP id q128so184293286wma.1
        for <linux-i2c@vger.kernel.org>; Wed, 17 Aug 2016 00:44:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <804acc1b-ae73-d1af-bd06-43a2e2145995@ti.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>

On Tue, 16 Aug 2016, Andrew F. Davis wrote:

> On 08/09/2016 10:27 AM, Lee Jones wrote:
> > On Tue, 09 Aug 2016, Andrew F. Davis wrote:
> > 
> >> The TI SM-USB-DIG is a USB to SPI/I2C/1Wire/GPIO adapter.
> >> Add MFD core support.
> >>
> >> Signed-off-by: Andrew F. Davis <afd@ti.com>
> >> ---
> >>  drivers/mfd/Kconfig             |   9 +++
> >>  drivers/mfd/Makefile            |   2 +
> >>  drivers/mfd/ti-smusbdig.c       | 138 ++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/mfd/ti-smusbdig.h |  75 ++++++++++++++++++++++
> >>  4 files changed, 224 insertions(+)
> >>  create mode 100644 drivers/mfd/ti-smusbdig.c
> >>  create mode 100644 include/linux/mfd/ti-smusbdig.h
> > 
> > Still requires a DT Ack.
> > 
> > Please ping the relevant guys.
> > 
> 
> This driver doesn't touch DT.
> 
> If you meant USB, could you give me a hint as to who needs to ack
> drivers that communicate over USB?

Ah yes, my bad.  I was on auto-pilot, since that's what I usually find
myself asking for.

W.R.T. the USB Ack, Johan (now CC'ed) has been pretty helpful in the
past.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
