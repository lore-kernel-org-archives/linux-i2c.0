From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv5 0/8] 2c: Relax mandatory I2C ID table passing
Date: Tue, 10 May 2016 01:31:18 -0400
Message-ID: <d6ad231e-767a-c3a0-cc61-037ed6de7f96@osg.samsung.com>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:38434 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbcEJFba (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 10 May 2016 01:31:30 -0400
In-Reply-To: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

Hello Kieran,

On 05/04/2016 11:14 AM, Kieran Bingham wrote:
> This patch set finally pops up again, after a long time stuck somewhere in the
> midst of my stack.
> 
> As it stood last year, the requirements were to rename probe2 to probe_new, and
> ensure that it was correctly tested. The rename was the easy bit, but the
> testing took me more time to get things set up properly. And other commitments
> then got in the way of things. Of course this patch set has also been rebased
> as well, but there wasn't any major pain there.
> 
> Testing
> -------
> 
> To try to establish testing, I have used a beagle-bone-black, and a DS1307 RTC
> connected to the BBB SCL and SDA lines. The main reason for these choices is
> accesibility. i.e. I have them, and the BBB readily boots a kernel for me to
> test and iterate with.
> 
> I've tested the device with i2cdetect, and then worked through testing the
> sysfs interface, device tree, and module autoloading, each time ensuring that
> the RTC enumerates and operates
> 
> * new_device (built-in, and external module)
>   echo ds1307 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
>   cat /sys/class/rtc/rtc0/date
> 
>  - Both of those worked fine.
> 
> * Device Tree
>   I tested that the device would still register by adding a node in the device
>   tree for the board, and testing with a built-in module. 
> 
>  - This worked fine.
> 
> * Module Autoloading
>   With the device tree node in the board dts file, it wouldn't automatically
>   load from the external module. This was due to the rtc-ds1307 module not
>   exporting an of_match table, and not yet having Javier's "report OF style
>   modalias when probing using DT" [0]  patch applied
> 
>  - With the module updated, and Javiers patch applied, the module autoloads
> 
> Finally, I feel I can safely add this tag to the patch set:
> Tested-by: Kieran Bingham <kieran@bingham.xyz>
>

Same here, I've tested this series using an Exynos5800 Peach Pi Chromebook
that has a I2C touchpad device (Atmel mXT540S). So I used this series and
removed the i2c_device_id table from the device driver.

The driver could match correctly using the of_device_id table and also the
module was auto-loaded when using my mentioned RFC patch to report OF style
module aliases instead of always using the legacy one.

I've also reviewed the patches and the changes looks good to me. I hope the
patches can finally land since have been in the list for almost 2 years [0].

[0]: https://lkml.org/lkml/2014/8/28/283

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
