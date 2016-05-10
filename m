From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv5 2/8] i2c: Add the ability to match device to compatible
 string without an of_node
Date: Tue, 10 May 2016 00:57:07 -0400
Message-ID: <1f3d282d-bf2e-6622-59f6-ea3b42c095b9@osg.samsung.com>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <1462374888-22888-3-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:38260 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbcEJE5S (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 10 May 2016 00:57:18 -0400
In-Reply-To: <1462374888-22888-3-git-send-email-kieran@bingham.xyz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

On 05/04/2016 11:14 AM, Kieran Bingham wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> A great deal of I2C devices are currently matched via DT node name, and
> as such the compatible naming convention of '<vendor>,<device>' has gone
> somewhat awry - some nodes don't supply one, some supply an arbitrary
> string and others the correct device name with an arbitrary vendor prefix.
> 
> In an effort to correct this problem we have to supply a mechanism to
> match a device by compatible string AND by simple device name.  This
> function strips off the '<vendor>,' part of a supplied compatible string
> and attempts to match without it.
> 
> The plan is to remove this function once all of the compatible strings
> for each device have been brought into line.
> 
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> [Kieran: strnicmp to strncasecmp]
> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
> Tested-by: Kieran Bingham <kieran@bingham.xyz>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
