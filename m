From: "Andrej *" <union.kjesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i2c isa and 2.6.24
Date: Fri, 8 Feb 2008 12:06:09 +0100
Message-ID: <7ed6758e0802080306v4ca26537ob578de47a03f8035@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
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

Hello

I have ABIT bx6 v2 MB, sensor chip w83781d (isa bus).

I have these modules :
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_CHARDEV=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_LM90=m

which are modprobe-d without problem.

Emerged lm_sensors 2.10.4 (also tried lm sensors 3.0.1), but all I get
is temperature from nvidia card and NOT from MB.
Nvidia is also only hwmon device in sys/clas/... hwmon0.

Code:

lm99-i2c-2-4c
Adapter: NVIDIA i2c adapter
G/C Temp:    +37.0 C  (low  =  +0.0 C, high = +90.0 C)
                      (crit = +127.0 C, hyst = +117.0 C)
GPU Temp:    +49.6 C  (low  =  +5.0 C, high = +105.0 C)
                      (crit = +143.0 C, hyst = +133.0 C)


Sensors-detects shows right module for MB, but there ins't any
temperature readings.

Code:

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   Success!
    (confidence 8, driver `w83781d')
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No


Before 2.6.24 I had also i2c_isa module, but there isn't any in latest
kernel, and I think that lack ot it is causing problem.

How can I get temperature, voltage and fan readings for MB with 2.6.24 kernel?

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
