From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v4 1/2] mfd: ti-smusbdig: Add support for the TI
 SM-USB-DIG
Date: Tue, 16 Aug 2016 11:43:42 -0500
Message-ID: <804acc1b-ae73-d1af-bd06-43a2e2145995@ti.com>
References: <20160809145517.22815-1-afd@ti.com>
 <20160809145517.22815-2-afd@ti.com> <20160809152742.GS5243@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:45788 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbcHPQnr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 16 Aug 2016 12:43:47 -0400
In-Reply-To: <20160809152742.GS5243@dell>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/09/2016 10:27 AM, Lee Jones wrote:
> On Tue, 09 Aug 2016, Andrew F. Davis wrote:
> 
>> The TI SM-USB-DIG is a USB to SPI/I2C/1Wire/GPIO adapter.
>> Add MFD core support.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>>  drivers/mfd/Kconfig             |   9 +++
>>  drivers/mfd/Makefile            |   2 +
>>  drivers/mfd/ti-smusbdig.c       | 138 ++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/ti-smusbdig.h |  75 ++++++++++++++++++++++
>>  4 files changed, 224 insertions(+)
>>  create mode 100644 drivers/mfd/ti-smusbdig.c
>>  create mode 100644 include/linux/mfd/ti-smusbdig.h
> 
> Still requires a DT Ack.
> 
> Please ping the relevant guys.
> 

This driver doesn't touch DT.

If you meant USB, could you give me a hint as to who needs to ack
drivers that communicate over USB?
