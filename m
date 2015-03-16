From: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Subject: Re: [PATCH 6/6] dts: msm8974: Add dma channels for blsp2_i2c1 node
Date: Mon, 16 Mar 2015 09:55:26 -0000
Message-ID: <0ac0be987e1d6b8bdfd524f14c83fcb4.squirrel@www.codeaurora.org>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
    <1426268992-19298-7-git-send-email-sricharan@codeaurora.org>
    <20150313195425.GA16977@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150313195425.GA16977-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

> On Fri, Mar 13, 2015 at 11:19:52PM +0530, Sricharan R wrote:
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>
> Reviewed-by: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>
>>  arch/arm/boot/dts/qcom-msm8974.dtsi | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> index 3f648ae..1ec7ec5 100644
>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> @@ -246,6 +246,8 @@
>>  			clock-names = "core", "iface";
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>> +			dmas = <&blsp2_dma 20>, <&blsp2_dma 21>;
>> +			dma-names = "bam-tx", "bam-rx";
>
> more of a nit, but the bam- is unnecessary.  it's just rx/tx.

  Ok, will change it.

Regards,
 Sricharan

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
