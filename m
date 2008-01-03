From: "Jean Delvare" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-dev cross-compile error
Date: Thu, 03 Jan 2008 10:33:02 +0100
Message-ID: <9mPWYPe6.1199352781.3795110.khali@gcu-squad.org>
References: <1199291705.8789.9.camel@escher.metaverse>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1199291705.8789.9.camel-KVB57GCTUpPyvZzR7rY+dg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: formica-YbGCGrJzjEK4SyVuDWiTng@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Hi Roberto,

Le 2/1/2008, Roberto Marino a =E9crit:
>I've a problem with i2c-dev on arm.
>I'm trying to cross-compile i2c-dev example
>(Documentation/i2c/dev-interface) for arm passing these arguments to
>cross-compiler
>
>arm-linux-gcc-3.4.1 -I/usr/local/arm/3.4.1/arm-linux/include -O2
>prova_max1363.c -o prova_max1363
>
>The error is this (too long to paste completely):
>(...)
>-----------------------------
>
>This is the source, any idea? :
>
>#include <linux/i2c.h>
>#include <linux/i2c-dev.h>

You are not supposed to include i2c.h from user-space. You should only
include i2c-dev.h, and this should be the one that is shipped in the
i2c-tools [1] package, NOT the one in the kernel tree.

I know that this is error-prone (although it _is_ explained in the
document you mentioned) and that's one thing I intend to fix in the
course of year 2008.

[1] http://www.lm-sensors.org/wiki/I2CTools

>#include <stdio.h>
>#include <stdlib.h>
>#include <sys/types.h>
>#include <sys/stat.h>
>#include <fcntl.h>
>(...)

--
Jean Delvare
