From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] ALS: TSL2550 driver move from i2c/chips
Date: Sat, 10 Oct 2009 18:33:47 +0200
Message-ID: <20091010183347.52b043ed@hyperion.delvare>
References: <4ACF4AC6.7070802@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4ACF4AC6.7070802-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, "Michele De Candia (VT)" <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jonathan,

On Fri, 09 Oct 2009 15:37:58 +0100, Jonathan Cameron wrote:
> 
> Signed-off-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> 
> ---
> Minimal changes made. Untested due to lack of hardware.
> All comments welcome.

Thanks for working on this. I can do any amount of testing you want, as
I have received a TSL2550 evaluation module from TAOS.

> illuminance is already documented as part of the class.
> operating mode and power state are both as per the original
> driver. I can't find any documentation for them, but if people
> want it I can probably figure out what they are from
> the data sheet.

The operating mode selects the measurable range. Standard range is from
0 to 1846 lux, extended range is from 0 to 9230 lux, with a resolution
divided by 5. Extended mode is also 5 times faster.

What do we want to do with this? I am open to suggestions. There are
several possibilities. The operating mode could be provided as platform
data and stay internal to the driver. Or we can leave is visible to
user-space, in which case I'd recommend that we do so in terms of
"range" rather than "mode", so that other drivers can use the same
convention, whatever it becomes. For example, one would write the range
of values he/she wants to be able to measure and the driver would put
the device in the most appropriate mode.

Alternatively (or additionally), we could implement an automatic mode
which would change the mode dynamically based on the previous
measurement. I've done that for one hwmon driver (for fan speed
measurement) and it works very well, if implemented properly.

> Might be worth dropping the power state control and moving
> over to runtime pm but that is definitely the topic for another
> patch.

Power state control is already integrated into the PM framework
(suspend and resume, is there more?) The sysfs entry is to allow a
manual control on top of it. I don't much like having a custom sysfs
entry for this, but I don't know if there is a standard way to achieve
the same?

> Does anyone want a patch without using Git's move functionality?

Yes please!

> Have copied all the users Jean knows about, but please cc any other
> users as this does involve a change to the userspace interface.
> 
> Applies on 2.6.31-rc3 with the ALS patches
> http://patchwork.kernel.org/patch/49153/
> 
>  drivers/als/Kconfig                  |   14 ++++++
>  drivers/als/Makefile                 |    2 +
>  drivers/{i2c/chips => als}/tsl2550.c |   73 ++++++++++++++++++++++++++++++---
>  3 files changed, 82 insertions(+), 7 deletions(-)

-- 
Jean Delvare
