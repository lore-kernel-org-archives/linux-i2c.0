From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv5 6/8] i2c: Provide a temporary .probe_new() call-back
 type
Date: Tue, 10 May 2016 01:04:39 -0400
Message-ID: <0027b34d-53c4-2098-f028-fc02d49354c2@osg.samsung.com>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <1462374888-22888-7-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:38310 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbcEJFEt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 10 May 2016 01:04:49 -0400
In-Reply-To: <1462374888-22888-7-git-send-email-kieran@bingham.xyz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

On 05/04/2016 11:14 AM, Kieran Bingham wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> This will aid the seamless removal of the current probe()'s, more
> commonly unused than used second parameter.  Most I2C drivers can
> simply switch over to the new interface, others which have DT
> support can use its own matching instead and others can call
> i2c_match_id() themselves.  This brings I2C's device probe method
> into line with other similar interfaces in the kernel and prevents
> the requirement to pass an i2c_device_id table.
> 
> Suggested-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> [Kieran: fix rebase conflicts and adapt for dev_pm_domain_{attach,detach}]
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
