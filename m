From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] i2c: isch: Remove unnecessary acpi.h include
Date: Mon, 1 Apr 2019 08:50:30 -0500
Message-ID: <CAErSpo6_VMJ8nP9sA2xZffsMXdG3bKKv8WL0skyTTbuLe4WtJQ@mail.gmail.com>
References: <20190325183652.252175-1-helgaas@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325183652.252175-1-helgaas@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mukesh Ojha <mojha@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 25, 2019 at 1:37 PM <helgaas@kernel.org> wrote:
>
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

Added

    Fixes: fd46a0064af1 ("i2c: convert i2c-isch to platform_device")
    Reviewed-by: Jean Delvare <jdelvare@suse.de>
    Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

on my local branch.

Jean, would you like me to repost this with the updates?  I assume you
will merge this (just based on get_maintainer.pl)?

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
>  #define SMBHSTCNT      (0 + sch_smba)
> --
> 2.21.0.392.gf8f6787159e-goog
>
