From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] i2c: sh_mobile: Use of_device_get_match_data() helper
Date: Thu, 5 Oct 2017 11:16:08 +0200
Message-ID: <20171005091607.GN26369@verge.net.au>
References: <1507119425-12566-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:33741 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdJEJQc (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 5 Oct 2017 05:16:32 -0400
Content-Disposition: inline
In-Reply-To: <1507119425-12566-1-git-send-email-geert+renesas@glider.be>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Wed, Oct 04, 2017 at 02:17:05PM +0200, Geert Uytterhoeven wrote:
> Use the of_device_get_match_data() helper instead of open coding.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
