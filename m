From: Wojciech Matys <mcom-05MzZNw9fWQ@public.gmane.org>
Subject: i2c-ipmi
Date: Sat, 16 Aug 2008 18:23:21 +0200
Message-ID: <48A6FEF9.3070309@koba.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I have intel mainboard S5000PAL and Debian etch installed. I was trying
to get to work thermal sensors.  sensors-detect  says that I  need i2c-ipmi
and bmcsensors (ipmisensors). I found that there is patch for kernel on
website:

http://bmcsensors-26.sourceforge.net/

but patching failing no matter which version of patch I use:
 
server:/usr/src/linux# patch -p1 < ../ipmisensors-20060805-0622.diff
patching file drivers/char/ipmi/ipmi_msghandler.c
Hunk #1 succeeded at 1951 (offset 207 lines).
Hunk #2 succeeded at 4203 (offset 372 lines).
patching file drivers/hwmon/Kconfig
Hunk #1 succeeded at 333 with fuzz 2 (offset 153 lines).
patching file drivers/hwmon/Makefile
Hunk #1 FAILED at 26.
1 out of 1 hunk FAILED -- saving rejects to file drivers/hwmon/Makefile.rej
patching file drivers/hwmon/ipmisensors.c
patching file drivers/hwmon/ipmisensors.h
patching file include/linux/ipmi.h
Hunk #1 succeeded at 300 (offset 16 lines).
patching file include/linux/ipmi_msgdefs.h
Hunk #1 succeeded at 45 with fuzz 2.
Hunk #2 succeeded at 58 (offset 2 lines).
Hunk #3 FAILED at 81.
1 out of 3 hunks FAILED -- saving rejects to file
include/linux/ipmi_msgdefs.h.rej

------------------------------------------------------------------------------------

server:/usr/src/linux# patch -p1 < ../ipmisensors-20070630-1330.diff
patching file drivers/char/ipmi/ipmi_msghandler.c
Hunk #1 succeeded at 1951 (offset -2 lines).
Hunk #2 succeeded at 4210 (offset -4 lines).
patching file drivers/hwmon/Kconfig
Hunk #1 succeeded at 312 (offset 72 lines).
patching file drivers/hwmon/Makefile
Hunk #1 FAILED at 32.
1 out of 1 hunk FAILED -- saving rejects to file drivers/hwmon/Makefile.rej
patching file drivers/hwmon/ipmisensors.c
patching file drivers/hwmon/ipmisensors.h
patching file include/linux/ipmi.h
patching file include/linux/ipmi_msgdefs.h

---------------------------------------------------------------------------------------------

I've tried it with debian's  linux-source-2.6.24 and linux-source-2.6.18
and with
vanilla linux-source-2.6.25 as well. Is there any solution to get to
work sensors
on that mainboard?

server:/usr/src# sensors -v
sensors version 2.10.1 with libsensors version 2.10.1

-- 
mcom


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
