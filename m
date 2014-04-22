From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 1/9] ACPICA: Executer: Fix buffer allocation issue for
 generic_serial_bus region field accesses.
Date: Tue, 22 Apr 2014 09:14:47 +0800
Message-ID: <5355C287.7040403@intel.com>
References: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com> <1397654682-7094-2-git-send-email-tianyu.lan@intel.com> <5269843.b915ubdT5E@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5269843.b915ubdT5E@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: wsa@the-dreams.de, lenb@kernel.org, mika.westerberg@linux.intel.com, awilliam@redhat.com, robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org
List-Id: linux-i2c@vger.kernel.org

On 2014=E5=B9=B404=E6=9C=8822=E6=97=A5 05:38, Rafael J. Wysocki wrote:
> Hi,
>=20
> On Wednesday, April 16, 2014 09:24:34 PM Lan Tianyu wrote:
>> From: Lv Zheng <lv.zheng@intel.com>
>>
>> The size of the buffer allocated for generic_serial_bus region acces=
s
>> is not correct.  This patch introduces acpi_ex_get_serial_access_len=
gth()
>> to be invoked to obtain correct data buffer length.  Reported by
>> Lan Tianyu, Fixed by Lv Zheng.
>>
>> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>=20
> I'm queueing up this patch as a fix for 3.15, but can you please rese=
nd the
> whole series with a CC to linux-acpi?
>=20

Ok. I will do that.

