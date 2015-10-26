From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 0/2] i2c: uniphier: add two I2C controller drivers for
 UniPhier SoC platform
Date: Mon, 26 Oct 2015 17:27:22 +0900
Message-ID: <CAK7LNATVmVi=4ugv0MgoCUzusphNeAXTC_K-PsXDiTLoCkV4-Q@mail.gmail.com>
References: <1445597520-6299-1-git-send-email-yamada.masahiro@socionext.com>
	<20151026081746.GC597@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151026081746.GC597@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, James Hogan <james.hogan@imgtec.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ray Jui <rjui@broadcom.com>, Tejun Heo <tj@kernel.org>, Andrew Bresticker <abrestic@chromium.org>, Scott Branden <sbranden@broadcom.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Pawel Moll <pawel.moll@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org, Xudong Chen <xudong.chen@mediatek.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Wolfram
List-Id: linux-i2c@vger.kernel.org

Hi Lee,


2015-10-26 17:17 GMT+09:00 Lee Jones <lee.jones@linaro.org>:
>> This series adds two I2C controller drivers.
>> (they are completely different IPs.)
>>
>> The first one is a very simple FIFO-less I2C controller,
>> which is used on some older UniPhier SoCs.
>>
>> The other one is higher-performance I2C controller with TX/RX FIFO,
>> used on newer UniPhier SoCs.
>
> And you have sent this to me because ... ?


No special reason.


I sent this series to linux-i2c@vger.kernel.org.

I guess you were automatically CC'ed by scripts/get_maintainer.pl.

Using get_maintainer.pl is a normal process when sending patches, I think.





-- 
Best Regards
Masahiro Yamada
