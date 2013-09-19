From: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 2/4] ARM: STi: Supply I2C configuration to STiH416 SoC
Date: Thu, 19 Sep 2013 09:16:27 +0200
Message-ID: <84625B87D65BCF478CC1E9C886A4C314DEF1BD9579@SAFEX1MAIL4.st.com>
References: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
 <1379498483-4236-3-git-send-email-maxime.coquelin@st.com>
 <20130918120340.GF16984@lee--X1>
 <84625B87D65BCF478CC1E9C886A4C314DEF1BD9578@SAFEX1MAIL4.st.com>
 <5239A322.5010004@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen GALLIMORE <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, Stuart MENEFY <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Gabriel FERNANDEZ <gabriel.fernandez-qxv4g6HH51o@public.gmane.org>, Olivier CLERGEAUD <olivier.clergeaud-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Srini,

On 09/18/2013 03:17 PM, Srinivas KANDAGATLA wrote:
> On 18/09/13 13:46, Maxime COQUELIN wrote:
>> On 09/18/2013 02:03 PM, Lee Jones wrote:
>>>>>> This patch supplies I2C configuration to STiH416 SoC.
>>>>>>
>>>>>> Cc: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
>>>>>> Signed-off-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
>>>>>> ---
>>>>>>  arch/arm/boot/dts/stih416-pinctrl.dtsi |   35 ++++++++++++++++++++
>>>>>>  arch/arm/boot/dts/stih416.dtsi         |   57 ++++++++++++++++++++++++++++++++
>>>>>>  2 files changed, 92 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
>>>> I genuinely don't know the answer to this question, but are these
>>>> nodes identical to the ones you've just put in the stih415 DTSI file?
>>>> If so, I think it will be worth creating a stih41x DTSI rather than
>>>> duplicating lots of stuff unnecessarily.
>> There are close to be identical indeed.
>> For the clocks and pinctrl, the references names are the same, but they are
>> pointing on different nodes, as STiH415 and STiH416 have their own
>> clocks and pinctrl dtsi files.
>>
>> Srini, what is opinion about this?
> There is already a stih41x.dtsi file, but I don't think it is the right
> place for the pinctrl nodes there.
>
> Am not OK with the idea of common pinctrl nodes for STiH415 and STiH416
> for two reasons.
>
> 1> If we common up the pinctrl nodes, it will be very difficult to
> accommodate new pinctrls layout which is not guaranteed to be in same
> layout in future SOCs.
>
> 2> The retiming values in the pinctrl nodes tend to change as per SOC,
> so it will be difficult to manage it if we common it up.
>
> Am sure we can come up with a dt layout which can reduce duplication,
> but we have to be careful here not to lose the flexiblity to accommodate
> new picntrl layouts, new retimings values based on SOC.
Ok. What do you think of declaring the i2c nodes inside the stih41x.dtsi
file,
and overload them with the pinctrl and clock properties in the stih416
and stih415 dtsi files?

Regards,
Maxime
>
>
> thanks,
> srini
>
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
