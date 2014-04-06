From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: I2C adapters protocol deviation
Date: Sun, 06 Apr 2014 16:01:52 +0200
Message-ID: <53415E50.9000402@redhat.com>
References: <20140403145528.GA6199@lukather> <533D7E81.4050900@redhat.com> <20140404122632.GA3686@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140404122632.GA3686@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, boris-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 04/04/2014 02:26 PM, Wolfram Sang wrote:
> 
>> So what we really have is a single slave i2c host sort of. At least
>> we could model it like that. The host could be told which address to
>> listen to (and which single i2c write to do to init the pmic) through
>> devicetree and then all the differences would be hidden in the host
>> driver, ie we would check the slave-address and if it is not the single
>> one we support, we just return the appropriate error for a device not
>> acking, and everything should work as a regular i2c host which
>> only supports i2c_smbus_read_byte and i2c_smbus_write_byte.
> 
> I'd think we need a new message flag like I2C_M_PUSHPULL which says that
> this message has only the direction bit instead of the address and needs
> a parity bit afterwards. In addition to that, we need a new
> functionality flag I2C_FUNC_PUSHPULL which means the host driver can
> handle those messages. So, the PMIC driver could query support for
> I2C_FUNC_SMBUS_BYTE | I2C_FUNC_PUSHPULL and if successful send messages
> using smbus functions with the new flag set.

Thanks for the input this sounds good, I guess we'll give this a shot
when we get around to coding up support for the p2wi block in the A31.

> Not sure about the I2C-to-PushPull switch: Is it 100% host configuration
> or does it also depend on the one slave attached? 

The datasheet we've suggests that it actually influences the one slave
attached. Note that u-boot on this machines will likely already have made
the switch, but I guess we don't want to count on that.

> Are there some datasheets available?

The AXP221 is documented here:
http://linux-sunxi.org/AXP221
This is translated by one of our community members from a Chinese datasheet.

The P2WI interface is (somewhat) documented in the A31 datasheet, but we cannot
share that in public.

Regards,

Hans
