From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv5 4/8] i2c: Make I2C ID tables non-mandatory for DT'ed
 devices
Date: Tue, 10 May 2016 01:01:11 -0400
Message-ID: <98c8b92c-9ae0-0c9c-03d5-6b01483af8db@osg.samsung.com>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <1462374888-22888-5-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:38286 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbcEJFBX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 10 May 2016 01:01:23 -0400
In-Reply-To: <1462374888-22888-5-git-send-email-kieran@bingham.xyz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

On 05/04/2016 11:14 AM, Kieran Bingham wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> Currently the I2C framework insists on devices supplying an I2C ID
> table.  Many of the devices which do so unnecessarily adding quite a
> few wasted lines to kernel code.  This patch allows drivers a means
> to 'not' supply the aforementioned table and match on DT match tables
> instead.
> 
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
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
