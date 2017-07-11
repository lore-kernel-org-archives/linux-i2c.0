From: "Frkuska, Joshua" <joshua_frkuska@mentor.com>
Subject: Re: [PATCH V5 0/2] i2c: imx: add slave support
Date: Tue, 11 Jul 2017 20:41:57 +0900
Message-ID: <ff0d16be-53da-047e-f9db-8c061e03f88d@mentor.com>
References: <1498571888-17700-1-git-send-email-joshua_frkuska@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:35710 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbdGKLmK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 11 Jul 2017 07:42:10 -0400
In-Reply-To: <1498571888-17700-1-git-send-email-joshua_frkuska@mentor.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, wsa@the-dreams.de, kernel@pengutronix.de
Cc: vladimir_zapolskiy@mentor.com, peda@axentia.se, syrchin@dev.rtsoft.ru

Hello Wolfram,

Since I have not received any responses on the list (that I am aware 
of), please allow me to follow up and ask if you have any reservations 
or comments regarding the patch set.

Thank you in advance

On 06/27/2017 10:58 PM, Joshua Frkuska wrote:
> Purpose:
> Its purpose is to introduce i2c slave with multimaster capabilities to the imx i2c controller driver.
>
> This patch was tested on i.MX6q sabresd, sabreai and UDOO boards. It is a continuation of the work started in the following thread https://www.spinics.net/lists/linux-i2c/msg27340.html
>
> The current version is version 5 and is a continuation of the discussion in http://www.spinics.net/lists/linux-i2c/msg27563.html
>
> v5 change summary:
> 1. rebased patchset on i2c/for-next 5ff37d1a67e2fed0cae537ad682abb7f6647cca4 "Merge branch 'i2c/for-4.13' into i2c/for-next"
>
> v4 change summary:
> 1. preserved Maxim's authorship, added rework note with signoff
> 2. re-arranged #include ordering
> 3. fixed check-patch warnings
> 4. redefined MAX_EVENTS to an integer
> 5. removed introduction of error codes
> 6. changed last_error (atomic_t) to type int
> 7. removed white lines
> 8. fixed multiple parenthesis alignment issues
> 9. removed explicit casting
> 10. replace udelay with usleep_range
> 11. removed multiple excess spacing issues
> 12. check for return of wait_event_interruptible_timeout
> 13. simplified conditional statements
> 14. removed dubious pinctrl handling
> 15. updated commit message
>
> Testing: (validated locally with 3 different imx6q devices) For the purpose of this test, any 2 imx6 boards were hooked together to form a multimaster bus. In this configuration, slave and multimaster configurations can alternatively be stress tested. It is rebased and tested on the i2c/for-next branch.
> 1. enable CONFIG_I2C_SLAVE=y
> 2. enable CONFIG_I2C_SLAVE_EEPROM=y[m]
> 3. enable CONFIG_I2C_CHARDEV=y[m]
> 4. build the kernel
> 5. install the kernel/drivers on 2 imx devices
> 6. wire the i2c busses of both devices together
> 7. load kernel modules if needed
> 8. instantiate a slave eeprom on device 1 with address A on whatever bus it corresponds to (e.g. `echo slave-24c02 0x1066 > /sys/bus/i2c/devices/i2c-0/new_device`)
> 9. instantiate a slave eeprom on device 2 with address B on whatever bus it corresponds to (e.g. `echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-2/new_device`)
> 10. using i2cget/set on the appropriate bus, randomly read/write on device 1 from/to address B. (e.g. `i2cget -y 0 0x64` OR `i2cset -y 0 0x64 0x01 5`)
> 11. using i2cget/set on the appropriate bus, randomly read/write on device 2 from/to address A. (e.g. `i2cget -y 2 0x66` OR `i2cset -y 2 0x66 0x02 7`)
> 12. confirm operation between devices by observing the input and output of the i2cget/set functions as well as dumping the contents of the eeprom via the sysfs entry (/sys/bus/i2c/devices/i2c-<BUS #>/new_device)
>
> Any constructive comments would be greatly appreciated.
>
> Thank you
>
> Joshua Frkuska (1):
>   ARM: imx_v6_v7_defconfig: Test imx i2c slave support
>
> Maxim Syrchin (1):
>   i2c: imx: add slave support
>
>  arch/arm/configs/imx_v6_v7_defconfig |   7 +-
>  drivers/i2c/busses/i2c-imx.c         | 730 +++++++++++++++++++++++++++++++++--
>  2 files changed, 695 insertions(+), 42 deletions(-)
>
