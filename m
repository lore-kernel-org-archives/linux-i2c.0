From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv5 7/8] mfd: 88pm860x: Move over to new I2C device .probe()
 call
Date: Tue, 10 May 2016 01:07:56 -0400
Message-ID: <dafad739-5e3c-d984-aad5-76c9b66cde0f@osg.samsung.com>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <1462374888-22888-8-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:38327 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbcEJFIK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 10 May 2016 01:08:10 -0400
In-Reply-To: <1462374888-22888-8-git-send-email-kieran@bingham.xyz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

On 05/04/2016 11:14 AM, Kieran Bingham wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> As part of an effort to rid the mostly unused second parameter for I2C
> related .probe() functions and to conform to other existing frameworks
> we're moving over to a temporary replacement .probe() call-back.
> 
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
