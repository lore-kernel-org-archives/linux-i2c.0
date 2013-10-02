From: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: busses: i2c-st: Add ST I2C controller
Date: Wed, 2 Oct 2013 15:56:39 +0200
Message-ID: <524C2617.5070401@st.com>
References: <1380623952-4252-1-git-send-email-maxime.coquelin@st.com>
 <1380623952-4252-2-git-send-email-maxime.coquelin@st.com>
 <524B346C.8070607@wwwdotorg.org> <524BDB00.3010508@st.com>
 <20131002090257.GA3059@katana> <524BE8FB.40000@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <524BE8FB.40000-qxv4g6HH51o@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen GALLIMORE <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, Stuart MENEFY <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gabriel FERNANDEZ <gabriel.fernandez-qxv4g6HH51o@public.gmane.org>, "kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org" <kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Pawel,

On 10/02/2013 11:35 AM, Maxime Coquelin wrote:
>
> On 10/02/2013 11:02 AM, Wolfram Sang wrote:
>>>>> +Optional properties :
>>>>> +- i2c-min-scl-pulse-width-us : The minimum valid SCL pulse width 
>>>>> that is allowed
>>>>> +  through the deglitch circuit. In units of us.
>>>>> +- i2c-min-sda-pulse-width-us : The minimum valid SDA pulse width 
>>>>> that is allowed
>>>>> +  through the deglitch circuit. In units of us.
>>>> Are those properties specific to this binding, or intended to be
>>>> generic? If specific to this binding, a vendor prefix should be 
>>>> present
>>>> in the property name. If not, you probably want to document the
>>>> properties in some common file.
>>> Ok.
>>> In last revision, I put this properties as specific to this binding.
>>> Wolfram proposed to make this generic, but it looks like this IP is the
>>> only one
>>> needing such properties.
>>>
>>> Wolfram, what would you advise?
>> It might be the only SoC now, but I could imagine that other will have
>> something similar in the future. I am not perfectly sure, though. So, I
>> asked for opinions from DT experts when I suggested those bindings. We
>> could start with vendor specific bindings and generalize them later if
>> similar ones appear. Yet my experience is that old drivers rarely get
>> converted to the new bindings.
> Ok.
> But if I start with vendor specific bindings, we will have to support it
> forever, right?
I would be glad to have your opinion on this.

Since there are no other vendors currently having this feature,
should we put these properties vendor specific?
Or put them generic in case of someone has the same feature in the future?

Thanks,
Maxime

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
