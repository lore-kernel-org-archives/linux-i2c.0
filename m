From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 4/7] i2c: designware: add i2c gpio recovery option
Date: Mon, 06 Nov 2017 18:09:41 +0200
Message-ID: <1509984581.25007.47.camel@linux.intel.com>
References: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
         <1509590430-11968-5-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:64200 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932196AbdKFQLP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 6 Nov 2017 11:11:15 -0500
In-Reply-To: <1509590430-11968-5-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, nsekhar@ti.com, khilman@kernel.org, wsa@the-dreams.de, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Cc: Tim Sander <tim@krieglstein.org>

On Thu, 2017-11-02 at 10:40 +0800, Phil Reid wrote:
> From: Tim Sander <tim@krieglstein.org>
> 
> This patch contains much input from Phil Reid and has been tested
> on Intel/Altera Cyclone V SOC Hardware with Altera GPIO's for the
> SCL and SDA GPIO's.
> 
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Shame on me, I totally forgot one important comment on all this.

How do we switch pinctrl back to the native function? Is it guaranteed
by pinctrl framework and all underneath drivers?


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
