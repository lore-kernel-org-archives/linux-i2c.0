From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2 0/2] i2c-omap: Enable i2c-omap driver for AM654 SoCs
Date: Wed, 7 Nov 2018 22:31:24 +0530
Message-ID: <c664348b-bb5b-9cba-6ed5-040014515477@ti.com>
References: <20180928052557.21663-1-vigneshr@ti.com>
 <09a6b1d4-f8f4-ea90-f361-bd3a92088430@ti.com> <20181028223450.GK1882@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181028223450.GK1882@kunai>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "Menon, Nishanth" <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh+dt@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Peter Rosin <peda@axentia.se>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org


On 29/10/18 4:04 AM, Wolfram Sang wrote:
> On Sat, Oct 20, 2018 at 01:23:40PM +0530, Vignesh R wrote:
>>
>>
>> On 28-Sep-18 10:55 AM, Vignesh R wrote:
>>> Couple of patches to enable i2c-omap driver to be used with TI's new
>>> AM654 platforms.
>>>
>>>
>>> Vignesh R (2):
>>>   dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
>>>   i2c: busses: Kconfig: Enable I2C_OMAP for ARCH_K3
>>>
>>>  Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
>>>  drivers/i2c/busses/Kconfig                         | 2 +-
>>>  2 files changed, 7 insertions(+), 3 deletions(-)
>>>
>>
>> Gentle ping...
> 
> Maintainer tags are missing. Tony is listed for this driver on OMAP2+.
> Is this his realm? Do we need a specific maintainer for this driver?
> 

I think this driver needs a separate entry, will send a patch adding my
name as reviewer for this driver.

-- 
Regards
Vignesh
