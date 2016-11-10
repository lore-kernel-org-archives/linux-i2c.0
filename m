From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Allow reduce bus speed by
 "clock-frequency" property
Date: Thu, 10 Nov 2016 16:58:42 +0200
Message-ID: <20161110145842.GK1470@lahna.fi.intel.com>
References: <20161110113720.16464-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:28516 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934005AbcKJO6v (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 10 Nov 2016 09:58:51 -0500
Content-Disposition: inline
In-Reply-To: <20161110113720.16464-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Thu, Nov 10, 2016 at 01:37:20PM +0200, Jarkko Nikula wrote:
> Allow more flexibility to bus speed selection. Now if there are I2C
> slave connections defined in ACPI the speed of slowest device on the bus
> will define the bus speed. However if also "clock-frequency" device
> property is defined we should use the slowest of these two.
> 
> This is targeted to maker boards where developer may want to connect
> slower I2C slave devices to the bus than defined in existing ACPI I2C
> slave connections.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
