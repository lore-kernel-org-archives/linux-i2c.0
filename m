From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] i2c: zx2967: always use the same device when printing
 errors
Date: Sat, 24 Jun 2017 21:46:34 +0800
Message-ID: <20170624134632.GC23753@dragon>
References: <20170623190530.19614-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbdFXNqt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 24 Jun 2017 09:46:49 -0400
Content-Disposition: inline
In-Reply-To: <20170623190530.19614-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On Fri, Jun 23, 2017 at 09:05:30PM +0200, Wolfram Sang wrote:
> Let's always use the platform device for dev_* and not sometimes the
> adapter device as well. Also fix this checkpatch check:
> 
> CHECK: Macro argument 'i2c' may be better as '(i2c)' to avoid precedence issues
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Shawn Guo <shawnguo@kernel.org>
