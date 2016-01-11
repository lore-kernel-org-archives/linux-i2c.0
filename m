From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: mutex_lock in designware-i2c
Date: Mon, 11 Jan 2016 23:39:17 +0200
Message-ID: <20160111213917.GB2957@tarshish>
References: <56938E0A.5080303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:57068 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933790AbcAKVjX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 11 Jan 2016 16:39:23 -0500
Content-Disposition: inline
In-Reply-To: <56938E0A.5080303@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rongrong Zou <zourongrong@gmail.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi Rongrong Zou,

On Mon, Jan 11, 2016 at 07:12:10PM +0800, Rongrong Zou wrote:
> I found a mutex lock in dw_i2c_dev for each adapter,
> struct dw_i2c_dev {
>         struct device           *dev;
>         void __iomem            *base;
>         struct completion       cmd_complete;
>         struct mutex            lock;
>         struct clk              *clk;
> 
> but there is another lock: adapter->bus_lock, this lock is also
> for each adapter, why we need both of them ?

As far as I can see from the code the master_xfer callback is never called 
concurrently for the same adaptor. So indeed the internal lock looks 
redundant. I can't remember why I put it there.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
