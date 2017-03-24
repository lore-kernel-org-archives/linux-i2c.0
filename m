From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i2c-scmi: add a MS HID
Date: Fri, 24 Mar 2017 10:16:05 +0100
Message-ID: <20170324101605.7a2c8893@endymion>
References: <1489154315-26499-1-git-send-email-vkrasnov@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51477 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934874AbdCXJQJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 24 Mar 2017 05:16:09 -0400
In-Reply-To: <1489154315-26499-1-git-send-email-vkrasnov@dev.rtsoft.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, Edgar Cherkasov <echerkasov@dev.rtsoft.ru>, Michael Brunner <Michael.Brunner@kontron.com>

On Fri, 10 Mar 2017 16:58:35 +0300, Viktor Krasnov wrote:
> From: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
> 
> Description of the problem:
>  - i2c-scmi driver contains only two identifiers "SMBUS01" and "SMBUSIBM";
>  - the fist HID (SMBUS01) is clearly defined in "SMBus Control Method
>    Interface Specification, version 1.0": "Each device must specify 
>    'SMBUS01' as its _HID and use a unique _UID value";
>  - unfortunately, BIOS vendors (like AMI) seem to ignore this requirement
>    and implement "SMB0001" HID instead of "SMBUS01";
>  - I speculate that they do this because only "SMB0001" is hard coded in
>    Windows SMBus driver produced by Microsoft.
> 
> This leads to following situation:
>  - SMBus works out of box in Windows but not in Linux;
>  - board vendors are forced to add correct "SMBUS01" HID to BIOS to make
>    SMBus work in Linux. Moreover the same board vendors complain that
>    tools (3-rd party ASL compiler) do not like the "SMBUS01" identifier
>    and produce errors.  So they need to constantly patch the compiler for 
>    each new version of BIOS.
> 
> As it is very unlikely that BIOS vendors implement a correct HID in
> future, I would propose to consider whether it is possible to work around
> the problem by adding MS HID to the Linux i2c-scmi driver.
> 
> Signed-off-by: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
> Signed-off-by: Michael Brunner <Michael.Brunner@kontron.com>
> Acked-by: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
> ---
>  drivers/i2c/busses/i2c-scmi.c | 1 +
>  include/acpi/acpi_drivers.h   | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
> index dfc98df..fb9aee0 100644
> --- a/drivers/i2c/busses/i2c-scmi.c
> +++ b/drivers/i2c/busses/i2c-scmi.c
> @@ -51,6 +51,7 @@ struct acpi_smbus_cmi {
>  static const struct acpi_device_id acpi_smbus_cmi_ids[] = {
>  	{"SMBUS01", (kernel_ulong_t)&smbus_methods},
>  	{ACPI_SMBUS_IBM_HID, (kernel_ulong_t)&ibm_smbus_methods},
> +	{ACPI_SMBUS_MS_HID, (kernel_ulong_t)&smbus_methods},
>  	{"", 0}
>  };
>  MODULE_DEVICE_TABLE(acpi, acpi_smbus_cmi_ids);
> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index 29c6912..d34538b 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -60,6 +60,8 @@
>  #define ACPI_DOCK_HID			"LNXDOCK"
>  /* Quirk for broken IBM BIOSes */
>  #define ACPI_SMBUS_IBM_HID		"SMBUSIBM"
> +/* SMBUS HID definition as supported by Microsoft Windows */
> +#define ACPI_SMBUS_MS_HID		"SMB0001"
>  
>  /*
>   * For fixed hardware buttons, we fabricate acpi_devices with HID

No objection from me.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
