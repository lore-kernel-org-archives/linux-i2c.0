From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] Documentation: dt: i2c: Add Altera I2C Controller
Date: Thu, 20 Apr 2017 10:47:05 -0500
Message-ID: <CAL_JsqLcrFsRDXfVUtnvUT+RWuk-eduJKV9vN94_d9TswEuCdQ@mail.gmail.com>
References: <1491926547-29510-1-git-send-email-thor.thayer@linux.intel.com>
 <1491926547-29510-3-git-send-email-thor.thayer@linux.intel.com>
 <20170413212240.uxwh5525baqmgny4@rob-hp-laptop> <7c803e53-5c1b-cd59-6c59-5a32b07edcb8@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7c803e53-5c1b-cd59-6c59-5a32b07edcb8-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 14, 2017 at 8:46 AM, Thor Thayer
<thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> Hi Rob,
>
> On 04/13/2017 04:22 PM, Rob Herring wrote:
>>
>> On Tue, Apr 11, 2017 at 11:02:26AM -0500, thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
>> wrote:
>>>
>>> From: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

[...]

>>> +Required properties :
>>> + - compatible : should be "altr,sip-i2c"
>>
>>
>> Seems kind of generic.
>>
> I'm using sip for soft IP - right now we only offer 1 flavor.

There is no versioning or release numbering associated with it?

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
