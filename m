From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] I2C: add driver for SMBus Control Method Interface
Date: Thu, 17 Sep 2009 11:45:53 +0200
Message-ID: <20090917114553.7abddd1e@hyperion.delvare>
References: <20090916091825.GA29707@crane-desktop>
	<20090916154846.70413d42@hyperion.delvare>
	<20090917044647.GB13319@crane-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090917044647.GB13319@crane-desktop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 17 Sep 2009 12:46:47 +0800, Crane Cai wrote:
> Hi Jean,
> 
> On Wed, Sep 16, 2009 at 03:48:46PM +0200, Jean Delvare wrote:
> > If you are fine with my latest proposals, I'll implement them myself,
> > no need to resend a patch. Thanks a lot for writing the driver!
> OK, I'm fine. Now it is the time in v2.6.32 merge window. I wish we can submit
> it in time.

Yes, we are right in time for 2.6.32 :)

> 
> Considering my time zone 6 hours ahead of you. I modify the source as you said.
> The discouraged print message I simple removed. For your reference.
> 
> ---
>  drivers/i2c/busses/i2c-cmi.c |   43 ++++++++++++++---------------------------
>  1 files changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cmi.c b/drivers/i2c/busses/i2c-cmi.c
> index 555b482..e6cdefc 100644
> --- a/drivers/i2c/busses/i2c-cmi.c
> +++ b/drivers/i2c/busses/i2c-cmi.c
> @@ -16,16 +16,15 @@
>  #include <linux/i2c.h>
>  #include <linux/acpi.h>
>  
> -#define ACPI_SMBUS_HC_COMPONENT		0x00080000
>  #define ACPI_SMBUS_HC_CLASS		"smbus"
>  #define ACPI_SMBUS_HC_DEVICE_NAME	"cmi"
>  
>  ACPI_MODULE_NAME("smbus_cmi");
>  
>  struct smbus_methods_t {
> -	const char *mt_info;
> -	const char *mt_sbr;
> -	const char *mt_sbw;
> +	char *mt_info;
> +	char *mt_sbr;
> +	char *mt_sbw;
>  };
>  
>  struct acpi_smbus_cmi {
> @@ -56,8 +55,8 @@ static const struct acpi_device_id acpi_smbus_cmi_ids[] = {
>  #define ACPI_SMBUS_STATUS_ACC_DENY		0x17
>  #define ACPI_SMBUS_STATUS_TIMEOUT		0x18
>  #define ACPI_SMBUS_STATUS_NOTSUP		0x19
> -#define ACPI_SMBUS_STATUS_BUSY			0x1A
> -#define ACPI_SMBUS_STATUS_PEC			0x1F
> +#define ACPI_SMBUS_STATUS_BUSY			0x1a
> +#define ACPI_SMBUS_STATUS_PEC			0x1f
>  
>  #define ACPI_SMBUS_PRTCL_WRITE			0x00
>  #define ACPI_SMBUS_PRTCL_READ			0x01
> @@ -151,11 +150,11 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
>  
>  	if (read_write == I2C_SMBUS_READ) {
>  		protocol |= ACPI_SMBUS_PRTCL_READ;
> -		method = (char *)smbus_methods.mt_sbr;
> +		method = smbus_methods.mt_sbr;
>  		input.count = 3;
>  	} else {
>  		protocol |= ACPI_SMBUS_PRTCL_WRITE;
> -		method = (char *)smbus_methods.mt_sbw;
> +		method = smbus_methods.mt_sbw;
>  		input.count = 5;
>  	}
>  
> @@ -282,17 +281,17 @@ static const struct i2c_algorithm acpi_smbus_cmi_algorithm = {
>  	.functionality = acpi_smbus_cmi_func,
>  };
>  
> +
>  static int acpi_smbus_cmi_add_cap(struct acpi_smbus_cmi *smbus_cmi,
>  				  const char *name)
>  {
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  	union acpi_object *obj;
> -	int i;
>  	acpi_status status;
>  
>  	if (!strcmp(name, smbus_methods.mt_info)) {
>  		status = acpi_evaluate_object(smbus_cmi->handle,
> -					(char *)smbus_methods.mt_info,
> +					smbus_methods.mt_info,
>  					NULL, &buffer);
>  		if (ACPI_FAILURE(status)) {
>  			ACPI_ERROR((AE_INFO, "Evaluating %s: %i",
> @@ -311,21 +310,12 @@ static int acpi_smbus_cmi_add_cap(struct acpi_smbus_cmi *smbus_cmi,
>  
>  		if (obj->type != ACPI_TYPE_INTEGER) {
>  			ACPI_ERROR((AE_INFO, "Invalid argument type"));
> +			kfree(buffer.pointer);
>  			return -EIO;
>  		} else
>  			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SMBus CMI Version %x"
>  					  "\n", (int)obj->integer.value));
>  
> -		obj = obj->package.elements + 1;
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SMB_INFO:\n"));
> -		for (i = 0; i < obj->buffer.length; i++) {
> -			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "%02x ",
> -						*(obj->buffer.pointer + i)));
> -			if (i > 0 && (i % 16) == 0 && i != obj->buffer.length-1)
> -				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "\n"));
> -		}
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "\n"));
> -
>  		kfree(buffer.pointer);
>  		smbus_cmi->cap_info = 1;
>  	} else if (!strcmp(name, smbus_methods.mt_sbr))
> @@ -333,7 +323,8 @@ static int acpi_smbus_cmi_add_cap(struct acpi_smbus_cmi *smbus_cmi,
>  	else if (!strcmp(name, smbus_methods.mt_sbw))
>  		smbus_cmi->cap_write = 1;
>  	else
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "CMI Methods: %s\n", name));
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Unsupported CMI Method: %s\n",
> +				  name));
>  
>  	return 0;
>  }
> @@ -377,7 +368,7 @@ static int acpi_smbus_cmi_add(struct acpi_device *device)
>  		goto err;
>  
>  	snprintf(smbus_cmi->adapter.name, sizeof(smbus_cmi->adapter.name),
> -		"SMBus CMI adapter at %s-%s",
> +		"SMBus CMI adapter %s (%s)",
>  		acpi_device_name(device),
>  		acpi_device_uid(device));
>  	smbus_cmi->adapter.owner = THIS_MODULE;
> @@ -405,7 +396,7 @@ static int acpi_smbus_cmi_remove(struct acpi_device *device, int type)
>  
>  	i2c_del_adapter(&smbus_cmi->adapter);
>  	kfree(smbus_cmi);
> -	smbus_cmi = NULL;
> +	device->driver_data = NULL;
>  
>  	return 0;
>  }
> @@ -422,11 +413,7 @@ static struct acpi_driver acpi_smbus_cmi_driver = {
>  
>  static int __init acpi_smbus_cmi_init(void)
>  {
> -	int result;
> -
> -	result = acpi_bus_register_driver(&acpi_smbus_cmi_driver);
> -
> -	return result;
> +	return acpi_bus_register_driver(&acpi_smbus_cmi_driver);
>  }
>  
>  static void __exit acpi_smbus_cmi_exit(void)

Changes merged, thanks.

-- 
Jean Delvare
