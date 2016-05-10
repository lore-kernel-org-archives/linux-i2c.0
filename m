From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv5 1/8] i2c: Add pointer dereference protection to
 i2c_match_id()
Date: Tue, 10 May 2016 00:54:45 -0400
Message-ID: <3f98dcb7-28a4-e415-dce6-28dd1edb7721@osg.samsung.com>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <1462374888-22888-2-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:38244 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbcEJEy5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 10 May 2016 00:54:57 -0400
In-Reply-To: <1462374888-22888-2-git-send-email-kieran@bingham.xyz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

On 05/04/2016 11:14 AM, Kieran Bingham wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> Here we're providing dereference protection for i2c_match_id(), which
> saves us having to do it each time it's called.  We're also stripping
> out the (now) needless checks in i2c_device_match().  This patch paves
> the way for other, similar code trimming.
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
