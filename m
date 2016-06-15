From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v3 1/2] mfd: ti-smusbdig: Add support for the TI
 SM-USB-DIG
Date: Wed, 15 Jun 2016 10:54:05 -0500
Message-ID: <57617A1D.3050502@ti.com>
References: <20160613150800.6302-1-afd@ti.com> <20160615154303.GN4948@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:41079 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbcFOPyK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 15 Jun 2016 11:54:10 -0400
In-Reply-To: <20160615154303.GN4948@dell>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/15/2016 10:43 AM, Lee Jones wrote:
> This requires a USB Ack.
> 
>> The TI SM-USB-DIG is a USB to SPI/I2C/1Wire/GPIO adapter.
>> Add MFD core support.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
> 
> Where is the change log from v1 => v2?
> 

Looking at a diff of the two it looks like all the changes are related
to your v1 feedback:

 - Rename sm-usb-dig -> ti-smusbdig
 - Inline helper functions in header
 - Alphabetize includes

>> Changes from v2:
>>  - Add missing dependency on USB, thanks kbuild test robot
>>
>>  drivers/mfd/Kconfig             |   9 +++
>>  drivers/mfd/Makefile            |   2 +
>>  drivers/mfd/ti-smusbdig.c       | 138 ++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/ti-smusbdig.h |  75 ++++++++++++++++++++++
>>  4 files changed, 224 insertions(+)
>>  create mode 100644 drivers/mfd/ti-smusbdig.c
>>  create mode 100644 include/linux/mfd/ti-smusbdig.h
> 
