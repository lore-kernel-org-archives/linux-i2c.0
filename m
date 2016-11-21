From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] i2c: designware: report short transfers
Date: Mon, 21 Nov 2016 12:32:00 +0200
Message-ID: <20161121103200.GG1446@lahna.fi.intel.com>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
 <E1c7p12-0000R0-S8@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:10590 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752452AbcKUKg0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 21 Nov 2016 05:36:26 -0500
Content-Disposition: inline
In-Reply-To: <E1c7p12-0000R0-S8@rmk-PC.armlinux.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Nov 18, 2016 at 07:40:04PM +0000, Russell King wrote:
> Rather than reporting success for a short transfer due to interrupt
> latency, report an error both to the caller, as well as to the kernel
> log.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
