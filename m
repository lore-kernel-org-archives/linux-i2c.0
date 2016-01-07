From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: retry transfer on transient failure
Date: Thu, 07 Jan 2016 14:32:56 +0200
Message-ID: <1452169976.30729.407.camel@linux.intel.com>
References: <a34c8973420a179cb195ddcfbb29ef1728f32ba3.1450889004.git.baruch@tkos.co.il>
	 <1451320480.30729.351.camel@linux.intel.com> <20160104194949.GE1522@katana>
	 <1451996548.30729.398.camel@linux.intel.com>
	 <20160106044017.GB18161@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44918 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118AbcAGMce (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 7 Jan 2016 07:32:34 -0500
In-Reply-To: <20160106044017.GB18161@tarshish>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Rolland Chau <zourongrong@gmail.com>

On Wed, 2016-01-06 at 06:40 +0200, Baruch Siach wrote:
> Hi Andy,
> 
> On Tue, Jan 05, 2016 at 02:22:28PM +0200, Andy Shevchenko wrote:
> > On Mon, 2016-01-04 at 20:49 +0100, Wolfram Sang wrote:
> > > I'm okay with the original patch putting some "sane" initial
> > > value.
> > > It can be modified at runtime via a i2c-dev ioctl if needed.
> > 
> > Ah, good. So, I'm fine with it if no one has strong argument.
> 
> So can you give your ack to the original patch then?

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
