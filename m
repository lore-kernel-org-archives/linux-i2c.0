From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: i801: Fix memory corruption in i801_isr_byte_done()
Date: Sun, 22 Mar 2020 23:10:43 +0200
Message-ID: <CAHp75Ve-_KwH51pjnuZQAkaRsZVGuimBM-03MPW6j_nxgadx2g@mail.gmail.com>
References: <0000000000009586b2059c13c7e1@google.com> <20200114073406.qaq3hbrhtx76fkes@kili.mountain>
 <20200222124523.GI1716@kunai> <20200320145748.GD1282@ninjato> <20200322190813.39b92de2@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37235 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgCVVK4 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 22 Mar 2020 17:10:56 -0400
In-Reply-To: <20200322190813.39b92de2@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, syzbot <syzbot+ed71512d469895b5b34e@syzkaller.appspotmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Sun, Mar 22, 2020 at 8:11 PM Jean Delvare <jdelvare@suse.de> wrote:
>
> Hi Wolfram,
>
> Can you please bounce the previous messages in this thread to me? I was
> apparently not Cc'd so I'm missing the context.

You can always take it from patchwork
http://patchwork.ozlabs.org/patch/1222542/

-- 
With Best Regards,
Andy Shevchenko
