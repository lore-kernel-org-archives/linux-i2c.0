From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iio: adc: axp288: Drop bogus AXP288_ADC_TS_PIN_CTRL
 register modifications
Date: Sat, 7 Jan 2017 22:23:47 +0000
Message-ID: <c86f5ad2-f504-e2a9-32eb-d16d500a09fe@kernel.org>
References: <20161214135525.16477-1-hdegoede@redhat.com>
 <1f31b2e7-90fa-0fb8-5f6e-a8ee2ddf69f7@kernel.org>
 <20161230101501.06958c0d@jacob-builder>
 <054b52de-40fd-a879-7b8e-2d25fed18840@redhat.com>
 <20170103102343.735dbdd1@jacob-builder>
 <221c8f4e-0757-19bb-90db-4e34677734c5@redhat.com>
 <20170104095517.6f7ee610@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170104095517.6f7ee610@jacob-builder>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "russianneuromancer @ ya . ru" <russianneuromancer-k+OT61UuxXo@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 04/01/17 17:55, Jacob Pan wrote:
> On Tue, 3 Jan 2017 23:10:57 +0100
> Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
>>> It could have been a quirk we had to do on our platforms, I just
>>> cannot recall the details. Are you testing this on x86 platforms?  
>>
>> Yes, I've successfully tested this on 2 different models cherrytrail
>> tablets.
> 
> [Jacob Pan] I am ok with your change. I last tested on baytrail
> tablets, I don't know if you have one available to verify. That would
> be ideal.
> 
Stable material?  As I read this it is a fairly major fix, but we aren't
entirely sure there wasn't a reason on some platforms for this 'interesting'
corner of code?  

So basically are we sure this won't cause regressions? If so I'll take
it as a fix and mark for stable.

Thanks,

Jonathan
> Thanks,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
