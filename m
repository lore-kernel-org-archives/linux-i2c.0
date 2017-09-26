From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: i2c: Add armada-38x i2c binding
Date: Tue, 26 Sep 2017 13:55:40 +0200
Message-ID: <87lgl1ishv.fsf@free-electrons.com>
References: <20170922020429.20941-1-kalyan.kinthada@alliedtelesis.co.nz>
        <87377fmbpw.fsf@free-electrons.com>
        <1506289460890.34765@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1506289460890.34765-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> (Kalyan Kinthada's
        message of "Sun, 24 Sep 2017 21:44:21 +0000")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalyan Kinthada <Kalyan.Kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Cc: "devicetree@vger.kernel.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wsa@the-dreams.de" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "robh+dt@kernel.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll@arm.com" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland@arm.com" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak@codeaurora.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-i2c@vger.kernel.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Kalyan,

Please try avoid top-posting.

 On dim., sept. 24 2017, Kalyan Kinthada <Kalyan.Kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:

> Hi Gregory,
>
> I got this information from Armada-38x functional errata document.

OK but in any case just adding a new compatible was not enough you have
to update the driver in the same time, however for this case we won't
need it, see below.

>
> I can add the "marvell,mv78230-i2c" compatible string to the appropriate  device tree files 
> but the i2c-mv64xxx driver enables an additional  feature (offload i2c transactions)
> based on the compatible string "marvell,mv78230-i2c".
>
> I am not sure if this feature (offload i2c transactions) should be enabled for Armada-38x devices.
> That is the reason I felt for the need of a new compatible string
> specifically for Armada-38x SoCs.

Indeed the Armada-38x SoCs does not support hardware offloading (at
least according the datasheet). But it happens that in the earlier
version of the Armada XP the hardware offloading was buggy, so we
introduced a compatible for this case: marvell,mv78230-a0-i2c. This
compatible enable the errata fix but not the offloading feature. That
means that it is exactly the compatible you need for Armada 38x (and
Armada 39x and 375 I think).

Gregory

>
> Thanks,
> Kalyan
> ________________________________________
> From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Sent: Friday, 22 September 2017 7:30 p.m.
> To: Kalyan Kinthada
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> pawel.moll-5wv7dgnIgG8@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org;
> ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org; galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org;
> linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Chris Packham
> Subject: Re: [PATCH] dt-bindings: i2c: Add armada-38x i2c binding
>
> Hi Kalyan,
>
>  On ven., sept. 22 2017, Kalyan Kinthada <kalyan.kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:
>
>> All armada-38x variants(380, 385, 388) SoCs have an issue
>> in i2c controller which violates the i2c repeated start timing.
>
>
> Did you had an issue with one of the SoC ?
> If yes what was your setting ?
> On my side I never managed to have this sort of issue on Armada 38x.
>
>>
>> This errata is fixed in the i2c-mv64xxx driver but enabled
>> only for devices with compatible string "marvell,mv78230-i2c".
>
> In this case why not just adding the "marvell,mv78230-i2c" as compatible
> string in the appropriate device tree files ?
>
> Gregory
>
>>
>> This patch introduces a new compatible string
>> "marvell,armada-38x-i2c" for the i2c controller on armada-38x SoCs
>> so that the workaound is enabled.
>
>
>>
>> Signed-off-by: Kalyan Kinthada <kalyan.kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> index 5c30026921..fc100b6bdb 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> @@ -14,6 +14,7 @@ Required properties :
>>                           very rare, initial version of the SoC which
>>                           had broken offload support.  Linux
>>                           auto-detects this and sets it appropriately.
>> +                     - "marvell,armada-38x-i2c"
>>   - interrupts      : The interrupt number
>>
>>  Optional properties :
>> --
>> 2.14.1
>>
>
> --
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
