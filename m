From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH] platform/chrome: Fix i2c-designware adapter name
Date: Tue, 3 Nov 2015 10:49:59 -0800
Message-ID: <20151103184959.GA4215@newt.localdomain>
References: <1446548940-19739-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36526 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbbKCSuD (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 3 Nov 2015 13:50:03 -0500
Content-Disposition: inline
In-Reply-To: <1446548940-19739-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Dudley Du <dudl@cypress.com>, linux-i2c@vger.kernel.org

Jarkko,

On Tue, Nov 03, 2015 at 01:09:00PM +0200, Jarkko Nikula wrote:
> Commit d80d134182ba ("i2c: designware: Move common probe code into
> i2c_dw_probe()") caused the I2C adapter lookup code here to fail for PCI
> enumerated i2c-designware because commit changed the adapter name but
> didn't update it here.
> 
> Fix the I2C adapter lookup by using the "Synopsys DesignWare I2C adapter"
> name.
> 
> Reported-by: Jeremiah Mahler <jmmahler@gmail.com>
> Fixes: d80d134182ba ("i2c: designware: Move common probe code into i2c_dw_probe()")
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> Hi Jeremiah. This is the same diff I had in a reply to your bug report.
> Can you test does this fix work for you as I don't have the HW.
> ---
>  drivers/platform/chrome/chromeos_laptop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
> index 02072749fff3..2b441e9ae593 100644
> --- a/drivers/platform/chrome/chromeos_laptop.c
> +++ b/drivers/platform/chrome/chromeos_laptop.c
> @@ -47,8 +47,8 @@ static const char *i2c_adapter_names[] = {
>  	"SMBus I801 adapter",
>  	"i915 gmbus vga",
>  	"i915 gmbus panel",
> -	"i2c-designware-pci",
> -	"i2c-designware-pci",
> +	"Synopsys DesignWare I2C adapter",
> +	"Synopsys DesignWare I2C adapter",
>  };
>  
>  /* Keep this enum consistent with i2c_adapter_names */
> -- 
> 2.6.2
> 

Yes, this patch fixes the problem.

Tested-by: Jeremiah Mahler <jmmahler@gmail.com>

-- 
- Jeremiah Mahler
