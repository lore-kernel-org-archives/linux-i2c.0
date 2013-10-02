From: Maxime COQUELIN <maxime.coquelin@st.com>
Subject: Re: [PATCH 1/4] i2c: busses: i2c-st: Add ST I2C controller
Date: Wed, 2 Oct 2013 10:36:16 +0200
Message-ID: <524BDB00.3010508@st.com>
References: <1380623952-4252-1-git-send-email-maxime.coquelin@st.com>
 <1380623952-4252-2-git-send-email-maxime.coquelin@st.com>
 <524B346C.8070607@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <524B346C.8070607@wwwdotorg.org>
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
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "kernel@stlinux.com" <kernel@stlinux.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Srinivas KANDAGATLA <srinivas.kandagatla@st.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Stephen GALLIMORE <stephen.gallimore@st.com>, Stuart MENEFY <stuart.menefy@st.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Lee Jones <lee.jones@linaro.org>, Gabriel FERNANDEZ <gabriel.fernandez@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org


On 10/01/2013 10:45 PM, Stephen Warren wrote:
> On 10/01/2013 04:39 AM, Maxime COQUELIN wrote:
>> This patch adds support to SSC (Synchronous Serial Controller)
>> I2C driver. This IP also supports SPI protocol, but this is not
>> the aim of this driver.
>>
>> This IP is embedded in all ST SoCs for Set-top box platorms, and
>> supports I2C Standard and Fast modes.
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-st.txt b/Documentation/devicetree/bindings/i2c/i2c-st.txt
>> +Required properties :
>> +- clocks : phandle to the I2C clock source
>> +- clock-names : from common clock binding: Shall be "ssc"
> I'd prefer to define that as:
>
> clock-names: Must contain "ssc".
> clocks: Must contain an entry for each name in clock-names. See the
> common clock bindings.
>
> That way, it makes it clear that clock-names is the primary lookup
> mechanism, rather than some auxiliary documentation.
OK. This will be done in next series.

>
>> +Recommended properties :
>> +- clock-frequency : Desired I2C bus clock frequency in Hz. Otherwise
> s/Otherwise/If not specified,/
Done.
>
>> +  the default 100 kHz frequency will be used. As only Normal and Fast modes
>> +  are supported, possible values are 100000 and 400000.
> I think that's just optional. Since there's a well-defined sensible
> default, there's no need to recommend it.
OK, I move it to optional.
>> +Optional properties :
>> +- i2c-min-scl-pulse-width-us : The minimum valid SCL pulse width that is allowed
>> +  through the deglitch circuit. In units of us.
>> +- i2c-min-sda-pulse-width-us : The minimum valid SDA pulse width that is allowed
>> +  through the deglitch circuit. In units of us.
> Are those properties specific to this binding, or intended to be
> generic? If specific to this binding, a vendor prefix should be present
> in the property name. If not, you probably want to document the
> properties in some common file.
Ok.
In last revision, I put this properties as specific to this binding.
Wolfram proposed to make this generic, but it looks like this IP is the 
only one
needing such properties.

Wolfram, what would you advise?
If you still prefer to make this properties generics, in which file should I
document it? I don't see any common i2c binding document for now.

>
>> +Examples :
> s/Examples/Example/ since there's just one.
Ok.
>
>> +i2c0: i2c@fed40000 {
>> +	compatible	= "st,comms-ssc-i2c";
>> +	reg		= <0xfed40000 0x110>;
>> +	interrupts	=  <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
>> +	clocks		= <&CLK_S_ICN_REG_0>;
>> +	clock-names	= "ssc";
>> +	clock-frequency = <400000>;
>> +	pinctrl-names	= "default";
>> +	pinctrl-0	= <&pinctrl_i2c0_default>;
> That wasn't mentioned in the binding definition. You'd probably want to
> document the requirement for those two properties by saying something like:
>
> A pinctrl state named "default" must be defined, using the bindings in
> ../pinctrl/pinctrl-binding.txt.
Ok. I will also add the "sleep" state in the optional definitions.

Thanks for the review Stephen.

Regards,
Maxime
