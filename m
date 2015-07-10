From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-v3 04/11] i2c: pxa: Remove compile warnning in 64bit mode
Date: Fri, 10 Jul 2015 18:31:48 +0530
Message-ID: <559FC23C.1040400@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org> <1436210695-19159-5-git-send-email-vaibhav.hiremath@linaro.org> <20150710081327.GC1528@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150710081327.GC1528@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Yipeng Yao <ypyao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Friday 10 July 2015 01:43 PM, Wolfram Sang wrote:
> On Tue, Jul 07, 2015 at 12:54:48AM +0530, Vaibhav Hiremath wrote:
>> From: Yipeng Yao <ypyao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>>
>> Fix below warning message, coming from 64 bit toolchain.
>>
>> drivers/i2c/busses/i2c-pxa.c:1237:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>>
>> Signed-off-by: Yipeng Yao <ypyao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>> [vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org: Updated Changelog]
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>> Acked-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
>
> Huh? Why long? Shouldn't that be casted to enum pxa_i2c_types?
>

My bad.
Indeed it can be (and should be) enum pxa_i2c_types.

Will wait to close on the discussion on slave mode patch PATCH [02/11]
before pushing V4.


Thanks,
Vaibhav

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
