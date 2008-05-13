From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 6/6] RTC: Trivially probe for an M41T80 (#2)
Date: Tue, 13 May 2008 14:28:29 +0200
Message-ID: <20080513142829.2d737424@hyperion.delvare>
References: <Pine.LNX.4.55.0805130303430.535@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <Pine.LNX.4.55.0805130303430.535@cliff.in.clinika.pl>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Andrew Morton <akpm@linux-foundation.org>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, David Woodhouse <dwmw2@infradead.org>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, rtc-linux@googlegroups.com, i2c@lm-sensors.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>
List-Id: linux-i2c@vger.kernel.org

Hi Maciej,

On Tue, 13 May 2008 04:27:42 +0100 (BST), Maciej W. Rozycki wrote:
>  When probing the driver try to access the device with a read to one of
> its registers and exit silently if the read fails.  This is so that boards
> may register this device unconditionally and do not trigger error messages
> at the bootstrap, where there is no other way to determine if an
> M41T80-class RTC is actually there.

I don't like this. You are only supposed to declare in platform init
structures, I2C devices that you are sure are present. Relying on the
driver to not attach to the device if it is in fact not there sounds
wrong, because the I2C device will still be declared, so it's
confusing. Also, you consider that a driver silently failing to attach
is a feature, and in your specific case it may be, but for other users
it will be an annoyance: in the general case you want errors to be
clearly reported.

If you are not sure that an I2C device will be present, then you should
not declare it as part of the I2C board info, but register it later
with i2c_new_probed_device(). If this isn't possible or not convenient,
then I'd rather add a probing variant of i2c_register_board_info() (or
maybe a new flag in i2c_board_info.flags) than hack all i2c drivers to
silent failures when devices are missing.

-- 
Jean Delvare
