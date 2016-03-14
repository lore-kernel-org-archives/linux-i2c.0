From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] i2c: i2c-core: do not use bus internal data
Date: Mon, 14 Mar 2016 19:55:34 +0530
Message-ID: <20160314142534.GC5699@sudip-laptop>
References: <1457351357-13457-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20160314091819.GA27975@ulmo>
 <20160314092809.GC1383@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:32945 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934173AbcCNOZi (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Mar 2016 10:25:38 -0400
Content-Disposition: inline
In-Reply-To: <20160314092809.GC1383@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, gregkh@linuxfoundation.org

On Mon, Mar 14, 2016 at 10:28:10AM +0100, Wolfram Sang wrote:
> 
> > This doesn't work. I see a number of these WARN_ON()s trigger and I
> > think the reason is that i2c_init() always fails now. The cause seems to
> > be that i2c_init() calls i2c_add_driver(&dummy_driver), which will now
> > always fail, because is_register is set to true *after* that call. There
> > is no way I see I2C working at all after this patch.
> 
> Same conclusion here. Too much trust applied to the original patch, mea
> culpa and sorry! Will send the fixup (tested!) in a minute.

Sorry for the mess. Fengguang Wu did send me a warning, but since I was
travelling i could not do much with it.
Sorry again.

regards
sudip
