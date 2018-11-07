From: vitor <vitor.soares@synopsys.com>
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
Date: Wed, 7 Nov 2018 15:15:17 +0000
Message-ID: <8a71cb94-ccf5-8ec0-446a-37a29405f585@synopsys.com>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
 <1540807618-13246-2-git-send-email-soares@synopsys.com>
 <20181029134100.GD28520@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029134100.GD28520@bombadil.infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>, Vitor soares <vitor.soares@synopsys.com>
Cc: boris.brezillon@bootlin.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, mshettel@codeauror
List-Id: linux-i2c@vger.kernel.org

Hi Matthew,

Thank for your feedback.

On 29/10/18 13:41, Matthew Wilcox wrote:
> On Mon, Oct 29, 2018 at 10:06:56AM +0000, Vitor soares wrote:
>> +config DW_I3C_MASTER
>> +	tristate "Synospsys DesignWare I3C master driver"
>> +	depends on I3C
>> +	depends on !(ALPHA || PARISC)
> why?

Please check this email thread: https://lkml.org/lkml/2018/10/8/393

>
>> +	help
>> +	  Support·for·Synopsys·DesignWare·MIPI·I3C·Controller.
> These strange characters (displayed as a centred dot on my terminal)
> should probably be spaces.

Something went wrong here. I need to check it.

>
>> +static struct dw_i3c_xfer *
>> +dw_i3c_master_alloc_xfer(struct dw_i3c_master *master, unsigned int ncmds)
>> +{
>> +	struct dw_i3c_xfer *xfer;
>> +
>> +	xfer = kzalloc(sizeof(*xfer) + (ncmds * sizeof(*xfer->cmds)),
>> +		       GFP_KERNEL);
> You should be using struct_size() here.

This seem to be recent. I will use it next version :D

Best regards,
Vitor Soares
