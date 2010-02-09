From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v4 3/3] powerpc: doc/dts-bindings: update doc of FSL I2C
	bindings
Date: Tue, 9 Feb 2010 15:15:02 -0700
Message-ID: <fa686aa41002091415i1b1b722epe44a6ba52a7c066f@mail.gmail.com>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>
	<1264685141-26391-2-git-send-email-wg@grandegger.com> <1264685141-26391-3-git-send-email-wg@grandegger.com>
	<1264685141-26391-4-git-send-email-wg@grandegger.com> <fa686aa41002090950w2c3cd008k47784089dd3417d7@mail.gmail.com>
	<4B71AFFC.3010301@grandegger.com> <4B71B618.6020807@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B71B618.6020807-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 9, 2010 at 12:23 PM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org=
> wrote:
> Wolfgang Grandegger wrote:
>> Hi Grant,
>>
>> Grant Likely wrote:
>>> On Thu, Jan 28, 2010 at 6:25 AM, Wolfgang Grandegger <wg@grandegger=
=2Ecom> wrote:
>>>> From: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
>>>>
>>>> This patch adds the MPC5121 to the list of supported devices,
>>>> enhances the doc of the "clock-frequency" property and removes
>>>> the obsolete "cell-index" property from the example nodes.
>>>> Furthermore and example for the MPC5121 has been added.
>>>>
>>>> Signed-off-by: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
>>> Thanks Wolfgang. =A0Comments below.
>>>
>>>> ---
>>>> =A0Documentation/powerpc/dts-bindings/fsl/i2c.txt | =A0 30 +++++++=
++++++++++++----
>>>> =A01 files changed, 24 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/powerpc/dts-bindings/fsl/i2c.txt b/Docu=
mentation/powerpc/dts-bindings/fsl/i2c.txt
>>>> index b6d2e21..2f62dae 100644
>>>> --- a/Documentation/powerpc/dts-bindings/fsl/i2c.txt
>>>> +++ b/Documentation/powerpc/dts-bindings/fsl/i2c.txt
>>>> @@ -9,8 +9,9 @@ Recommended properties :
>>>>
>>>> =A0- compatible : compatibility list with 2 entries, the first sho=
uld
>>>> =A0 =A0be "fsl,CHIP-i2c" where CHIP is the name of a compatible pr=
ocessor,
>>>> - =A0 e.g. mpc8313, mpc8543, mpc8544, mpc5200 or mpc5200b. The sec=
ond one
>>>> - =A0 should be "fsl-i2c".
>>>> + =A0 e.g. mpc8313, mpc8543, mpc8544, mpc5121, mpc5200 or mpc5200b=
=2E The
>>>> + =A0 second one should be "fsl-i2c". For the mpc5121, an addition=
al node
>>>> + =A0 "fsl,mpc5121-i2c-ctrl" is required as shown in the example b=
elow.
>>> While you're editing this line; drop the requirement for the second
>>> value to be 'fsl-i2c'. =A0We don't use it anymore, and only preserv=
e it
>>> for backwards compatibility with old trees.
>>
>> OK.
>>
>>>> =A0- interrupts : <a b> where a is the interrupt number and b is a
>>>> =A0 =A0field that represents an encoding of the sense and level
>>>> =A0 =A0information for the interrupt. =A0This should be encoded ba=
sed on
>>>> @@ -20,29 +21,46 @@ Recommended properties :
>>>> =A0 =A0services interrupts for this device.
>>>> =A0- fsl,preserve-clocking : boolean; if defined, the clock settin=
gs
>>>> =A0 =A0from the bootloader are preserved (not touched).
>>>> - - clock-frequency : desired I2C bus clock frequency in Hz.
>>>> + - clock-frequency : desired I2C bus clock frequency in Hz. =A0If=
 this
>>>> + =A0 property and "fsl,preserve-clocking" is not defined, a safe =
fixed
>>>> + =A0 clock divider value is used (resulting in a small clock freq=
uency).
>>> Nah, leave this as is. =A0Don't make it sound like omitting both
>>> properties is a valid option. =A0The driver may (and should!) handl=
e the
>>> situation gracefully, but that fact does not need to be documented.
>>
>> The safe value is not a good choice, indeed. Then it will also chang=
e
>> MPC_I2C_CLOCK_SAFE to MPC_I2C_CLOCK_LEGACY in i2c-mpc.c.
>>
>> I will also fix the other issues you commented on.
>
> And I will also remove the "device_type" line from:
>
> =A0-------------
> =A0Required properties :
>
> =A0- device_type : Should be "i2c"
> =A0- reg : Offset and length of the register set for the device

Yes, please.

Hmmm.  compatible should also be in the 'required properties' section.

Thanks,
g.
