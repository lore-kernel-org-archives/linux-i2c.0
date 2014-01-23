From: Matthew Locke <mlocke@codeaurora.org>
Subject: Re: [PATCH v3 1/2] i2c: qup: Add device tree bindings information
Date: Thu, 23 Jan 2014 13:11:50 -0600
Message-ID: <174308F1-FFD2-4CB3-AEA2-C423F90FB133@codeaurora.org>
References: <1389999819-10648-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1389999819-10648-2-git-send-email-bjorn.andersson@sonymobile.com>
 <CAL_JsqJBEu8iLzE8-dXniZFytr6cQsprBYiYnJeXS2-80iy1Mw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqJBEu8iLzE8-dXniZFytr6cQsprBYiYnJeXS2-80iy1Mw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Matt Porter <matt.porter@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Grant Likely <grant.likely@linaro.org>, James Ralston <james.d.ralston@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Ivan T. Ivanov" <iivanov@mm-sol.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Jean Delvare <khali@linux-fr.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bill Brown <bill.e.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-k
List-Id: linux-i2c@vger.kernel.org

Rob,

On Jan 20, 2014, at 8:10 AM, Rob Herring wrote:

> On Fri, Jan 17, 2014 at 5:03 PM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
>> From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
>> 
>> The Qualcomm Universal Peripherial (QUP) wraps I2C mini-core and
>> provide input and output FIFO's for it. I2C controller can operate
>> as master with supported bus speeds of 100Kbps and 400Kbps.
>> 
>> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
>> [bjorn: reformulated part of binding description and cleaned up example]
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>> ---
> 
> Patch history?
> 
>> .../devicetree/bindings/i2c/qcom,i2c-qup.txt       | 41 ++++++++++++++++++++++
>> 1 file changed, 41 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt
>> new file mode 100644
>> index 0000000..a99711b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt
>> @@ -0,0 +1,41 @@
>> +Qualcomm Universal Peripheral (QUP) I2C controller
>> +
>> +Required properties:
>> + - compatible: Should be "qcom,i2c-qup".
> 
> Seems a bit generic. All versions of the IP are exactly the same?
> "qcom,<chip>-i2c-qup" would be better.

The QUP IP block is the same across chips.  Its possible there could be different versions of the IP block but its pretty stable now. 

> 
>> + - reg: Should contain QUP register address and length.
>> + - interrupts: Should contain I2C interrupt.
>> +
>> + - clocks: Should contain the core clock and the AHB clock.
>> + - clock-names: Should be "core" for the core clock and "iface" for the
>> +                AHB clock.
>> +
>> + - #address-cells: Should be <1> Address cells for i2c device address
>> + - #size-cells: Should be <0> as i2c addresses have no size component
>> +
>> +Optional properties:
>> + - clock-frequency: Should specify the desired i2c bus clock frequency in Hz,
>> +                    default is 100kHz if omitted.
>> +
>> +Child nodes should conform to i2c bus binding.
>> +
>> +Example:
>> +
>> + i2c2: i2c@f9924000 {
>> +       compatible = "qcom,i2c-qup";
>> +       reg = <0xf9924000 0x1000>;
>> +       interrupts = <0 96 0>;
>> +
>> +       clocks = <&gcc_blsp1_qup2_i2c_apps_clk>, <&gcc_blsp1_ahb_clk>;
>> +       clock-names = "core", "iface";
>> +
>> +       clock-frequency = <355000>;
>> +
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +
>> +       dummy@60 {
>> +               compatible = "dummy";
>> +               reg = <0x60>;
>> +       };
>> + };
>> +
>> --
>> 1.8.2.2
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
