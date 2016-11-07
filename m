From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv7 08/11] i2c: match vendorless strings on the internal
 string length
Date: Mon, 7 Nov 2016 16:12:09 -0300
Message-ID: <5d2b30a0-78fa-7232-8fd2-dab6ec24e504@osg.samsung.com>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
 <1478522866-29620-9-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:60901
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750862AbcKGTWk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Nov 2016 14:22:40 -0500
In-Reply-To: <1478522866-29620-9-git-send-email-kieran@bingham.xyz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com

Hello Kieran,

On 11/07/2016 09:47 AM, Kieran Bingham wrote:
> If a user provides a shortened string to match a device to the sysfs i2c
> interface it will match on the first string that contains that string
> prefix.
> 
> for example:
>   echo a 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
> will match as3711, as3722, and ak8975 incorrectly.
> 
> Correct this by using sysfs_streq to match the string exactly
> 
> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
