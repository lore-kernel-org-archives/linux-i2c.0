From: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Subject: Re: [PATCH 5/6] dts: msm8974: Add blsp2_bam dma node
Date: Tue, 17 Mar 2015 13:10:32 -0000
Message-ID: <c65027aa3f228387475c5284a9d377dc.squirrel@www.codeaurora.org>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
    <1426268992-19298-6-git-send-email-sricharan@codeaurora.org>
    <550822A7.1010209@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <550822A7.1010209-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stanimir Varbanov <svarbanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Cc: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

> On 03/13/2015 07:49 PM, Sricharan R wrote:
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/qcom-msm8974.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> index e265ec1..3f648ae 100644
>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> @@ -247,5 +247,15 @@
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>>  		};
>> +
>> +		blsp2_dma: dma@f9944000 {
>> +			compatible = "qcom,bam-v1.4.0";
>> +			reg = <0xf9944000 0x19000>;
>> +			interrupts = <0 239 0>;
>
> for completeness this should be:
>
> interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
>
Ok, will fix. Thanks

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
