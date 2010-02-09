From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [PATCH v4 3/3] powerpc: doc/dts-bindings: update doc of FSL I2C
 bindings
Date: Tue, 09 Feb 2010 19:57:00 +0100
Message-ID: <4B71AFFC.3010301@grandegger.com>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com> 	<1264685141-26391-2-git-send-email-wg@grandegger.com> <1264685141-26391-3-git-send-email-wg@grandegger.com> 	<1264685141-26391-4-git-send-email-wg@grandegger.com> <fa686aa41002090950w2c3cd008k47784089dd3417d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fa686aa41002090950w2c3cd008k47784089dd3417d7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Grant,

Grant Likely wrote:
> On Thu, Jan 28, 2010 at 6:25 AM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> wrote:
>> From: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
>>
>> This patch adds the MPC5121 to the list of supported devices,
>> enhances the doc of the "clock-frequency" property and removes
>> the obsolete "cell-index" property from the example nodes.
>> Furthermore and example for the MPC5121 has been added.
>>
>> Signed-off-by: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
> 
> Thanks Wolfgang.  Comments below.
> 
>> ---
>>  Documentation/powerpc/dts-bindings/fsl/i2c.txt |   30 +++++++++++++++++++----
>>  1 files changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/powerpc/dts-bindings/fsl/i2c.txt b/Documentation/powerpc/dts-bindings/fsl/i2c.txt
>> index b6d2e21..2f62dae 100644
>> --- a/Documentation/powerpc/dts-bindings/fsl/i2c.txt
>> +++ b/Documentation/powerpc/dts-bindings/fsl/i2c.txt
>> @@ -9,8 +9,9 @@ Recommended properties :
>>
>>  - compatible : compatibility list with 2 entries, the first should
>>    be "fsl,CHIP-i2c" where CHIP is the name of a compatible processor,
>> -   e.g. mpc8313, mpc8543, mpc8544, mpc5200 or mpc5200b. The second one
>> -   should be "fsl-i2c".
>> +   e.g. mpc8313, mpc8543, mpc8544, mpc5121, mpc5200 or mpc5200b. The
>> +   second one should be "fsl-i2c". For the mpc5121, an additional node
>> +   "fsl,mpc5121-i2c-ctrl" is required as shown in the example below.
> 
> While you're editing this line; drop the requirement for the second
> value to be 'fsl-i2c'.  We don't use it anymore, and only preserve it
> for backwards compatibility with old trees.

OK.

>>  - interrupts : <a b> where a is the interrupt number and b is a
>>    field that represents an encoding of the sense and level
>>    information for the interrupt.  This should be encoded based on
>> @@ -20,29 +21,46 @@ Recommended properties :
>>    services interrupts for this device.
>>  - fsl,preserve-clocking : boolean; if defined, the clock settings
>>    from the bootloader are preserved (not touched).
>> - - clock-frequency : desired I2C bus clock frequency in Hz.
>> + - clock-frequency : desired I2C bus clock frequency in Hz.  If this
>> +   property and "fsl,preserve-clocking" is not defined, a safe fixed
>> +   clock divider value is used (resulting in a small clock frequency).
> 
> Nah, leave this as is.  Don't make it sound like omitting both
> properties is a valid option.  The driver may (and should!) handle the
> situation gracefully, but that fact does not need to be documented.

The safe value is not a good choice, indeed. Then it will also change
MPC_I2C_CLOCK_SAFE to MPC_I2C_CLOCK_LEGACY in i2c-mpc.c.

I will also fix the other issues you commented on.

Thanks,

Wolfgang.
