From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c-tools: Discussion points about future library
Date: Wed, 4 Apr 2012 16:01:13 +0200
Message-ID: <20120404160113.2295c636@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Aurelien Jarno <aurelien-rXXEIb44qovR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

There are two points which may need to be discussed concerning the
upcoming library in i2c-tools [1] [2].

[1] http://www.lm-sensors.org/wiki/I2CTools_4_Plan
[2] http://marc.info/?l=3Dlinux-i2c&m=3D133182689203486&w=3D2

=46irst point is the name of the library. My original intent was to nam=
e
it libi2c-dev, because the library is essentially a front-end to the
i2c-dev kernel driver, and also because this is what Debian named their
package currently containing the (i2c-tools flavor of)
<linux/i2c-dev.h>. However Aur=C3=A9lien Jarno suggested that libi2c wo=
uld
be just as fine, and easier/shorter. I am mostly convinced by now. I am
curious if anyone wants to express an opinion on the matter?

Second point is the creation of a header file to ease the migration of
tools from the old model (i2c-tools flavor of <linux/i2c-dev.h>) to the
new model (library with its header files + unchanged kernel headers).
Right now, the migration path looks like this:

+#include <sys/ioctl.h>
+#include <i2c/smbus.h>
 #include <linux/i2c-dev.h>

for SMBus tools, and this:

+#include <sys/ioctl.h>
+#include <linux/i2c.h>
 #include <linux/i2c-dev.h>
=20
for I2C tools. I am happy with this, but Aur=C3=A9lien insisted that it
would be more friendly if tools only needed to include one header file
in order to make use of the library. For this we would need to create
an extra header file only including the other header files. Something
like <i2c/i2c.h> containing:

#include <sys/ioctl.h>
#include <linux/i2c.h>
#include <linux/i2c-dev.h>
#include <i2c/smbus.h>

This would have the downside that tools end up (indirectly) including
header files they don't necessarily need. And migrating every tool is
still needed, as you would then still have to do:

-#include <linux/i2c-dev.h>
+#include <i2c/i2c.h>

I admit this is slightly easier than my initial plan, but the benefit
doesn't strike me as fundamental. Here again I would appreciate if
users of the i2c-dev driver could comment on this. I know that
libsensors (the only library I am intimately familiar with) does not
provide such an extra header file, but that's only one example so it
might not be relevant.

Thanks,
--=20
Jean Delvare
