From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/5] i2c: mux: pca954x: Refactor pca954x_irq_handler()
Date: Mon, 16 Mar 2020 18:08:04 +0200
Message-ID: <20200316160804.GU1922688@smile.fi.intel.com>
References: <20200305155352.39095-1-andriy.shevchenko@linux.intel.com>
 <31d8a07f-a841-d58b-ebc8-3cba39d00a95@axentia.se>
 <20200306100215.GS1224808@smile.fi.intel.com>
 <102340b1-b742-82cb-8a31-147a8e338662@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2182 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731704AbgCPQID (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 16 Mar 2020 12:08:03 -0400
Content-Disposition: inline
In-Reply-To: <102340b1-b742-82cb-8a31-147a8e338662@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>

On Fri, Mar 06, 2020 at 11:58:47AM +0100, Peter Rosin wrote:
> On 2020-03-06 11:02, Andy Shevchenko wrote:

> Yep, that's safer. Thanks!

Thank you for review, I just sent v2.

-- 
With Best Regards,
Andy Shevchenko
