From: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: I2C adapters protocol deviation
Date: Mon, 07 Apr 2014 09:49:47 +0200
Message-ID: <5342589B.5000600@free-electrons.com>
References: <20140403145528.GA6199@lukather> <533D7E81.4050900@redhat.com> <20140404122632.GA3686@katana> <53415E50.9000402@redhat.com> <20140406153728.GB2609@katana> <53418C61.6020604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53418C61.6020604-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, boris-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 06/04/2014 19:18, Hans de Goede wrote:
> Hi,
>
> On 04/06/2014 05:37 PM, Wolfram Sang wrote:
>> On Sun, Apr 06, 2014 at 04:01:52PM +0200, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 04/04/2014 02:26 PM, Wolfram Sang wrote:
>>>>> So what we really have is a single slave i2c host sort of. At least
>>>>> we could model it like that. The host could be told which address to
>>>>> listen to (and which single i2c write to do to init the pmic) through
>>>>> devicetree and then all the differences would be hidden in the host
>>>>> driver, ie we would check the slave-address and if it is not the single
>>>>> one we support, we just return the appropriate error for a device not
>>>>> acking, and everything should work as a regular i2c host which
>>>>> only supports i2c_smbus_read_byte and i2c_smbus_write_byte.
>>>> I'd think we need a new message flag like I2C_M_PUSHPULL which says that
>>>> this message has only the direction bit instead of the address and needs
>>>> a parity bit afterwards. In addition to that, we need a new
>>>> functionality flag I2C_FUNC_PUSHPULL which means the host driver can
>>>> handle those messages. So, the PMIC driver could query support for
>>>> I2C_FUNC_SMBUS_BYTE | I2C_FUNC_PUSHPULL and if successful send messages
>>>> using smbus functions with the new flag set.
>>> Thanks for the input this sounds good, I guess we'll give this a shot
>>> when we get around to coding up support for the p2wi block in the A31.

Hans, I started to work on the p2wi driver, but let me know if you
already have a working driver (I'll either rebase my work on yours or
let you finish your implementation).

>> On a second thought, maybe more granularity is better. Like using
>> I2C_M_DROP_ADDRESS and I2C_M_ADD_PARITY and then make
>> I2C_CLIENT_PUSHPULL involve I2C_M_DROP_ADDRESS | I2C_M_ADD_PARITY.

For the moment I only make use of the I2C_CLIENT_PUSHPULL and
I2C_M_PUSHPULL flags, but I can add those flags (and check them in the
smbus_xfer callback) if you think this is relevant.

> Hmm, I'm not completely sold on the whole idea of having special
> flags, esp. since it seems that ie the AXP221 may operate in normal
> i2c mode in some designs too. So ideally we would just hide from
> clients that this is something else then plain i2c. So that we can have
> an axp221 driver which is not even aware about this weird i2c-variant and
> will just work independent on how the axp221 is hooked up.

Hans, can't we use the same PMIC driver but with different i2c flags for
the p2wi case.

IMHO, the real question here is: do we want to support the p2wi protocol
on other i2c bus implementations (like the i2c bitbanging driver) ?
If this is the case we definitely need those specific flags.

> Likewise it would be useful to have the i2cdump utility just work, etc.
>
> So maybe a flag which is a hint that this is special on the controller,
> but I don't think we should be checking for special flags in the messages
> on the controller side. Basically the whole p2wi allows reading / writing
> byte registers, so I2C_FUNC_SMBUS_BYTE is a 1:1 mapping of the functionality,
> as for the address, we can just check it is the one address used to do
> the initial setup, and if it is not then just return an error.
>
>>>> Not sure about the I2C-to-PushPull switch: Is it 100% host configuration
>>>> or does it also depend on the one slave attached? 
>>> The datasheet we've suggests that it actually influences the one slave
>>> attached. Note that u-boot on this machines will likely already have made
>>> the switch, but I guess we don't want to count on that.
>> Can we detect if this switching was already made?
> I don't think we can. But I think doing the switch a second time is ok /
> does not result in an error.

AFAICT you cannot detect if the i2c to p2wi switch has already taken
place, and re launching the switch process might have unexpected effects:
let's say the i2c address you're trying to access maps to a valid PMIC
register, as the address should be dropped in p2wi mode, you might write
an erroneous value to this register.


Best Regards,

Boris
> Regards,
>
> Hans
