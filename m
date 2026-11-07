Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794075147;
	b=bJHLYqBeHzUbT1y+2qyq1duRbsalnwZeP1QIpv6LVCkWMyZDhjq5cXNCAA8VJfDtDlEE
	 E0oqT8UWFsSvJtQoQr6+wafYqoYKvD7weeq2l+dczQZGRLcmskFCq1TIQ0slPGUxWNJ9H
	 HcaXhzdLLDAPfmZ34RfG+ylE1X9vuIxZjR7hIqzrd2j5RsBVhNO9Ekw123SNoTOgUYlrO
	 rHIkBZ09dDaKbEo748h1v+ORVmaPQLsRh9DnWf1zGodU1G0Xvce/uIQvARURJ49ousVJ1
	 yVnIWKQKjonuj8eIi8IqcZOuZOR4dz7r3sCZIxAK+F8EW8ICwnltaImdoF0BvrQasTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794075147;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4R2s70KmYw92u+iVJhGjnlNSdaRf1beLlhZJ6ki9VqY=;
	b=LJWl1s/BQAOk9aNDP0T14J8l8x4t9UvZ6Kjca7Fn6XrHdm4M/6p2MjiZ2GJzLOKWVUPx
	 gBGAi9OQxlve2iOkoqygbPq4RKicrT+OxGZUIKc+zmZJU4ioWjl4pWWjjB1dXRfLU3FYp
	 0E+E47kpD4lYMVDCDgFx5a9L2KqVooaja7826m+vmvDFz/km1iIeolmz9QQES3QVE86IB
	 kjsWqmZDJkKq28O7+okYwB4vDvUTZlQSwasJTDk1MM73JUVJA2jP7M4Mtj+ZysSl3rTvG
	 SiSPMEnFpsQL9rRpEVltYVKxRzRNK8Z+sTj4tPSsZHaD56a5bnIFoTSyBZ2V2i+Gwqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m148RFx6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29E606A326;
	Sat,  7 Nov 2026 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m148RFx6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B0C1F0089F;
	Sat,  7 Nov 2026 18:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794075147;
	bh=4R2s70KmYw92u+iVJhGjnlNSdaRf1beLlhZJ6ki9VqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=m148RFx6G+Es5ZDhvyOZ7tVHK7SITgNjNLNFccWfPi+wNTMXPyUmzc2XwbRtdy7BD
	 7OSMMjZOyjMrCTwePXhXTZmwEEXz5U9rjI+I0XLO4QSpCkbpRkVyHHKuFv7JcCD01v
	 7KXWbzJb4bhFZgYWzzVqn0sAvUOkvcP/pPhcmUZTySs3G1iM0oWugvuO+DAr5KAr+H
	 RrGcoZ+WY7QAYIxTcid78LYB+63WljhJd7JHrBM/N6nmgz+GcR33QVBPZB11scF9gQ
	 7ttF0LYXZRHTXczHwiccxUvaaQnQiXC22gRgiPQvEGQJnnC+N9KFZTYx98c6SGrzRs
	 xHWVCp8+jirrw==
Message-ID: <a3be2e35-13ee-4e8a-b231-5aa0326f6933@kernel.org>
Date: Sat, 7 Nov 2026 20:12:19 +0200
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8350: Add CCI device tree nodes
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20261104230529.3040285-1-vz@kernel.org>
 <20261104230529.3040285-3-vz@kernel.org>
 <CAFEp6-3x9P7Q3+RESpMo7mKNYqn6ed0XswSJhhr1nFyHg-w22g@mail.gmail.com>
From: Vladimir Zapolskiy <vz@kernel.org>
In-Reply-To: <CAFEp6-3x9P7Q3+RESpMo7mKNYqn6ed0XswSJhhr1nFyHg-w22g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Loic.

