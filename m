From: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] [POWERPC] Add i2c pins to dts and board setup
Date: Wed, 21 May 2008 18:17:06 +0200
Message-ID: <48344B02.7070308@scram.de>
References: <4833FA0C.5090800@scram.de> <20080521151003.GA13858@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935853AbYEUQRc@vger.kernel.org>
In-Reply-To: <20080521151003.GA13858@ld0162-tx32.am.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel, Linux" <linux-kernel@vger.kernel.org>, Kumar Gala <galak@kernel.crashing.org>, Linux I2C <i2c@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-i2c@vger.kernel.org

Hi Scott,

>> +   - linux,i2c-index : Can be used to hard code an i2c bus number.
>> +   - linux,i2c-class : Can be used to override the i2c class.
>
> Why do we need this?

There are still a bunch of i2c drivers using the old API (mainly v4l and dvb stuff)
which are slowly being converted by their subsystem maintainers, though.

> It'd be better to just convert any needed old-style drivers than add this
> to the device tree.

Sure. That's why the parameters are only optional. Once all i2c drivers are
converted, these parameters won't be used anymore. Maybe they should be marked
as deprecated.

>> +   - bus-frequency : Can be used to set the i2c bus frequency. If unspecified,
>> +     a default frequency of 60kHz is being used.
> 
> clock-frequency is the standard name for such things.

I was just confused by the fact that unlike a serial port, i2c is a bus itself.

Thanks,
Jochen
