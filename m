From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: i2c-tools: Discussion points about future library
Date: Wed, 4 Apr 2012 18:41:58 +0100
Message-ID: <20120404174158.GA19773@sirena.org.uk>
References: <20120404160113.2295c636@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120404160113.2295c636-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Aurelien Jarno <aurelien-rXXEIb44qovR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 04, 2012 at 04:01:13PM +0200, Jean Delvare wrote:

> First point is the name of the library. My original intent was to name
> it libi2c-dev, because the library is essentially a front-end to the
> i2c-dev kernel driver, and also because this is what Debian named their
> package currently containing the (i2c-tools flavor of)
> <linux/i2c-dev.h>. However Aur??lien Jarno suggested that libi2c would
> be just as fine, and easier/shorter. I am mostly convinced by now. I am
> curious if anyone wants to express an opinion on the matter?

FWIW the Debian convention is that the source package of a library is
called libfoo building packages libfoo-dev with the headers and .so
symlink to link against (or .a for a static library) and libfooN with
the runtime in it (where N is the soname).
