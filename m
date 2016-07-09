From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 6/7] i2c: print more info when acpi_i2c_space_handler()
 fails
Date: Sat, 9 Jul 2016 11:11:37 +0300
Message-ID: <20160709081137.GB14693@lahna.fi.intel.com>
References: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
 <1468038904-2571-7-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64574 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbcGIILm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 9 Jul 2016 04:11:42 -0400
Content-Disposition: inline
In-Reply-To: <1468038904-2571-7-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>

On Sat, Jul 09, 2016 at 01:35:03PM +0900, Wolfram Sang wrote:
> Use a warning loglevel instead of info and switch to dev_* for device
> info. Also print which client was accessed.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
