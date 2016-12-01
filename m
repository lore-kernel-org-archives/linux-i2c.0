From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 1/1] i2c: designware-pcidrv: Add 10bit address feature
 to medfield/merrifield
Date: Thu, 1 Dec 2016 09:20:11 +0200
Message-ID: <f62f0207-1e74-7411-06c6-0b84c6e0397f@linux.intel.com>
References: <1480523655-10461-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59273 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753413AbcLAHUO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 1 Dec 2016 02:20:14 -0500
In-Reply-To: <1480523655-10461-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On 30.11.2016 18:34, Alexander Stein wrote:
> Both Merrifield TRM and Medfield TRM state:
> "Both 7-bit and 10-bit addressing modes are supported."
>
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> Changes in v2:
> * Fix typo in commit message
>
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
