From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH] I2C driver for IMX
Date: Fri, 14 Mar 2008 19:03:18 +0100
Message-ID: <20080314190318.732d84e2@hyperion.delvare>
References: <frbjjv$ndk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <frbjjv$ndk$1@ger.gmane.org>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Darius <augulis.darius@gmail.com>
Cc: i2c@lm-sensors.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-i2c@vger.kernel.org

Hi Darius,

On Thu, 13 Mar 2008 18:07:45 +0200, Darius wrote:
> Almost written from scratch - only small piece of code leaved from old 
> driver, witch never was originally in vanilla kernel.
> SMB is NOT supported currently.

Assuming that you mean SMBus, it is in fact almost supported, because
i2c-core can emulate most of SMBus over I2C. Just add
I2C_FUNC_SMBUS_EMUL to i2c_imx_func() and you're done. If the device
doesn't support zero-byte messages, you might have to remove
I2C_FUNC_SMBUS_QUICK but that's about it.

> Tested on the MXLADS v2.0 board with i2c client driver (driver for 
> NT7651 LCD controller). All works fine, stable.

You really need to read Documentation/CodingStyle and adjust your code
accordingly before I will consider merging your patch.
scripts/checkpatch.pl is your friend too.

-- 
Jean Delvare

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
