From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Drop I2C_CLASS_ALL
Date: Fri, 31 Oct 2008 09:47:38 +0100
Message-ID: <20081031094738.07f41a19@hyperion.delvare>
References: <20081030153120.1c1f3476@hyperion.delvare>
	<0F1B54C89D5F954D8535DB252AF412FA02F64B5D@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA02F64B5D-SGdA1W8gREmuVPpjEGsWsTcYPEmu4y7e@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sonic,

On Fri, 31 Oct 2008 10:51:19 +0800, Zhang, Sonic wrote:
> If only I2C_CLASS_HWMON and  I2C_CLASS_SPD must be probed, why other
> classes are still list in the head files?

We are in a transition phase. We must wait for all users of a class
flag to go away before we can drop the corresponding flag. You are
right though that some flags could be removed already. For example, as
far as I can see there are no users of I2C_CLASS_CAM_ANALOG nor
I2C_CLASS_SOUND left, so we could drop these 2 flags now. Additionally,
class I2C_CLASS_CAM_DIGITAL is set by a number of bus drivers but no
chip driver checks for that flag, so it's probably safe to drop it as
well.

For I2C_CLASS_TV_ANALOG and I2C_CLASS_TV_DIGITAL, it will take some
more time, as there are a number of old drivers which do actually rely
on probing and which may be a little hard to convert. But anyway their
usage should be limited to a few drivers/media/video drivers.

In the long run, Only I2C_CLASS_HWMON, I2C_CLASS_DDC and I2C_CLASS_SPD
should be widely used.

-- 
Jean Delvare
