From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/6] i2c: ismt: improve usage of devres API
Date: Mon, 28 Sep 2015 14:01:54 +0300
Message-ID: <20150928110154.GU1536@lahna.fi.intel.com>
References: <1442413443-123579-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1443437132.8361.237.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:37237 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932230AbbI1LB5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 28 Sep 2015 07:01:57 -0400
Content-Disposition: inline
In-Reply-To: <1443437132.8361.237.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Neil Horman <nhorman@tuxdriver.com>

On Mon, Sep 28, 2015 at 01:45:32PM +0300, Andy Shevchenko wrote:
> On Wed, 2015-09-16 at 17:23 +0300, Andy Shevchenko wrote:
> > pcim_release() will release any requested region. There is no need to 
> > duplicate
> > this effort in the driver.
> 
> Any comments on that clean up series?

FWIW the whole series looks good to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
