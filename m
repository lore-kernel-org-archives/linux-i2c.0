From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
Date: Thu, 20 Apr 2017 23:53:57 +0200
Message-ID: <0f605429-afa2-2818-96d5-5da0bad122d6@axentia.se>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
 <1492101794-13444-4-git-send-email-peda@axentia.se>
 <20170418085156.GA4773@kroah.com>
 <bdeecccf-02d6-226b-8516-1d41e3602a7a@axentia.se>
 <20170418114430.GA1496@kroah.com>
 <aacdc359-e46d-7d1a-d959-63d4ecb99fde@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <aacdc359-e46d-7d1a-d959-63d4ecb99fde-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2017-04-18 23:53, Peter Rosin wrote:
> On 2017-04-18 13:44, Greg Kroah-Hartman wrote:
>> On Tue, Apr 18, 2017 at 12:59:50PM +0200, Peter Rosin wrote:
>>> On 2017-04-18 10:51, Greg Kroah-Hartman wrote:
>>>> On Thu, Apr 13, 2017 at 06:43:07PM +0200, Peter Rosin wrote:

*snip*

>>>>> +	if (mux->idle_state != MUX_IDLE_AS_IS &&
>>>>> +	    mux->idle_state != mux->cached_state)
>>>>> +		ret = mux_control_set(mux, mux->idle_state);
>>>>> +
>>>>> +	up_read(&mux->lock);
>>>>
>>>> You require a lock to be held for a "global" function?  Without
>>>> documentation?  Or even a sparse marking?  That's asking for trouble...
>>>
>>> Documentation I can handle, but where should I look to understand how I
>>> should add sparse markings?
>>
>> Run sparse on the code and see what it says :)
> 
> Will do.

I just did, and even went through the trouble of getting the bleeding
edge sparse from the git repo when sparse 0.5.0 came up empty, but it's
all silence for me. So, how do I add sparse markings?

Cheers,
peda

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
