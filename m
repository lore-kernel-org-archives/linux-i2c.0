From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/6] dt-bindings: i2c: dw: Add Baikal-T1 SoC I2C
 controller
Date: Thu, 12 Mar 2020 16:43:40 -0500
Message-ID: <20200312214340.GA30360@bogus>
References: <20200306131955.12806-1-Sergey.Semin@baikalelectronics.ru>
 <20200306132018.C268A8030792@mail.baikalelectronics.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200306132018.C268A8030792@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Serge Semin <Sergey.Semin@baikalelectronics.ru>, Serge Semin <fancer.lancer@gmail.com>, Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Burton <paulburton@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 6 Mar 2020 16:19:52 +0300, <Sergey.Semin@baikalelectronics.ru> wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Just add the "be,bt1-i2c" compatible string to the bindings. The rest of
> the DW APB I2C properties can be freely used to describe the Baikal-T1
> I2C controller dts-node.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
