From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: I2C adapters protocol deviation
Date: Mon, 07 Apr 2014 14:07:27 +0200
Message-ID: <534294FF.1050802@redhat.com>
References: <20140403145528.GA6199@lukather> <533D7E81.4050900@redhat.com> <20140404122632.GA3686@katana> <53415E50.9000402@redhat.com> <20140406153728.GB2609@katana> <53418C61.6020604@redhat.com> <20140407081502.GC3926@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140407081502.GC3926@lukather>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, boris-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 04/07/2014 10:15 AM, Maxime Ripard wrote:
> On Sun, Apr 06, 2014 at 07:18:25PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 04/06/2014 05:37 PM, Wolfram Sang wrote:
>>> On Sun, Apr 06, 2014 at 04:01:52PM +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 04/04/2014 02:26 PM, Wolfram Sang wrote:
>>>>>
>>>>>> So what we really have is a single slave i2c host sort of. At least
>>>>>> we could model it like that. The host could be told which address to
>>>>>> listen to (and which single i2c write to do to init the pmic) through
>>>>>> devicetree and then all the differences would be hidden in the host
>>>>>> driver, ie we would check the slave-address and if it is not the single
>>>>>> one we support, we just return the appropriate error for a device not
>>>>>> acking, and everything should work as a regular i2c host which
>>>>>> only supports i2c_smbus_read_byte and i2c_smbus_write_byte.
>>>>>
>>>>> I'd think we need a new message flag like I2C_M_PUSHPULL which says that
>>>>> this message has only the direction bit instead of the address and needs
>>>>> a parity bit afterwards. In addition to that, we need a new
>>>>> functionality flag I2C_FUNC_PUSHPULL which means the host driver can
>>>>> handle those messages. So, the PMIC driver could query support for
>>>>> I2C_FUNC_SMBUS_BYTE | I2C_FUNC_PUSHPULL and if successful send messages
>>>>> using smbus functions with the new flag set.
>>>>
>>>> Thanks for the input this sounds good, I guess we'll give this a shot
>>>> when we get around to coding up support for the p2wi block in the A31.
>>>
>>> On a second thought, maybe more granularity is better. Like using
>>> I2C_M_DROP_ADDRESS and I2C_M_ADD_PARITY and then make
>>> I2C_CLIENT_PUSHPULL involve I2C_M_DROP_ADDRESS | I2C_M_ADD_PARITY.
>>
>> Hmm, I'm not completely sold on the whole idea of having special
>> flags, esp. since it seems that ie the AXP221 may operate in normal
>> i2c mode in some designs too. So ideally we would just hide from
>> clients that this is something else then plain i2c. So that we can have
>> an axp221 driver which is not even aware about this weird i2c-variant and
>> will just work independent on how the axp221 is hooked up.
> 
> I don't think we actually saw in real life an AXP221 connected only
> using i2c. I'd say we shouldn't worry too much about a theorical
> corner case that we never saw, until we actually see it.
> 
>> Likewise it would be useful to have the i2cdump utility just work, etc.
> 
> I'm not sure I want the i2c-tools to start poking around the PMIC.

Having i2cdump is very very useful in my experience with developing
i2c hwmon drivers.

> 
>> So maybe a flag which is a hint that this is special on the controller,
>> but I don't think we should be checking for special flags in the messages
>> on the controller side. Basically the whole p2wi allows reading / writing
>> byte registers, so I2C_FUNC_SMBUS_BYTE is a 1:1 mapping of the functionality,
>> as for the address, we can just check it is the one address used to do
>> the initial setup, and if it is not then just return an error.
> 
> Yes, we obviously have to check for the address in the xfer function.
> 
>>>>> Not sure about the I2C-to-PushPull switch: Is it 100% host configuration
>>>>> or does it also depend on the one slave attached? 
>>>>
>>>> The datasheet we've suggests that it actually influences the one slave
>>>> attached. Note that u-boot on this machines will likely already have made
>>>> the switch, but I guess we don't want to count on that.
>>>
>>> Can we detect if this switching was already made?
>>
>> I don't think we can. But I think doing the switch a second time is ok /
>> does not result in an error.
> 
> And it will probably mangle the PMIC configuration. I'm not very
> comfortable with that..

I think / expect that this is taken care of somehow at the hardware level.
IE if the SOC gets reset through the watchdog, the PMIC won't know this and
the bootloader will re-init the P2WI telling it to do the switch. So I think
that doing the switch twice will be harmless. Actually doing the switch twice
is exactly what my current u-boot code does more or less. For now we boot the
A31 using Allwinner's boot0 + boot1 bootloader which then chain-loads u-boot,
and boot0/boot1 already talk to the PMIC, so has already made the switch, and
my u-boot code switches it over again.

Regards,

Hans
