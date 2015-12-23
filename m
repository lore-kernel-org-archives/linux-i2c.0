From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: designware i2c bus driver
Date: Wed, 23 Dec 2015 09:45:54 +0200
Message-ID: <20151223074554.GH1548@tarshish>
References: <CABTftiTOHfs_h9Kkb4=aA-bDKhWPxCaCZ2fRxAjHeitmz9pvsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:50457 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933387AbbLWHwW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Dec 2015 02:52:22 -0500
Content-Disposition: inline
In-Reply-To: <CABTftiTOHfs_h9Kkb4=aA-bDKhWPxCaCZ2fRxAjHeitmz9pvsA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rolland Chau <zourongrong@gmail.com>
Cc: linux-i2c@vger.kernel.org

Hi Rolland,

On Wed, Dec 23, 2015 at 02:56:20PM +0800, Rolland Chau wrote:
> I found in i2c-designware-platdrv.c , the i2c retry time is not set,
> and the default value is 0, so if I use in kernel mode, I can't set
> the retry time. I want to konw why you don't initialize the value in
> probe()?

I don't see any retry handling in current driver code. What kernel version are 
you using? What retry value do you refer to?

Adding linux-i2c mailing list to Cc.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
