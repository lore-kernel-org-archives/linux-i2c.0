From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] drivers/i2c/i2c-dev: Fix kernel memory disclosure
Date: Thu, 12 Jan 2017 19:36:29 +0100
Message-ID: <20170112183629.b2nubwg36cloufrj@ninjato>
References: <1483977216-7623-1-git-send-email-vlad@tsyrklevich.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:50266 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbdALSgd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 12 Jan 2017 13:36:33 -0500
Content-Disposition: inline
In-Reply-To: <1483977216-7623-1-git-send-email-vlad@tsyrklevich.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vlad Tsyrklevich <vlad@tsyrklevich.net>
Cc: linux-i2c@vger.kernel.org

On Mon, Jan 09, 2017 at 10:53:36PM +0700, Vlad Tsyrklevich wrote:
> i2c_smbus_xfer() does not always fill an entire block, allowing
> kernel stack memory disclosure through the temp variable. Clear
> it before it's read to.
> 
> Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>

Applied to for-current, thanks!
