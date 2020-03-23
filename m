From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] i2c: i801: Fix memory corruption in i801_isr_byte_done()
Date: Mon, 23 Mar 2020 12:37:33 +0300
Message-ID: <20200323093733.GA26299@kadam>
References: <0000000000009586b2059c13c7e1@google.com>
 <20200114073406.qaq3hbrhtx76fkes@kili.mountain>
 <20200322231106.3d431ced@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:34364 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbgCWJiH (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 23 Mar 2020 05:38:07 -0400
Content-Disposition: inline
In-Reply-To: <20200322231106.3d431ced@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Daniel Kurtz <djkurtz@chromium.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot <syzbot+ed71512d469895b5b34e@syzkaller.appspotmail.com>

On Sun, Mar 22, 2020 at 11:11:06PM +0100, Jean Delvare wrote:
> Definitely not correct. The first byte of the block data array MUST be
> the size of the block read. Even if the code above does not do the
> right thing, removing the line will not help.
> 

Yeah.  I misread the code.

> Is it possible that kasan got this wrong due to the convoluted logic?
> It's late and I'll check again tomorrow morning but the code looks OK
> to me.

KASan doesn't work like that.  It works at runtime and doesn't care
about the logic.

https://syzkaller.appspot.com/bug?id=426fc8b1c1b63fb0af524d839dfcf452f2d858e2

At the bottom of the report it shows that we're in a field of f9
poisoned data so it's not priv->len which is wrong.  (My patch was way
off).

mm/kasan/kasan.h:#define KASAN_VMALLOC_INVALID   0xF9  /* unallocated space in vmapped page */

The logic looks okay to me too.  So possibly this was a race condition
or even memory corruption in an unrelated part of the kernel.

regards,
dan carpenter
