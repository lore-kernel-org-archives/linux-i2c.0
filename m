From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: remove redundant lock
Date: Wed, 13 Jan 2016 09:25:15 +0200
Message-ID: <20160113072515.GF6188@lahna.fi.intel.com>
References: <f7d81178a0e65a19872a9e5207ccd8553e15c07d.1452604595.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:2749 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbcAMH13 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 13 Jan 2016 02:27:29 -0500
Content-Disposition: inline
In-Reply-To: <f7d81178a0e65a19872a9e5207ccd8553e15c07d.1452604595.git.baruch@tkos.co.il>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, Rongrong Zou <zourongrong@gmail.com>

On Tue, Jan 12, 2016 at 03:16:35PM +0200, Baruch Siach wrote:
> The per adapter bus_lock already projects from concurrent calls to the
> master_xfer callback. No need to add a driver internal lock.
> 
> Also, rephrase a comment to drop mention of this lock.
> 
> Reported-by: Rongrong Zou <zourongrong@gmail.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
