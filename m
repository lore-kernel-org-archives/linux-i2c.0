From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC] Add i2c pins to dts and board setup
Date: Wed, 21 May 2008 10:10:03 -0500
Message-ID: <20080521151003.GA13858@ld0162-tx32.am.freescale.net>
References: <4833FA0C.5090800@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934746AbYEUPKv@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4833FA0C.5090800@scram.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jochen Friedrich <jochen@scram.de>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel, Linux" <linux-kernel@vger.kernel.org>, Kumar Gala <galak@kernel.crashing.org>, Linux I2C <i2c@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 21, 2008 at 12:31:40PM +0200, Jochen Friedrich wrote:
> +   - linux,i2c-index : Can be used to hard code an i2c bus nummer.

s/nummer/number/

Why do we need this?

> +   - linux,i2c-class : Can be used to override the i2c class. The class is used
> +     by old style i2c device drivers to find a bus in a specific context like
> +     system management, video or sound. By default, I2C_CLASS_HWMON (1) is
> +     being used. The definition of the classes can be found in
> +     include/i2c/i2c.h

It'd be better to just convert any needed old-style drivers than add this
to the device tree.

> +   - bus-frequency : Can be used to set the i2c bus frequency. If unspecified,
> +     a default frequency of 60kHz is being used.

clock-frequency is the standard name for such things.

-Scott