>=20
>> ---
>>  drivers/acpi/acpica/exfield.c | 104 +++++++++++++++++++++++++++++++=
++++++++---
>>  1 file changed, 97 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exf=
ield.c
>> index 68d9744..12878e1 100644
>> --- a/drivers/acpi/acpica/exfield.c
>> +++ b/drivers/acpi/acpica/exfield.c
>> @@ -45,10 +45,71 @@
>>  #include "accommon.h"
>>  #include "acdispat.h"
>>  #include "acinterp.h"
>> +#include "amlcode.h"
>> =20
>>  #define _COMPONENT          ACPI_EXECUTER
>>  ACPI_MODULE_NAME("exfield")
>> =20
>> +/* Local prototypes */
>> +static u32
>> +acpi_ex_get_serial_access_length(u32 accessor_type, u32 access_leng=
th);
>> +
>> +/******************************************************************=
*************
>> + *
>> + * FUNCTION:    acpi_get_serial_access_bytes
>> + *
>> + * PARAMETERS:  accessor_type   - The type of the protocol indicate=
d by region
>> + *                                field access attributes
>> + *              access_length   - The access length of the region f=
ield
>> + *
>> + * RETURN:      Decoded access length
>> + *
>> + * DESCRIPTION: This routine returns the length of the generic_seri=
al_bus
>> + *              protocol bytes
>> + *
>> + ******************************************************************=
************/
>> +
>> +static u32
>> +acpi_ex_get_serial_access_length(u32 accessor_type, u32 access_leng=
th)
>> +{
>> +	u32 length;
>> +
>> +	switch (accessor_type) {
>> +	case AML_FIELD_ATTRIB_QUICK:
>> +
>> +		length =3D 0;
>> +		break;
>> +
>> +	case AML_FIELD_ATTRIB_SEND_RCV:
>> +	case AML_FIELD_ATTRIB_BYTE:
>> +
>> +		length =3D 1;
>> +		break;
>> +
>> +	case AML_FIELD_ATTRIB_WORD:
>> +	case AML_FIELD_ATTRIB_WORD_CALL:
>> +
>> +		length =3D 2;
>> +		break;
>> +
>> +	case AML_FIELD_ATTRIB_MULTIBYTE:
>> +	case AML_FIELD_ATTRIB_RAW_BYTES:
>> +	case AML_FIELD_ATTRIB_RAW_PROCESS:
>> +
>> +		length =3D access_length;
>> +		break;
>> +
>> +	case AML_FIELD_ATTRIB_BLOCK:
>> +	case AML_FIELD_ATTRIB_BLOCK_CALL:
>> +	default:
>> +
>> +		length =3D ACPI_GSBUS_BUFFER_SIZE;
>> +		break;
>> +	}
>> +
>> +	return (length);
>> +}
>> +
>>  /******************************************************************=
*************
>>   *
>>   * FUNCTION:    acpi_ex_read_data_from_field
>> @@ -63,8 +124,9 @@ ACPI_MODULE_NAME("exfield")
>>   *              Buffer, depending on the size of the field.
>>   *
>>   ******************************************************************=
************/
>> +
>>  acpi_status
>> -acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
>> +acpi_ex_read_data_from_field(struct acpi_walk_state * walk_state,
>>  			     union acpi_operand_object *obj_desc,
>>  			     union acpi_operand_object **ret_buffer_desc)
>>  {
>> @@ -73,6 +135,7 @@ acpi_ex_read_data_from_field(struct acpi_walk_sta=
te *walk_state,
>>  	acpi_size length;
>>  	void *buffer;
>>  	u32 function;
>> +	u16 accessor_type;
>> =20
>>  	ACPI_FUNCTION_TRACE_PTR(ex_read_data_from_field, obj_desc);
>> =20
>> @@ -116,9 +179,22 @@ acpi_ex_read_data_from_field(struct acpi_walk_s=
tate *walk_state,
>>  			    ACPI_READ | (obj_desc->field.attribute << 16);
>>  		} else if (obj_desc->field.region_obj->region.space_id =3D=3D
>>  			   ACPI_ADR_SPACE_GSBUS) {
>> -			length =3D ACPI_GSBUS_BUFFER_SIZE;
>> -			function =3D
>> -			    ACPI_READ | (obj_desc->field.attribute << 16);
>> +			accessor_type =3D obj_desc->field.attribute;
>> +			length =3D acpi_ex_get_serial_access_length(accessor_type,
>> +								  obj_desc->
>> +								  field.
>> +								  access_length);
>> +
>> +			/*
>> +			 * Add additional 2 bytes for modeled generic_serial_bus data bu=
ffer:
>> +			 * typedef struct {
>> +			 *     BYTEStatus; // Byte 0 of the data buffer
>> +			 *     BYTELength; // Byte 1 of the data buffer
>> +			 *     BYTE[x-1]Data; // Bytes 2-x of the arbitrary length data =
buffer,
>> +			 * }
>> +			 */
>> +			length +=3D 2;
>> +			function =3D ACPI_READ | (accessor_type << 16);
>>  		} else {	/* IPMI */
>> =20
>>  			length =3D ACPI_IPMI_BUFFER_SIZE;
>> @@ -231,6 +307,7 @@ acpi_ex_write_data_to_field(union acpi_operand_o=
bject *source_desc,
>>  	void *buffer;
>>  	union acpi_operand_object *buffer_desc;
>>  	u32 function;
>> +	u16 accessor_type;
>> =20
>>  	ACPI_FUNCTION_TRACE_PTR(ex_write_data_to_field, obj_desc);
>> =20
>> @@ -284,9 +361,22 @@ acpi_ex_write_data_to_field(union acpi_operand_=
object *source_desc,
>>  			    ACPI_WRITE | (obj_desc->field.attribute << 16);
>>  		} else if (obj_desc->field.region_obj->region.space_id =3D=3D
>>  			   ACPI_ADR_SPACE_GSBUS) {
>> -			length =3D ACPI_GSBUS_BUFFER_SIZE;
>> -			function =3D
>> -			    ACPI_WRITE | (obj_desc->field.attribute << 16);
>> +			accessor_type =3D obj_desc->field.attribute;
>> +			length =3D acpi_ex_get_serial_access_length(accessor_type,
>> +								  obj_desc->
>> +								  field.
>> +								  access_length);
>> +
>> +			/*
>> +			 * Add additional 2 bytes for modeled generic_serial_bus data bu=
ffer:
>> +			 * typedef struct {
>> +			 *     BYTEStatus; // Byte 0 of the data buffer
>> +			 *     BYTELength; // Byte 1 of the data buffer
>> +			 *     BYTE[x-1]Data; // Bytes 2-x of the arbitrary length data =
buffer,
>> +			 * }
>> +			 */
>> +			length +=3D 2;
>> +			function =3D ACPI_WRITE | (accessor_type << 16);
>>  		} else {	/* IPMI */
>> =20
>>  			length =3D ACPI_IPMI_BUFFER_SIZE;
>>
>=20


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
