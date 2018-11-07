From: vitor <vitor.soares@synopsys.com>
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
Date: Wed, 7 Nov 2018 17:30:22 +0000
Message-ID: <d2540ea9-edbd-3b36-0647-54919a9dfa2d@synopsys.com>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
 <1540807618-13246-2-git-send-email-soares@synopsys.com>
 <20181107170553.GJ3074@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107170553.GJ3074@bombadil.infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>, Vitor soares <vitor.soares@synopsys.com>
Cc: boris.brezillon@bootlin.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, mshettel@codeauror
List-Id: linux-i2c@vger.kernel.org

Hi Matthew,


On 07/11/18 17:05, Matthew Wilcox wrote:
> On Mon, Oct 29, 2018 at 10:06:56AM +0000, Vitor soares wrote:
>> Add driver for Synopsys DesignWare I3C master IP
> The so-called "data sheet" (actually just an advertising brochure)


The datasheet is there to download.


> on your website claims DMA support.  I don't see that support
> anywhere in this driver.
>

Right now the driver does not support DMA interface which will be added 
later as the other missed I3C features.

What do you suggest to avoid this misunderstanding?


Best regards,

Vitor Soares
