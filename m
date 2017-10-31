From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 3/7] i2c: designware: rename i2c_dw_plat_prepare_clk
 to i2c_dw_prepare_clk
Date: Tue, 31 Oct 2017 12:10:46 +0200
Message-ID: <1509444646.10233.103.camel@linux.intel.com>
References: <1509435239-64848-1-git-send-email-preid@electromag.com.au>
         <1509435239-64848-4-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11237 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751851AbdJaKP1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 06:15:27 -0400
In-Reply-To: <1509435239-64848-4-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, nsekhar@ti.com, khilman@kernel.org, wsa@the-dreams.de, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, fntoth@gmail.com

On Tue, 2017-10-31 at 15:33 +0800, Phil Reid wrote:
> For consistency with the reset of the file rename function and 

reset -> rest ?

> parameter to
> be consistent with the reset of the common file.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
