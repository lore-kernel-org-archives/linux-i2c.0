From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c-eg20t: fix race between i2c init and interrupt
 enable
Date: Fri, 26 Aug 2016 17:32:55 +0200
Message-ID: <20160826173255.3171feaa@endymion>
References: <1471943239-21420-1-git-send-email-yadi.hu@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35299 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753006AbcHZPc7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 26 Aug 2016 11:32:59 -0400
In-Reply-To: <1471943239-21420-1-git-send-email-yadi.hu@windriver.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Yadi Hu <yadi.hu@windriver.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org

Hi Yadi,

On Tue, 23 Aug 2016 17:07:19 +0800, Yadi Hu wrote:
> From: Hu Yadi <Yadi.hu@windriver.com>
> 
> The driver executes request_irq() function before the base address
> of i2c registers is remapped in kernel space. If i2c controller
> shares an interrupt line with other devices,it is possible that
> an interrupt arrives immediately after request_irq() is called.
> Since the interrupt handler pch_i2c_handler() is active, it will
> read its own register to determine if this interrupt was from
> its device.
> At this moment, base address of i2c registers is not remapped
> in kernel space yet,so the INT handler access a unknown address
> and a error occurs.
> 
> Signed-off-by: Hu Yadi <Yadi.hu@windriver.com>
> ---
>  drivers/i2c/busses/i2c-eg20t.c |   25 ++++++++++++++-----------
>  1 files changed, 14 insertions(+), 11 deletions(-)
> (...)

ERROR: trailing whitespace
#66: FILE: drivers/i2c/busses/i2c-eg20t.c:896:
+^I$

ERROR: code indent should use tabs where possible
#67: FILE: drivers/i2c/busses/i2c-eg20t.c:897:
+        for (i = 0; i < adap_info->ch_num; i++) {$

WARNING: please, no spaces at the start of a line
#67: FILE: drivers/i2c/busses/i2c-eg20t.c:897:
+        for (i = 0; i < adap_info->ch_num; i++) {$

total: 2 errors, 1 warnings, 44 lines checked

I'll review your patch when it passes ./scripts/checkpatch.pl.

Also note (not reported by the script): please do not add random blank
lines in the source code, it lowers readability.

-- 
Jean Delvare
SUSE L3 Support
