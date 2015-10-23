From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 2/3] i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver
Date: Fri, 23 Oct 2015 19:59:54 +0900
Message-ID: <CAK7LNATNazGG74DYvPXPUf5WE6K4356OzJnbxv4DuKjGC_g+kw@mail.gmail.com>
References: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
	<1438243942-26401-3-git-send-email-yamada.masahiro@socionext.com>
	<20151022210618.GC1516@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from conssluserg001.nifty.com ([202.248.44.39]:30378 "EHLO
	conssluserg001-v.nifty.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751390AbbJWLAR (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 23 Oct 2015 07:00:17 -0400
In-Reply-To: <20151022210618.GC1516@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Anders Berg <anders.berg@avagotech.com>, Xudong Chen <xudong.chen@mediatek.com>, Andrew Bresticker <abrestic@chromium.org>, David Box <david.e.box@linux.intel.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhangfei Gao <zhangfei.gao@linaro.org>, Beniamino Galvani <b.galvani@gmail.com>, Lee Jones <lee.jones@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Sachin Kamat <sachin.kamat@samsung.com>, Ray Jui <rjui@broadcom.com>, Subhendu Sekhar Behera <sbehera@broadcom.com>

2015-10-23 6:06 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Thu, Jul 30, 2015 at 05:12:21PM +0900, Masahiro Yamada wrote:
>> Add support for on-chip I2C controller used on newer UniPhier SoCs
>> such as PH1-Pro4, PH1-Pro5, etc.  This adapter is equipped with
>> 8-depth TX/RX FIFOs.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Same comments as for the other driver.

Fixed in v2.

> And quite some debug messages left. Could you check if you still want
> them or if they were mostly useful during development of the driver?

Yes, I want to keep them.  I do not think they are too much.


I will probably come back to these drivers when I find some time
in order to implement further features such as the slave mode.   :)

dev_dbg() might be useful for the new development
as well as for checking something when hardware went wrong for some reason.


-- 
Best Regards
Masahiro Yamada
