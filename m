From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 4/5] i2c: i801: do not report an error if
 FEATURE_HOST_NOTIFY is not set
Date: Fri, 29 Jul 2016 12:40:36 +0200
Message-ID: <20160729124036.7deb99b7@endymion>
References: <1469699443-22129-1-git-send-email-benjamin.tissoires@redhat.com>
	<1469699443-22129-5-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59764 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbcG2Kkk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jul 2016 06:40:40 -0400
In-Reply-To: <1469699443-22129-5-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 28 Jul 2016 11:50:42 +0200, Benjamin Tissoires wrote:
> we can skip one test when calling i801_enable_host_notify(). Given
> that we call it all the time, it's better to consider the fact that
> the adapter doesn't support Host Notify as not an error.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support
