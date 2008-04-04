From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c-tools 3.0.1 has been released
Date: Fri, 4 Apr 2008 19:51:50 +0200
Message-ID: <20080404195150.5a81a5ea@hyperion.delvare>
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
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

I just released i2c-tools version 3.0.1. The most important changes
since version 3.0.0 are:

* A new helper script for use with the i2c-stub kernel driver is
  included. It is named i2c-stub-from-dump and is installed by default.
  It can be used to feed i2c-stub from a chip register dump previously
  obtained using i2cdump. This can be very useful when working on a
  driver for an I2C/SMBus device you don't own.

* A new option to i2cdump, to let the user specify the register range
  to dump.

* Improvements to decode-dimms, contributed by Trent Piepho. The
  decoding of DDR2 SDRAM timings is complete now, and SPD data can be
  read from hexdumps.

* Minor improvements to decode-vaio, in particular support for recent
  kernels which hide some of the Vaio EEPROM data to non-root users.

For a more detailed listing of changed, see the CHANGES document in the
i2c-tools package.

Note to packagers: perl scripts have been renamed to omit the
trailing .pl (for example decode-dimms.pl is now named decode-dimms). I
think it's more user-friendly that way.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
