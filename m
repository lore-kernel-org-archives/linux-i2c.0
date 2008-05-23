From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 6/6] RTC: Trivially probe for an M41T80 (#2)
Date: Thu, 22 May 2008 20:07:06 -0700
Message-ID: <200805222007.07146.david-b@pacbell.net>
References: <Pine.LNX.4.55.0805130303430.535@cliff.in.clinika.pl> <20080513142829.2d737424@hyperion.delvare> <Pine.LNX.4.55.0805131759580.7267@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <Pine.LNX.4.55.0805131759580.7267@cliff.in.clinika.pl>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, Alessandro Zummo <a.zummo@towertech.it>, Andrew Morton <akpm@linux-foundation.org>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, David Woodhouse <dwmw2@infradead.org>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, rtc-linux@googlegroups.com, i2c@lm-sensors.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 13 May 2008, Maciej W. Rozycki wrote:
> Then I am not sure how i2c_new_probed_device() could be used for a
> baseboard device. =A0With an option card bearing an I2C adapter it ca=
n be
> done at the time the card, including the adapter, is initialized. =A0=
With a
> baseboard adapter it really begs to be in board initialization. =A0

One idiom to consider is callbacks (or notifications) when the
relevant i2c_adapter is registered.

Some of the GPIO drivers do that, so that they can hook up the
relevant devices or options.  Example, when an pcf8574 expander
is used to drive LEDs, the "this chip got registered" callback
can register the relevant "leds-gpio" platform device.  Or when
it's used to switch power to other devices, sometimes they must
defer registration till then too (power them up first, *then* it
makes sense to register them).

This could handle that "board has this I2C RTC -or- that one"
case pretty cleanly; but then, so would having a "probe first"
flag that's specific to the i2c_board_info.  (So long as the
probe logic could distinguish the devices... which will not in
the most general case work from i2c-core code.)

- Dave
