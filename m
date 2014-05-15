From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch V2 0/9] I2C ACPI operation region handler support
Date: Thu, 15 May 2014 22:49:37 +0800
Message-ID: <5374D401.2010608@intel.com>
References: <1398147855-9868-1-git-send-email-tianyu.lan@intel.com> <3275231.ERSr3mUlis@devpool02> <53722700.6010001@intel.com> <2676258.HXv5hGZIFG@devpool02>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090301070001020905090202"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2676258.HXv5hGZIFG@devpool02>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rolf Eike Beer <eb-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------090301070001020905090202
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/15/2014 03:50 PM, Rolf Eike Beer wrote:
> Lan Tianyu wrote:
>> On 05/13/2014 09:09 PM, Rolf Eike Beer wrote:
>>> Am Montag, 28. April 2014, 22:27:39 schrieb Lan Tianyu:
>>>> ACPI 5.0 spec(5.5.2.4.5) defines GenericSerialBus(i2c, spi, uart)
>>>> operation
>>>> region. It allows ACPI aml code able to access such kind of devices to
>>>> implement some ACPI standard method.
>>>>
>>>> On the Asus T100TA, Bios use GenericSerialBus operation region to access
>>>> i2c device to get battery info. So battery function depends on the I2C
>>>> operation region support. Here is the bug link.
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=69011
>>>
>>> Hi all,
>>
>>> I have tested this series and got some errors, but no additional
> functionality:
>> Hi Rolf:
>> 	Thanks for test. Could you attach the output of dmesg and acpidump?
>> Which machine you are testing on?
>
> Hi,
>
> this is an Aava Inari 8 tablet (pre-release hardware). Please find the DSDT
> and the dmesg.log attached.
>
> In case of any further questions don't hesitate to ask, I'll try to be more
> responsible.
>

Hi Eike:
	Could you apply the patch in the attachment and attach the output of 	dmesg?
					


> Regards,
>
> Eike
>


--------------090301070001020905090202
Content-Type: text/x-patch;
 name="debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="debug.patch"

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 4ed8d48..cc8c132 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -139,8 +139,7 @@ int acpi_bus_attach_private_data(acpi_handle handle, void *data)
 	status = acpi_attach_data(handle,
 			acpi_bus_private_data_handler, data);
 	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR((AE_INFO, "Error attaching device[%p] data\n",
-				handle));
+		acpi_handle_err(handle, "Error attaching device data %d\n", status);
 		return -ENODEV;
 	}
 

--------------090301070001020905090202--