On 11/5/26 10:37, Loic Poulain wrote:
> On Thu, Nov 5, 2026 at 12:05 AM Vladimir Zapolskiy <vz@kernel.org> wrote:
>>
>> Add Camera Control Interface (CCI) controller device tree nodes and pin
>> configurations of the I2C busses to SM8350 SoC dtsi.
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 147 +++++++++++++++++++++++++++
>>   1 file changed, 147 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> index a51942c99f8a..41dff3736061 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> @@ -10,6 +10,7 @@
>>   #include <dt-bindings/clock/qcom,gcc-sm8350.h>
>>   #include <dt-bindings/clock/qcom,gpucc-sm8350.h>
>>   #include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/clock/qcom,sm8350-camcc.h>
>>   #include <dt-bindings/clock/qcom,sm8350-videocc.h>
>>   #include <dt-bindings/dma/qcom-gpi.h>
>>   #include <dt-bindings/firmware/qcom,scm.h>
>> @@ -2830,6 +2831,88 @@ videocc: clock-controller@abf0000 {
>>                          #power-domain-cells = <1>;
>>                  };
>>
>> +               cci0: cci@ac4f000 {
>> +                       compatible = "qcom,sm8350-cci", "qcom,msm8996-cci";
>> +                       reg = <0 0x0ac4f000 0 0x1000>;
>> +                       interrupts = <GIC_SPI 460 IRQ_TYPE_EDGE_RISING>;
>> +                       power-domains = <&camcc TITAN_TOP_GDSC>;
>> +
>> +                       clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
>> +                                <&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
>> +                                <&camcc CAM_CC_CPAS_AHB_CLK>,
>> +                                <&camcc CAM_CC_CCI_0_CLK>,
>> +                                <&camcc CAM_CC_CCI_0_CLK_SRC>;
>> +                       clock-names = "camnoc_axi",
>> +                                     "slow_ahb_src",
>> +                                     "cpas_ahb",
>> +                                     "cci",
>> +                                     "cci_src";
>> +
>> +                       pinctrl-0 = <&cci0_0_default &cci0_1_default>;
>> +                       pinctrl-1 = <&cci0_0_sleep &cci0_1_sleep>;
>> +                       pinctrl-names = "default", "sleep";
>> +
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       status = "disabled";
>> +
>> +                       cci0_i2c0: i2c-bus@0 {
>> +                               reg = <0>;
>> +                               clock-frequency = <1000000>;
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +                       };
>> +
>> +                       cci0_i2c1: i2c-bus@1 {
>> +                               reg = <1>;
>> +                               clock-frequency = <1000000>;
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +                       };
>> +               };
>> +
>> +               cci1: cci@ac50000 {
>> +                       compatible = "qcom,sm8350-cci", "qcom,msm8996-cci";
>> +                       reg = <0 0x0ac50000 0 0x1000>;
>> +                       interrupts = <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>;
>> +                       power-domains = <&camcc TITAN_TOP_GDSC>;
>> +
>> +                       clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
>> +                                <&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
>> +                                <&camcc CAM_CC_CPAS_AHB_CLK>,
>> +                                <&camcc CAM_CC_CCI_1_CLK>,
>> +                                <&camcc CAM_CC_CCI_1_CLK_SRC>;
>> +                       clock-names = "camnoc_axi",
>> +                                     "slow_ahb_src",
>> +                                     "cpas_ahb",
>> +                                     "cci",
>> +                                     "cci_src";
>> +
>> +                       pinctrl-0 = <&cci1_0_default &cci1_1_default>;
>> +                       pinctrl-1 = <&cci1_0_sleep &cci1_1_sleep>;
>> +                       pinctrl-names = "default", "sleep";
>> +
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       status = "disabled";
>> +
>> +                       cci1_i2c0: i2c-bus@0 {
>> +                               reg = <0>;
>> +                               clock-frequency = <1000000>;
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +                       };
>> +
>> +                       cci1_i2c1: i2c-bus@1 {
>> +                               reg = <1>;
>> +                               clock-frequency = <1000000>;
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +                       };
>> +               };
>> +
>>                  camcc: clock-controller@ad00000 {
>>                          compatible = "qcom,sm8350-camcc";
>>                          reg = <0 0x0ad00000 0 0x10000>;
>> @@ -3348,6 +3431,70 @@ tlmm: pinctrl@f100000 {
>>                          gpio-ranges = <&tlmm 0 0 204>;
>>                          wakeup-parent = <&pdc>;
>>
>> +                       cci0_0_default: cci0-0-default-state {
>> +                               /* SDA, SCL */
>> +                               pins = "gpio107", "gpio108";
>> +                               function = "cci_i2c";
>> +                               drive-strength = <2>;
>> +                               bias-pull-up;
> 
> I had similar comments on a different platform, but why pull-up here
> (for SCL/SDA)?

Here the setting was literally copied from the downstream pad configuration
of CCI SDA/SCL lines, likely the same has been done for other platforms too.

> Do we expect boards to lack the external pull-ups
> required by I2C?

The I2C spec requires pull-ups, but I believe it does not require external
pull-ups explicitly, so there should be no contradiction with the spec.

> If not, enabling the internal pull-ups seems
> unnecessary. Also, what is their effective resistance on these
> platforms? Aren't they typically too weak to meet the rise-time
> requirements of most I2C modes anyway?

Likely you are right that the internal pull-ups alone are too weak to get
the I2C bus functional on higher bus speeds.

What's your preference on this subject, do you wish to see 'bias-disabled'
instead? I won't have objections against it.

-- 
Best wishes,
Vladimir
