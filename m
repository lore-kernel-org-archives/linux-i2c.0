From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [Patch V3 1/5] ACPICA: Export acpi_buffer_to_resource symbol
Date: Wed, 21 May 2014 10:06:10 +0800
Message-ID: <537C0A12.70902@intel.com>
References: <1400590764-11108-1-git-send-email-tianyu.lan@intel.com> <1400590764-11108-2-git-send-email-tianyu.lan@intel.com> <1782070.yxHZNBOPJ3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1782070.yxHZNBOPJ3@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: wsa@the-dreams.de, mika.westerberg@linux.intel.com, awilliam@redhat.com, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2014=E5=B9=B405=E6=9C=8821=E6=97=A5 05:24, Rafael J. Wysocki wrote:
> On Tuesday, May 20, 2014 08:59:20 PM Lan Tianyu wrote:
>> The acpi_buffer_to_resource is needed in i2c module
>> to convert aml buffer to struct acpi_resource
>>
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>=20
> This isn't necessary on top of current linux-next I believe?  If so,
> please do not resend it any more.

Yes, please ignore it and resending it is to facilitate some testers to
the patchset. Ok. I will not resend it.

>=20
>> ---
>>  drivers/acpi/acpica/rscreate.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rs=
create.c
>> index 75d3690..5828649 100644
>> --- a/drivers/acpi/acpica/rscreate.c
>> +++ b/drivers/acpi/acpica/rscreate.c
>> @@ -112,6 +112,7 @@ acpi_buffer_to_resource(u8 *aml_buffer,
>> =20
>>  	return (status);
>>  }
>> +ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource);
>> =20
>>  /******************************************************************=
*************
>>   *
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
