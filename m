From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware-platform: Drop duplicate module
 information
Date: Thu, 4 Feb 2016 13:36:58 +0200
Message-ID: <56B337DA.7080603@linux.intel.com>
References: <20160202143138.60adac87@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:54803 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758139AbcBDLjI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 4 Feb 2016 06:39:08 -0500
In-Reply-To: <20160202143138.60adac87@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Linux I2C <linux-i2c@vger.kernel.org>
Cc: "David E. Box" <david.e.box@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

On 02/02/2016 03:31 PM, Jean Delvare wrote:
> The i2c-designware-platform module has duplicate module information
> when CONFIG_I2C_DESIGNWARE_BAYTRAIL is set. It gets the information
> from both i2c-designware-platdrv and i2c-designware-baytrail. The
> latter is optional extra code which ends up in the same module so it
> should not export module information.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: David E. Box <david.e.box@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> ---
>   drivers/i2c/busses/i2c-designware-baytrail.c |    5 -----
>   1 file changed, 5 deletions(-)
>
> --- linux-4.5-rc2.orig/drivers/i2c/busses/i2c-designware-baytrail.c	2016-02-02 09:02:08.098923894 +0100
> +++ linux-4.5-rc2/drivers/i2c/busses/i2c-designware-baytrail.c	2016-02-02 13:37:34.418855732 +0100
> @@ -11,7 +11,6 @@
>    * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>    * more details.
>    */
> -#include <linux/module.h>
>   #include <linux/delay.h>
>   #include <linux/device.h>
>   #include <linux/acpi.h>
> @@ -151,7 +150,3 @@ int i2c_dw_eval_lock_support(struct dw_i
>
>   	return 0;
>   }
> -
> -MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
> -MODULE_DESCRIPTION("Baytrail I2C Semaphore driver");
> -MODULE_LICENSE("GPL v2");
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
