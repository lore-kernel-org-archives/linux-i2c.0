From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] i2c: designware: retry transfer on transient failure
Date: Wed, 6 Jan 2016 06:40:17 +0200
Message-ID: <20160106044017.GB18161@tarshish>
References: <a34c8973420a179cb195ddcfbb29ef1728f32ba3.1450889004.git.baruch@tkos.co.il>
 <1451320480.30729.351.camel@linux.intel.com>
 <20160104194949.GE1522@katana>
 <1451996548.30729.398.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:55137 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbcAFEkZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 5 Jan 2016 23:40:25 -0500
Content-Disposition: inline
In-Reply-To: <1451996548.30729.398.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Rolland Chau <zourongrong@gmail.com>

Hi Andy,

On Tue, Jan 05, 2016 at 02:22:28PM +0200, Andy Shevchenko wrote:
> On Mon, 2016-01-04 at 20:49 +0100, Wolfram Sang wrote:
> > I'm okay with the original patch putting some "sane" initial value.
> > It can be modified at runtime via a i2c-dev ioctl if needed.
> 
> Ah, good. So, I'm fine with it if no one has strong argument.

So can you give your ack to the original patch then?

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
