From: vitor <vitor.soares@synopsys.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: i3c: Document Synopsys DesignWare I3C
 master bindings
Date: Tue, 13 Nov 2018 11:11:26 +0000
Message-ID: <db819b2d-7426-4d40-fe8a-caf62cd2912f@synopsys.com>
References: <1541697251-20392-1-git-send-email-soares@synopsys.com>
 <1541697251-20392-3-git-send-email-soares@synopsys.com>
 <20181112101703.024ba1f3@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112101703.024ba1f3@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Vitor soares <vitor.soares@synopsys.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, mshettel@codeaurora.org, swboyd@chromium.org
List-Id: linux-i2c@vger.kernel.org

Hi Boris,

On 12/11/18 09:17, Boris Brezillon wrote:
> On Thu,  8 Nov 2018 17:14:10 +0000
> Vitor soares <vitor.soares@synopsys.com> wrote:
>
>> Document Synopsys DesignWare I3C master module
>>
>> Signed-off-by: Vitor soares <soares@synopsys.com>
>> ---
>> Changes in v3:
>> - Remove dummy characters
>>
>> Changes in v2:
>> - Address the changes in Documentation/devicetree/bindings/i3c/i3c.txt
>> - Add controller version on compatible string
>>
>>   .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 42 ++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
>>
>> diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
>> new file mode 100644
>> index 0000000..b930c09
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
>> @@ -0,0 +1,42 @@
>> +Bindings for Synopsys DesignWare I3C master block
>> +=================================================
>> +
>> +Required properties:
>> +--------------------
>> +- compatible: shall be "snps,dw-i3c-master-1.00a"
>> +- clocks: shall reference the core_clk
> Are you sure this IP only requires only one clock? If you're unsure,
> you'd better have a clock-names prop.
Yes, the controller only has this clock dependency to configure the SCL.
>
>> +- interrupts: the interrupt line connected to this I3C master
>> +- reg: Offset and length of I3C master registers
>> +
>> +Mandatory properties defined by the generic binding (see
>> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
>> +
>> +- #address-cells: shall be set to 3
>> +- #size-cells: shall be set to 0
>> +
>> +Optional properties defined by the generic binding (see
>> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
>> +
>> +- i2c-scl-hz
>> +- i3c-scl-hz
>> +
>> +I3C device connected on the bus follow the generic description (see
>> +Documentation/devicetree/bindings/i3c/i3c.txt for more details).
>> +
>> +Example:
>> +
>> +	i3c-master@2000 {
>> +		compatible = "snps,dw-i3c-master-1.00a";
>> +		#address-cells = <3>;
>> +		#size-cells = <0>;
>> +		reg = <0x02000 0x1000>;
>> +		interrupts = <0>;
>> +		clocks = <&i3cclk>;
>> +
>> +		eeprom@57{
>> +			compatible = "atmel,24c01";
>> +			reg = < 0x57 0x0 0x10>;
> 			       ^ remove this white space.
>
>> +			pagesize = <0x8>;
>> +		};
>> +	};
>> +

Best regards,

Vitor Soares
