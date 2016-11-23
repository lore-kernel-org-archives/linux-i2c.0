From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/1] i2c: designware: Consolidate default functionality
 bits
Date: Wed, 23 Nov 2016 18:12:35 +0200
Message-ID: <1479917555.20074.7.camel@linux.intel.com>
References: <1479725000-22513-1-git-send-email-alexander.stein@systec-electronic.com>
         <67a95b37-73e3-7105-d9d1-7bc60c8b6fcc@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7175 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753022AbcKWQMj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 23 Nov 2016 11:12:39 -0500
In-Reply-To: <67a95b37-73e3-7105-d9d1-7bc60c8b6fcc@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On Wed, 2016-11-23 at 16:16 +0200, Jarkko Nikula wrote:
> On 21.11.2016 12:43, Alexander Stein wrote:
> > Use a common place for default functionality bits for both platform
> > and pci driver.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.co
> > m>
> > ---
> > This patch requires commit c3ae106050b9 ("i2c: designware: Implement
> > support
> > for SMBus block read and write") which is included in current
> > i2c/for-next
> > branch.
> > BTW: Do merrifield and medfield actually not support 10bit
> > addressing?
> > 
> 
> Andy, do you know?

Merrifield TRM: "Both 7-bit and 10-bit addressing modes are supported."
Same in Medfield TRM.

So, feel free to use this reference to apply a corresponding change. I
will Ack it.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
