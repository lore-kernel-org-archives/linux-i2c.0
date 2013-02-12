From: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: I2C and devicetrees
Date: Tue, 12 Feb 2013 17:34:46 +0100
Message-ID: <511A6F26.20801@keymile.com>
References: <201212052336.24233.PeterHuewe@gmx.de> <CAOesGMhUVwB4+kuCA8hSmfhoVzkznNbjj6hjngDMaQkB83WqjQ@mail.gmail.com> <50C79DE8.2090201@wwwdotorg.org>
	 <20121214203845.5D7ED3E0BDD@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121214203845.5D7ED3E0BDD@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <public-grant.likely-s3s/WqlpOiPyB63q8FvJNQ-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>
Cc: Stephen Warren <public-swarren-3lzwWm7+Weoh9ZMKESR00Q-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>, Olof Johansson <public-olof-nZhT3qVonbNeoWH0uzbU5w-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>, Peter Huewe <public-PeterHuewe-Mmb7MZpHnFY-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi everyone,

I have a similar question.
I'd like to "name" i2c devices so that a userspace application can 
somehow identify those devices with the same function across different 
boards (which may have different addresses or be connected to a 
different i2c bus, or be a physically different chip).

For instance "hwmon" devices get instantiated within sysfs under
/sys/class/hwmon/hwmonX

# cat /sys/class/hwmon/hwmon0/device/name
lm75

which I would like to be identified by the name "switch" (as in "switch 
temperature"). I was thinking about instantiating it as something like 
"lm75:switch" within i2c_board_info.type. For device-tree-less 
architectures, a trivial change within i2c_match_id() so to ignore the 
part following ":" seems to do the trick. Don't know about devicetree 
but I guess a similar approach could be imagined.

Another example would be given by EEPROMs: all boards are equipped with 
an EEPROM containing inventory management, which I would like to 
identify as "ivm". So something like "24c08:ivm".
After all, I'd like to be able to achive something like "named MTD 
partitions" which you can identify by looking at "/proc/mtd".

Maybe some other symbol could be used instead of ":", but anyhow, does 
the above make any sense at all to you?

Thanks a lot!
Gerlando

On 12/14/2012 09:38 PM, Grant Likely wrote:
> On Tue, 11 Dec 2012 13:56:08 -0700, Stephen Warren<swarren-3lzwWm7+Weoh9ZMKESR00Q-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>  wrote:
>> On 12/11/2012 01:21 PM, Olof Johansson wrote:
>>> [+devicetree-discuss]
>>>
>>> On Wed, Dec 5, 2012 at 2:36 PM, Peter Huewe<PeterHuewe-Mmb7MZpHnFY-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>  wrote:
>>>> Hi,
>>>>
>>>> I have a short question about the relations between i2c and devicetrees.
>>>>
>>>> I was wondering
>>>> is the device part of the compatible string of a (trivial) i2c device
>>>> instanciated via devicetree _always_ identical to name in i2c_client.name ?
>>>> Or can it be somehow different?
>>>
>>> It can be different, but the driver will then need to add a OF table
>>> that matches the probing. By default the i2c/dt core code will strip
>>> off the vendor prefix (before ",") and try probing with the rest of
>>> the device name. If that doesn't match the client name, that is when
>>> you need the additional table.
>>
>> While relying on the prefix stripping works, I think I recall Grant
>> mentioning that people shouldn't rely on it - namely that any I2C device
>> that gets instantiated from DT should contain the OF match table
>> explicitly. I CC'd Grant in case I'm mis-quoting him.
>
> I'm not quite that strict about it. The behaviour described above is
> based merely on a heuristic but for a lot of drivers that don't do
> anything special it works just fine. The moment you need to identify a
> specific device it becomes better to use an of match table.
>
> g.
>
