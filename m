From: Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c-s3c2410: Fix pointer type passed to of_match_node()
Date: Tue, 12 Jun 2012 12:38:16 +0200
Message-ID: <4FD71C18.9090209@samsung.com>
References: <1338370985-6950-1-git-send-email-k.lewandowsk@samsung.com>
 <20120611182925.GJ3887@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20120611182925.GJ3887-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 11.06.2012 20:29, Wolfram Sang wrote:

> On Wed, May 30, 2012 at 11:43:05AM +0200, Karol Lewandowski wrote:
>> This commit fixes warning introduced in 27452498a ("i2c-s3c2410: Rework
>> device type handling"):
>>
>>   drivers/i2c/busses/i2c-s3c2410.c: In function 's3c24xx_get_device_quirks':
>>   drivers/i2c/busses/i2c-s3c2410.c:125: warning: passing argument 1 of 'of_match_node' from incompatible pointer type
>>   include/linux/of.h:245: note: expected 'const struct of_device_id *' but argument is of type 'const struct of_device_id (*)[4]'
>>
>> Signed-off-by: Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> Ah, now I understand why my build-test didn't spot the warning.
> What config can I use to test CONFIG_OF with s3c?


Currently no config for samsung hardware has OF enabled by default.
However, you could use exynos4_defconfig plus following (that's what
I use):

--- a/arch/arm/configs/exynos4_defconfig
+++ b/arch/arm/configs/exynos4_defconfig
@@ -14,6 +14,7 @@ CONFIG_MACH_ORIGEN=y
 CONFIG_MACH_SMDK4412=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_MACH_EXYNOS4_DT=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_PREEMPT=y
@@ -37,6 +38,7 @@ CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_I2C=y
+CONFIG_I2C_S3C2410=y
 # CONFIG_HWMON is not set
 # CONFIG_MFD_SUPPORT is not set
 # CONFIG_HID_SUPPORT is not set

Regards,
-- 
Karol Lewandowski | Samsung Poland R&D Center | Linux/Platform
