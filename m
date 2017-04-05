From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2] i2c: i2c-scmi: add a MS HID
Date: Wed, 5 Apr 2017 14:59:32 +0200
Message-ID: <20170405145932.3ef689d5@endymion>
References: <1491322707-2991-1-git-send-email-vkrasnov@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1491322707-2991-1-git-send-email-vkrasnov@dev.rtsoft.ru>
Sender: linux-acpi-owner@vger.kernel.org
To: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com, echerkasov@dev.rtsoft.ru, Michael.Brunner@kontron.com
List-Id: linux-i2c@vger.kernel.org

On Tue,  4 Apr 2017 19:18:27 +0300, Viktor Krasnov wrote:
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
> v2: move the definition of the new HID to the driver itself.
> 
> Signed-off-by: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
> Signed-off-by: Michael Brunner <Michael.Brunner@kontron.com>
> Acked-by: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>

Reviewed-by: Jean Delvare <jdelvare@suse.de>

> ---
>  drivers/i2c/busses/i2c-scmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
> index dfc98df..f876dd6 100644
> --- a/drivers/i2c/busses/i2c-scmi.c
> +++ b/drivers/i2c/busses/i2c-scmi.c
> @@ -18,6 +18,9 @@
>  #define ACPI_SMBUS_HC_CLASS		"smbus"
>  #define ACPI_SMBUS_HC_DEVICE_NAME	"cmi"
>  
> +/* SMBUS HID definition as supported by Microsoft Windows */
> +#define ACPI_SMBUS_MS_HID		"SMB0001"
> +
>  ACPI_MODULE_NAME("smbus_cmi");
>  
>  struct smbus_methods_t {
> @@ -51,6 +54,7 @@ struct acpi_smbus_cmi {
>  static const struct acpi_device_id acpi_smbus_cmi_ids[] = {
>  	{"SMBUS01", (kernel_ulong_t)&smbus_methods},
>  	{ACPI_SMBUS_IBM_HID, (kernel_ulong_t)&ibm_smbus_methods},
> +	{ACPI_SMBUS_MS_HID, (kernel_ulong_t)&smbus_methods},
>  	{"", 0}
>  };
>  MODULE_DEVICE_TABLE(acpi, acpi_smbus_cmi_ids);


-- 
Jean Delvare
SUSE L3 Support
