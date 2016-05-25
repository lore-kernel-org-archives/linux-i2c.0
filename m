From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 5/5] i2c-i801: Remove redundant code and event-drive
Date: Wed, 25 May 2016 14:52:30 +0200
Message-ID: <20160525145230.24f1c881@endymion>
References: <1453223377-20608-1-git-send-email-minyard@acm.org>
	<1453223377-20608-6-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45809 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbcEYMwd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 25 May 2016 08:52:33 -0400
In-Reply-To: <1453223377-20608-6-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: minyard@acm.org
Cc: linux-i2c@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

Hi Corey,

On Tue, 19 Jan 2016 11:09:37 -0600, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> There was a lot of redundant code in the driver, basically one copy
> for the polled interface and one for the interrupt-driven interface.
> Only use the interrupt-driven interface and use a timer to check
> the interface periodically and time things out.

This patch is simply too large and messy for me to consider reviewing
it. It needs to be split into smaller pieces. But honestly I don't see
that much redundancy in the driver, and as a matter of fact your patch
adds more lines than it removes.

This is unfortunate because some of the changes would still be good to
have. In particular having a single call to i801_check_post() would be
a nice clean-up.

> This also adds timeouts when using interrupt, so a failed operation
> won't hang forever.

As far as I can see, the current code already has these timeouts,
although maybe it wasn't the case when you first wrote this patch? This
was added by b3b8df9772 in November 2014.

-- 
Jean Delvare
SUSE L3 Support
