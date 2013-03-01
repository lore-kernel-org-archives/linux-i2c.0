From: Thomas De Schampheleire <patrickdepinguin+linuxi2c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: I2C and devicetrees
Date: Fri, 1 Mar 2013 16:33:06 +0100
Message-ID: <CAAXf6LXGPEeCaxST6xz8YmzTobesXqOw-BKritG61rU0mv6Srw@mail.gmail.com>
References: <201212052336.24233.PeterHuewe@gmx.de>
	<CAOesGMhUVwB4+kuCA8hSmfhoVzkznNbjj6hjngDMaQkB83WqjQ@mail.gmail.com>
	<50C79DE8.2090201@wwwdotorg.org>
	<20121214203845.5D7ED3E0BDD@localhost>
	<511A6F26.20801@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <511A6F26.20801-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: Grant Likely <public-grant.likely-s3s/WqlpOiPyB63q8FvJNQ-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>, Stephen Warren <public-swarren-3lzwWm7+Weoh9ZMKESR00Q-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>, Olof Johansson <public-olof-nZhT3qVonbNeoWH0uzbU5w-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>, Peter Huewe <public-PeterHuewe-Mmb7MZpHnFY-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Tue, Feb 12, 2013 at 5:34 PM, Gerlando Falauto
<gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org> wrote:
> Hi everyone,
>
> I have a similar question.
> I'd like to "name" i2c devices so that a userspace application can somehow
> identify those devices with the same function across different boards (which
> may have different addresses or be connected to a different i2c bus, or be a
> physically different chip).
>
> For instance "hwmon" devices get instantiated within sysfs under
> /sys/class/hwmon/hwmonX
>
> # cat /sys/class/hwmon/hwmon0/device/name
> lm75
>
> which I would like to be identified by the name "switch" (as in "switch
> temperature"). I was thinking about instantiating it as something like
> "lm75:switch" within i2c_board_info.type. For device-tree-less
> architectures, a trivial change within i2c_match_id() so to ignore the part
> following ":" seems to do the trick. Don't know about devicetree but I guess
> a similar approach could be imagined.
>
> Another example would be given by EEPROMs: all boards are equipped with an
> EEPROM containing inventory management, which I would like to identify as
> "ivm". So something like "24c08:ivm".
> After all, I'd like to be able to achive something like "named MTD
> partitions" which you can identify by looking at "/proc/mtd".
>
> Maybe some other symbol could be used instead of ":", but anyhow, does the
> above make any sense at all to you?

I have exactly the same request: I would like to put logical names in
the device tree for various devices (i2c, spi, ...) which are in some
way easily retrievable from a userspace application.
The purpose seems to be the same as Gerlando's: different boards have
different physical configuration but logically each has the same set
of devices.

How can we achieve that?

Thanks,
Thomas
