From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 3/5] i2c: i801: use BIT() macro for bits definition
Date: Fri, 29 Jul 2016 11:35:14 +0200
Message-ID: <20160729113514.20b693f5@endymion>
References: <1469699443-22129-1-git-send-email-benjamin.tissoires@redhat.com>
	<1469699443-22129-4-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51079 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbcG2JfR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jul 2016 05:35:17 -0400
In-Reply-To: <1469699443-22129-4-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 28 Jul 2016 11:50:41 +0200, Benjamin Tissoires wrote:
> i801 mixes hexadecimal and decimal values for defining bits. However,
> we have a nice BIT() macro for this exact purpose.

Looks good to me. But maybe we could convert all the FEATURE_* defines
as well?

> No functional changes, cleanup only.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 50 +++++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
