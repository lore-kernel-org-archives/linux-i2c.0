From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: designware i2c bus driver
Date: Wed, 23 Dec 2015 12:29:33 +0200
Message-ID: <20151223102933.GL1548@tarshish>
References: <CABTftiTOHfs_h9Kkb4=aA-bDKhWPxCaCZ2fRxAjHeitmz9pvsA@mail.gmail.com>
 <20151223074554.GH1548@tarshish>
 <CABTftiRXHG-1aJN9wE39-KGLw50sdo6FMjk2c7VVwG2BWNF33A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:50516 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934123AbbLWK3h (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Dec 2015 05:29:37 -0500
Content-Disposition: inline
In-Reply-To: <CABTftiRXHG-1aJN9wE39-KGLw50sdo6FMjk2c7VVwG2BWNF33A@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rolland Chau <zourongrong@gmail.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi Rolland,

On Wed, Dec 23, 2015 at 05:12:47PM +0800, Rolland Chau wrote:
> 2015-12-23 15:45 GMT+08:00 Baruch Siach <baruch@tkos.co.il>:
> > On Wed, Dec 23, 2015 at 02:56:20PM +0800, Rolland Chau wrote:
> > > I found in i2c-designware-platdrv.c , the i2c retry time is not set,
> > > and the default value is 0, so if I use in kernel mode, I can't set
> > > the retry time. I want to konw why you don't initialize the value in
> > > probe()?
> >
> > I don't see any retry handling in current driver code. What kernel version
> > are
> > you using? What retry value do you refer to?
>
> I2c_adapter.retries. It means retry times when i2c transfer failed.

Right. Makes sense. As far as I can see current code retries the transfer only 
on Tx arbitration loss. I'll send a patch later if you don't beat me to it.

> > Adding linux-i2c mailing list to Cc.
>
> I subscribe to linux-i2c, but there is no response.

Adding i2c-designware-* maintainers to Cc as well.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
