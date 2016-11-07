From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv7 07/11] i2c: match dt-style device names from sysfs
 interface
Date: Mon, 7 Nov 2016 16:10:51 -0300
Message-ID: <69b56515-2799-0c16-06a5-d3709d0be751@osg.samsung.com>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
 <1478522866-29620-8-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478522866-29620-8-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

Hello Kieran,

On 11/07/2016 09:47 AM, Kieran Bingham wrote:
> A user can choose to instantiate a device on an i2c bus using the sysfs
> interface by providing a string and address to match and communicate
> with the device on the bus. Presently this string is only matched
> against the old i2c device id style strings, even in the presence of
> full device tree compatible strings with vendor prefixes.
> 
> Providing a vendor-prefixed string to the sysfs interface will not match
> against the device tree of_match_device() calls as there is no device
> tree node to parse from the sysfs interface.
> 
> Convert i2c_of_match_device_strip_vendor() such that it can match both
> vendor prefixed and stripped compatible strings on the sysfs interface.
> 
> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
>

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
