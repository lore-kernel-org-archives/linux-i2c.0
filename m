From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] i2c-i801: make it depend on CONFIG_X86
Date: Fri, 17 Jun 2016 22:05:54 +0300
Message-ID: <1466190354.30123.163.camel@linux.intel.com>
References: <1465996923-76230-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<20160616114915.0446f3a3@endymion>
	<1466155895.30123.153.camel@linux.intel.com>
	 <20160617205936.74d3c6cd@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20990 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021AbcFQTF6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 17 Jun 2016 15:05:58 -0400
In-Reply-To: <20160617205936.74d3c6cd@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Fri, 2016-06-17 at 20:59 +0200, Jean Delvare wrote:
> On Fri, 17 Jun 2016 12:31:35 +0300, Andy Shevchenko wrote:
> > On Thu, 2016-06-16 at 11:49 +0200, Jean Delvare wrote:
> > > 	depends on X86 || IA64 || COMPILE_TEST
> > 
> > I don't like this. (...)
> 
> May I ask why?

>From my point of view it's not scalable. If new arch comes you have to
add it here.

-- 

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
