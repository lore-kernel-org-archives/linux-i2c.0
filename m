From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv5 3/8] i2c: Match using traditional OF methods, then by
 vendor-less compatible strings
Date: Tue, 10 May 2016 00:58:57 -0400
Message-ID: <7715624c-6fec-a990-2ed7-79b959ccdcf3@osg.samsung.com>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <1462374888-22888-4-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:38272 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbcEJE7L (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 10 May 2016 00:59:11 -0400
In-Reply-To: <1462374888-22888-4-git-send-email-kieran@bingham.xyz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

On 05/04/2016 11:14 AM, Kieran Bingham wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> This function provides a single call for all I2C devices which need to
> match firstly using traditional OF means i.e by of_node, then if that
> fails we attempt to match using the supplied I2C client name with a
> list of supplied compatible strings with the '<vendor>,' string
> removed.  The latter is required due to the unruly naming conventions
> used currently by I2C devices.
> 
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> [Kieran: Fix static inline usage on !CONFIG_OF]
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
