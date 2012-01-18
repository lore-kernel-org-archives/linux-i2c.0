From: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: RE: [PATCH] i2c: Support for Netlogic XLR/XLS I2C controller.
Date: Wed, 18 Jan 2012 06:28:47 +0000
Message-ID: <1EDB558E5F5FA14BB548E8397D4DD80901DD58@hqmbx01.netlogicmicro.com>
References: <1326808100-22540-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1326808100-22540-2-git-send-email-jayachandranc@netlogicmicro.com>,<20120117232318.GB7774@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120117232318.GB7774-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ganesan R <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ben Dooks [ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org] wrote:
> On Tue, Jan 17, 2012 at 07:18:20PM +0530, Jayachandran C. wrote:
>> From: Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
>>
>> Add support for the intergrated I2C controller on Netlogic
>> XLR/XLS MIPS SoC.
>>
>> +/*
>> + * Need un-swapped IO for the SoC I2C registers, use __raw_ IO
>> + */
>> +static inline void xlr_i2c_wreg(u32 __iomem *base, unsigned int reg, u32 val)
>> +{
>> +     __raw_writel(val, base + reg);
>> +}
>> +
>> +static inline u32 xlr_i2c_rdreg(u32 __iomem *base, unsigned int reg)
>> +{
>> +     return __raw_readl(base + reg);
>> +}
> 
> Here, there's the use of __raw accessors with memory returned from
> ioremap(). Please use readl/writel here, or provide a _good_ reason
> for not using them.

We had tried to explain it in the comment above the block.  The I2C registers on 
this SoC are in an MMIO area that is big-endian.  The PCI memory and IO space of
this SoC is  little-endian, and we have kept a byteswapping readl/writel so that the
generic PCI drivers will work.

>> +
>> +     platform_set_drvdata(pdev, priv);
>> +     ret = xlr_i2c_add_bus(priv);
>> +
>> +     if (ret < 0) {
>> +             dev_err(&priv->adap.dev, "Failed to add i2c bus.\n");
>> +             ret = -ENXIO;

> Hmm, not sure if -ENXIO is the best return code form here. I would probably
> leave the 'ret' alone, and pass it to the upper layer.

This can be fixed up.

Thanks for the review, will post an updated version.
JC.
