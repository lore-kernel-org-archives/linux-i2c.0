From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: retry transfer on transient failure
Date: Tue, 05 Jan 2016 14:22:28 +0200
Message-ID: <1451996548.30729.398.camel@linux.intel.com>
References: <a34c8973420a179cb195ddcfbb29ef1728f32ba3.1450889004.git.baruch@tkos.co.il>
	 <1451320480.30729.351.camel@linux.intel.com> <20160104194949.GE1522@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:23679 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbcAEMYP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 5 Jan 2016 07:24:15 -0500
In-Reply-To: <20160104194949.GE1522@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Baruch Siach <baruch@tkos.co.il>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Rolland Chau <zourongrong@gmail.com>

On Mon, 2016-01-04 at 20:49 +0100, Wolfram Sang wrote:
> > After that, introduce a new property 'linux,i2c-retry-count' to be
> > used
> > as retries field in struct i2c_adapter.
> 
> Hmm, to be honest, I always have difficulties with this "retries"
> parameter; to me "try x milliseconds" makes more sense than "try 5
> times". It is there for ages, so we have to stick with it, but
> frankly,
> I wouldn't like to expose it too much :)

Point taken.

> I'm okay with the original patch putting some "sane" initial value.
> It
> can be modified at runtime via a i2c-dev ioctl if needed.

Ah, good. So, I'm fine with it if no one has strong argument.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
