From: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Subject: Re: I2C and devicetrees
Date: Fri, 01 Mar 2013 14:00:39 -1000
Message-ID: <51314127.2090304@firmworks.com>
References: <201212052336.24233.PeterHuewe@gmx.de> <CAOesGMhUVwB4+kuCA8hSmfhoVzkznNbjj6hjngDMaQkB83WqjQ@mail.gmail.com> <50C79DE8.2090201@wwwdotorg.org> <20121214203845.5D7ED3E0BDD@localhost> <511A6F26.20801@keymile.com> <CAAXf6LXW7RXUgqOSwKKDfByK24qNdRGHgkEhN7eVN=BQKbAZmg@mail.gmail.com> <5131220E.70407@firmworks.com> <51313726.6010204@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51313726.6010204-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Thomas De Schampheleire <patrickdepinguin+devicetree-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Peter Huewe <PeterHuewe-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 3/1/2013 1:17 PM, Stephen Warren wrote:
> On 03/01/2013 02:47 PM, Mitch Bradley wrote:
>> On 3/1/2013 9:56 AM, Thomas De Schampheleire wrote:
>>> Hi,
>>>
>>> On Tue, Feb 12, 2013 at 5:34 PM, Gerlando Falauto
>>> <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org> wrote:
>>>> Hi everyone,
>>>>
>>>> I have a similar question.
>>>> I'd like to "name" i2c devices so that a userspace application can somehow
>>>> identify those devices with the same function across different boards (which
>>>> may have different addresses or be connected to a different i2c bus, or be a
>>>> physically different chip).
>>>>
>>>> For instance "hwmon" devices get instantiated within sysfs under
>>>> /sys/class/hwmon/hwmonX
>>>>
>>>> # cat /sys/class/hwmon/hwmon0/device/name
>>>> lm75
>>>>
>>>> which I would like to be identified by the name "switch" (as in "switch
>>>> temperature"). I was thinking about instantiating it as something like
>>>> "lm75:switch" within i2c_board_info.type. For device-tree-less
>>>> architectures, a trivial change within i2c_match_id() so to ignore the part
>>>> following ":" seems to do the trick. Don't know about devicetree but I guess
>>>> a similar approach could be imagined.
>>>>
>>>> Another example would be given by EEPROMs: all boards are equipped with an
>>>> EEPROM containing inventory management, which I would like to identify as
>>>> "ivm". So something like "24c08:ivm".
>>>> After all, I'd like to be able to achive something like "named MTD
>>>> partitions" which you can identify by looking at "/proc/mtd".
>>>>
>>>> Maybe some other symbol could be used instead of ":", but anyhow, does the
>>>> above make any sense at all to you?
>>>>
>>>
>>> I have exactly the same request: I would like to put logical names in
>>> the device tree for various devices (i2c, spi, ...) which are in some
>>> way easily retrievable from a userspace application.
>>> The purpose seems to be the same as Gerlando's: different boards have
>>> different physical configuration but logically each has the same set
>>> of devices.
>>>
>>> How can one achieve that?
>>
>> Unless I am misunderstanding your request, that is what the /aliases
>> node is intended for.  Each property name in /aliases is a logical name,
>> and the value refers to the corresponding device node.
>>
>> I'm not sure about all the different ways that Linux exports information
>> in /aliases to userspace.  I do know that, in the case of some i2c,
>> serial, and ethernet devices, aliases like:
>>
>>   serial1 = &uart1;
>>
>> cause the assignment of small-integer unit numbers to specific device
>> instances.  That "serial<N>" pattern is somewhat of a Linux-specific
>> special case.  In general, the Open Firmware standard just says that
>> /aliases maps logical names to longer strings  representing fuller
>> pathnames, without imposing any structure (e.g. serial<N>) on the
>> logical names.
> 
> I'm not sure if aliases solve all scenarios.
> 
> If you have a DT node that's a single UART, then aliases work OK, as in
> your example above.
> 
> However, what if you have a single thermal sensor ID that has 4
> channels. There will be a single DT node that represents this device.
> However, the 4 channels could be hooked up arbitrarily on a board, and
> you really want to name the individual channels, not just the IC that
> contains those channels. Can you do that; will the following work?
> 
> /aliases {
>     cpu-temp = <&i2cdev 1>; # 1 is the channel ID on the chip
>     ambient-temp = <&i2cdev 3>;
> };

For that case, I would put child nodes underneath the 4-channel-sensor
node, e.g. cpu-temp@1, ambient-temp@3.  Those multiple channels fit
cleanly within the device tree's "child address space" concept.

I suppose that the driver for the sensor node would enumerate its
children and export their information via /sys.

I know that it's tempting to truncate the device tree too soon, as I
have fallen prey to that temptation many times.  For me, the temptation
usually happens for "endpoints" that don't need separate drivers, or for
which the endpoint-driver code is "buried" inside the parent driver.
But in the end, it has usually worked out better to fill out the leaves
of the tree, especially for on-board devices.

> 
> All the code I recall so far that handles aliases searches for alias
> entries with a specific prefix for the name (e.g. "i2c*", and then finds
> "i2c0", "i2c1", etc.). In order to support the syntax above, you'd have
> to instead search for all aliases that include the phandle of the node
> in question. I guess it's easy enough to implement that, but it's quite
> a different way of thinking about aliases, I think.
> 
