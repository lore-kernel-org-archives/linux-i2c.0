From: "Lan, Tianyu" <tianyu.lan@intel.com>
Subject: Re: [PATCH v2 2/2] i2c: designware: Disable pm for PMIC i2c-bus even
 if there is no _SEM method
Date: Fri, 10 Mar 2017 19:34:21 +0800
Message-ID: <93818dd8-01a9-bc37-fc1f-933bd7a69ed4@intel.com>
References: <20170308084713.4815-1-hdegoede@redhat.com>
 <20170308084713.4815-3-hdegoede@redhat.com>
 <8c2c5e0e-8678-e572-3f7a-3d62853e9b21@linux.intel.com>
 <66d1c6fb-9bd0-0594-8136-f9bc44567776@intel.com>
 <2a30fc95-262b-78ff-7809-05ece192dd34@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:32739 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933439AbdCJLe0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 10 Mar 2017 06:34:26 -0500
In-Reply-To: <2a30fc95-262b-78ff-7809-05ece192dd34@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org

On 3/10/2017 3:49 PM, Hans de Goede wrote:
> Hi,
>
> On 10-03-17 03:33, Lan Tianyu wrote:
>> On 2017年03月09日 23:00, Jarkko Nikula wrote:
>>> + Tianyu
>>>
>>> On 03/08/17 10:47, Hans de Goede wrote:
>>>> Cherrytrail devices use the dw i2c-bus with uid 7 to access their PMIC.
>>>> Even if the i2c-bus to the PMIC is not shared with the SoC's P-Unit
>>>> and i2c-designware-baytrail.c thus does not set the pm_disabled flag,
>>>> we still need to disable pm so that ACPI PMIC opregions can access the
>>>> PMIC during late-suspend and early-resume.
>>>>
>>>> This fixes errors like these blocking suspend:
>>>>
>>>>   i2c_designware 808622C1:06: timeout waiting for bus ready
>>>>   ACPI Exception: AE_ERROR, Returned by Handler for [UserDefinedRegion]
>>>>   acpi 80860F14:02: Failed to change power state to D3hot
>>>>   PM: late suspend of devices failed
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>  drivers/i2c/busses/i2c-designware-platdrv.c | 15 +++++++++++++++
>>>>  1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> index 8ed96dd..08d609e 100644
>>>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> @@ -94,7 +94,10 @@ static void dw_i2c_acpi_params(struct
>>>> platform_device *pdev, char method[],
>>>>  static int dw_i2c_acpi_configure(struct platform_device *pdev)
>>>>  {
>>>>      struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
>>>> +    acpi_handle handle = ACPI_HANDLE(&pdev->dev);
>>>>      const struct acpi_device_id *id;
>>>> +    struct acpi_device *adev;
>>>> +    const char *uid;
>>>>
>>>>      dev->adapter.nr = -1;
>>>>      dev->tx_fifo_depth = 32;
>>>> @@ -114,6 +117,18 @@ static int dw_i2c_acpi_configure(struct
>>>> platform_device *pdev)
>>>>      if (id && id->driver_data)
>>>>          dev->flags |= (u32)id->driver_data;
>>>>
>>>> +    if (acpi_bus_get_device(handle, &adev))
>>>> +        return -ENODEV;
>>>> +
>>>> +    /*
>>>> +     * Cherrytrail I2C7 gets used for the PMIC which gets accessed
>>>> +     * through ACPI opregions during late suspend / early resume
>>>> +     * disable pm for it.
>>>> +     */
>>>> +    uid = adev->pnp.unique_id;
>>>> +    if ((dev->flags & MODEL_CHERRYTRAIL) && !strcmp(uid, "7"))
>>>> +        dev->pm_disabled = true;
>>>> +
>>>
>>> I'm fine with this but wondering can this be detected any other way than
>>> hardcoded bus number.
>>>
>>> Tianyu: You are the author of 5d98e61d337c ("I2C/ACPI: Add i2c ACPI
>>> operation region support"). Do you know is there way to see is there a
>>> PMIC connected to the bus?
>>>
>>> Jarkko Nikula <jarkko.nikula@linux.intel.com>
>>
>> Hi Jarkko:
>>       PMIC device node in ACPI table should have _DEP() method to return
>> devices PMIC depends on.
>
> Hmm, interesting point, but I'm afraid by the time the PMIC driver loads
> (and can make say an i2c_adapter_set_syscore call) it is already too late,
> as we need to request the irq in the i2c-adapter driver with certain
> flags and the i2c-adapter needs to be initialized before we can
> load the pmic driver.

Yes, dep_unmet field in the struct acpi_device is designed for this 
case. dep_unmet will be zero after all dependent operation region 
handlers are registered. Please have a look acpi_battery_add() and it 
checks dep_unmet. If dep_unmet isn't equal to zero, it returns 
-EPROBE_DEFER. Device core will try reprobing the device after a device 
driver module is loaded. PMIC driver also should check dep_unmet in probe().


             Device (PMIC)
             {
                 Name (_ADR, Zero)  // _ADR: Address
                 Name (_HID, "INT33FD")  // _HID: Hardware ID
                 Name (_CID, "INT33FD")  // _CID: Compatible ID
                 Name (_DDN, "PMIC GPIO Controller")  // _DDN: DOS 
Device Name
                 Name (_HRV, 0x02)  // _HRV: Hardware Revision
                 Name (_UID, One)  // _UID: Unique ID
                 Name (_DEP, Package (0x01)  // _DEP: Dependencies
                 {
                     I2C7
                 })

...

>
> I really think just doing this for bus number 7 is the best solution
> on all cherrytrail devices I've seen the PMIC is always at bus number 7.

This seems a hack way since PMIC also may have different I2C address. 
This highly depends on vendor design.

>
>> I think the general way to resolve the issue
>> during suspend/resume is to make sure that I2C7 is suspended/resumed
>> later/earlier than PMIC device.
>
> That would also require making sure that the PMIC suspends after any
> devices whose _PS0 / _PS3 methods may need access to PMIC optegions,
> we do not have infrastructure in Linux to do this.

Actually, suspend/resume sequence affects by the device probing
sequence. Please have a look at deferred_probe_work_func() and
device_pm_move_last() which changes the device position in the dpm_list
during reprobing device.



>
> Regards,
>
> Hans
>
