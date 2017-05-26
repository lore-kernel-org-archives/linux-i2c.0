From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/8] i2c: rename core source file to allow refactorization
Date: Fri, 26 May 2017 19:12:27 +0300
Message-ID: <20170526161227.GA2784@lahna.fi.intel.com>
References: <20170526082101.4746-1-wsa@the-dreams.de>
 <20170526082101.4746-2-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12692 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S944050AbdEZQMm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 26 May 2017 12:12:42 -0400
Content-Disposition: inline
In-Reply-To: <20170526082101.4746-2-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, linux-acpi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 26, 2017 at 10:20:52AM +0200, Wolfram Sang wrote:
> The I2C core became quite huge and its monolithic structure makes
> maintenance hard. So, prepare to break out some functionality into
> seperate files by renaming the source file. Note that we keep the
> resulting object name constant to avoid regressions.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
