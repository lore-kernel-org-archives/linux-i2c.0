From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v5 0/9] i2c: add support for filters
Date: Mon, 21 Oct 2019 15:23:15 +0000
Message-ID: <f5bd0c1f-9a72-6661-146b-ef5de77e31ff@axentia.se>
References: <1568189911-31641-1-git-send-email-eugen.hristev@microchip.com>
 <c17182ac-67dd-d11f-5daf-066bf446b969@microchip.com>
 <20191021140515.GC26782@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191021140515.GC26782@ninjato>
Content-Language: en-US
Content-ID: <542A5BB2F1351346977B834EB3C11628@eurprd02.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, "Eugen.Hristev@microchip.com" <Eugen.Hristev@microchip.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On 2019-10-21 16:05, Wolfram Sang wrote:
> On Mon, Oct 07, 2019 at 07:53:21AM +0000, Eugen.Hristev@microchip.com wrote:
>>
>>
>> On 11.09.2019 11:24, Eugen Hristev - M18282 wrote:
>>> From: Eugen Hristev <eugen.hristev@microchip.com>
>>>
>>> Hello,
>>>
>>> This series adds support for analog and digital filters for i2c controllers
>>>
>>> This series is based on the series:
>>> [PATCH v2 0/9] i2c: at91: filters support for at91 SoCs
>>> and later
>>> [PATCH v4 0/9] i2c: add support for filters
>>> and enhanced to add the bindings for all controllers plus an extra bindings
>>> for the width of the spikes in nanoseconds (digital filters) and cut-off
>>> frequency (analog filters)
>>>
>>> First, bindings are created for
>>> 'i2c-analog-filter'
>>> 'i2c-digital-filter'
>>> 'i2c-digital-filter-width-ns'
>>> 'i2c-analog-filter-cutoff-frequency'
>>>
>>> The support is added in the i2c core to retrieve filter width/cutoff frequency
>>> and add it to the timings structure.
>>> Next, the at91 driver is enhanced for supporting digital filter, advanced
>>> digital filter (with selectable spike width) and the analog filter.
>>>
>>> Finally the device tree for two boards are modified to make use of the
>>> new properties.
>>>
>>> This series is the result of the comments on the ML in the direction
>>> requested: to make the bindings globally available for i2c drivers.
>>>
>>> Changes in v5:
>>> - renamed i2c-filter-width-ns to i2c-digital-filter-width-ns as this
>>> is applicable only to digital filter
>>> - created new binding i2c-digital-filter-width-ns for analog filters.
>>
>> Hello Wolfram and Peter,
>>
>> Are you happy with the changes in this version? I haven't heard from you 
>> since this latest update.
>> I am interested to know if anymore changes are required or maybe we can 
>> move further with this support.
> 
> So, I had a look now and I am happy. I will give Peter one more day to
> comment, otherwise I'll apply it tomorrow.

I had another read-through and only found one nit which is in a separate
message. You can add

Reviewed-by: Peter Rosin <peda@axentia.se>

for the whole series.

Cheers,
Peter

> Thanks for your patience and keeping at it!
> 
