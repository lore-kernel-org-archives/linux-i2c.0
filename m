From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/2] Makefile: add flag to disable dynamic libraries
Date: Wed, 6 Dec 2017 10:48:18 +0100
Message-ID: <20171206104818.394fe903@endymion>
References: <1512029547-8639-1-git-send-email-angelo@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753998AbdLFJsV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 6 Dec 2017 04:48:21 -0500
In-Reply-To: <1512029547-8639-1-git-send-email-angelo@amarulasolutions.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Angelo Compagnucci <angelo@amarulasolutions.com>
Cc: linux-i2c@vger.kernel.org

On Thu, 30 Nov 2017 09:12:26 +0100, Angelo Compagnucci wrote:
> In such cases where you need to disable entirely the dynamic
> library compilation, now you can use the BUILD_DYNAMIC_LIB=0
> flag.
> 
> Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> ---
>  Makefile      | 8 ++++++++
>  lib/Module.mk | 6 +++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> (...)

Applied with some line reordering, thanks.

-- 
Jean Delvare
SUSE L3 Support
