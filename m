From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: isch: Remove unnecessary acpi.h include
Date: Sun, 31 Mar 2019 10:36:24 +0200
Message-ID: <20190331103624.4a13c5ee@endymion>
References: <20190325183652.252175-1-helgaas@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325183652.252175-1-helgaas@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: helgaas@kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, 25 Mar 2019 13:36:52 -0500, helgaas@kernel.org wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
> convert i2c-isch to platform_device") removed the use of
> acpi_check_region() but not the include.
> 
> Remove the now-unnecessary include of <linux/acpi.h>.  No functional change
> intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/i2c/busses/i2c-isch.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
> index 5c754bf659e2..f64c1d72f73f 100644
> --- a/drivers/i2c/busses/i2c-isch.c
> +++ b/drivers/i2c/busses/i2c-isch.c
> @@ -30,7 +30,6 @@
>  #include <linux/ioport.h>
>  #include <linux/i2c.h>
>  #include <linux/io.h>
> -#include <linux/acpi.h>
>  
>  /* SCH SMBus address offsets */
>  #define SMBHSTCNT	(0 + sch_smba)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

(I would add a Fixes tag but maybe that's just me.)

Thanks,
-- 
Jean Delvare
SUSE L3 Support
