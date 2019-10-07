From: <Eugen.Hristev@microchip.com>
Subject: Re: [PATCH v5 0/9] i2c: add support for filters
Date: Mon, 7 Oct 2019 07:53:21 +0000
Message-ID: <c17182ac-67dd-d11f-5daf-066bf446b969@microchip.com>
References: <1568189911-31641-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1568189911-31641-1-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
Content-ID: <AFA9552F544D064B9390772CF4786D08@namprd11.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wsa@the-dreams.de, peda@axentia.se, mark.rutland@arm.com, Ludovic.Desroches@microchip.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com, robh+dt@kernel.org
List-Id: linux-i2c@vger.kernel.org



On 11.09.2019 11:24, Eugen Hristev - M18282 wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Hello,
> 
> This series adds support for analog and digital filters for i2c controllers
> 
> This series is based on the series:
> [PATCH v2 0/9] i2c: at91: filters support for at91 SoCs
> and later
> [PATCH v4 0/9] i2c: add support for filters
> and enhanced to add the bindings for all controllers plus an extra bindings
> for the width of the spikes in nanoseconds (digital filters) and cut-off
> frequency (analog filters)
> 
> First, bindings are created for
> 'i2c-analog-filter'
> 'i2c-digital-filter'
> 'i2c-digital-filter-width-ns'
> 'i2c-analog-filter-cutoff-frequency'
> 
> The support is added in the i2c core to retrieve filter width/cutoff frequency
> and add it to the timings structure.
> Next, the at91 driver is enhanced for supporting digital filter, advanced
> digital filter (with selectable spike width) and the analog filter.
> 
> Finally the device tree for two boards are modified to make use of the
> new properties.
> 
> This series is the result of the comments on the ML in the direction
> requested: to make the bindings globally available for i2c drivers.
> 
> Changes in v5:
> - renamed i2c-filter-width-ns to i2c-digital-filter-width-ns as this
> is applicable only to digital filter
> - created new binding i2c-digital-filter-width-ns for analog filters.

Hello Wolfram and Peter,

Are you happy with the changes in this version? I haven't heard from you 
since this latest update.
I am interested to know if anymore changes are required or maybe we can 
move further with this support.

Thanks !
Eugen

> 
> Changes in v4:
> - renamed i2c-ana-filter to i2c-analog-filter
> - renamed i2c-dig-filter to i2c-digital-filter
> 
> Changes in v3:
> - made bindings global for i2c controllers and modified accordingly
> - gave up PADFCDF bit because it's a lack in datasheet
> - the computation on the width of the spike is based on periph clock as it
> is done for hold time.
> 
> Changes in v2:
> - added device tree bindings and support for enable-ana-filt and
> enable-dig-filt
> - added the new properties to the DT for sama5d4_xplained/sama5d2_xplained
> 
> Eugen Hristev (9):
>    dt-bindings: i2c: at91: add new compatible
>    dt-bindings: i2c: add bindings for i2c analog and digital filter
>    i2c: add support for filters optional properties
>    i2c: at91: add new platform support for sam9x60
>    i2c: at91: add support for digital filtering
>    i2c: at91: add support for advanced digital filtering
>    i2c: at91: add support for analog filtering
>    ARM: dts: at91: sama5d2_xplained: add analog and digital filter for
>      i2c
>    ARM: dts: at91: sama5d4_xplained: add digital filter for i2c
> 
>   Documentation/devicetree/bindings/i2c/i2c-at91.txt |  3 +-
>   Documentation/devicetree/bindings/i2c/i2c.txt      | 18 ++++++++
>   arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  6 +++
>   arch/arm/boot/dts/at91-sama5d4_xplained.dts        |  1 +
>   drivers/i2c/busses/i2c-at91-core.c                 | 38 +++++++++++++++++
>   drivers/i2c/busses/i2c-at91-master.c               | 49 ++++++++++++++++++++--
>   drivers/i2c/busses/i2c-at91.h                      | 13 ++++++
>   drivers/i2c/i2c-core-base.c                        |  6 +++
>   include/linux/i2c.h                                |  6 +++
>   9 files changed, 136 insertions(+), 4 deletions(-)
> 
