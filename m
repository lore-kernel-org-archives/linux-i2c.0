From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v4] i2c: designware: Implement support for SMBus block
 read and write
Date: Thu, 10 Nov 2016 13:07:03 +0200
Message-ID: <166a746e-2e7e-6c87-5c05-cc28dd06bc72@linux.intel.com>
References: <1478746593-10905-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:18975 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755197AbcKJLHH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 10 Nov 2016 06:07:07 -0500
In-Reply-To: <1478746593-10905-1-git-send-email-tnhuynh@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: tnhuynh@apm.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com

On 11/10/2016 04:56 AM, tnhuynh@apm.com wrote:
> From: Tin Huynh <tnhuynh@apm.com>
>
> Free and Open IPMI use SMBUS BLOCK Read/Write to support SSIF protocol.
> However, I2C Designware Core Driver doesn't handle the case at the moment.
> The below patch supports this feature.
>
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
> ---
> Change from V3:
> - Correct coding conventions
> - Make clean
> Change from V2:
> - Change subject of email
> - Add a helper function to handle
>   length byte receiving
> Change from V1:
> - Remove empty lines
> - Add flags variable to make clean code
> - Change DW_DEFAULT_FUNCTIONALITY
>   in i2c-designware-pcidrv.c
> ---
>  drivers/i2c/busses/i2c-designware-core.c    |   46 +++++++++++++++++++++++++--
>  drivers/i2c/busses/i2c-designware-pcidrv.c  |    1 +
>  drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
>  3 files changed, 45 insertions(+), 3 deletions(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
