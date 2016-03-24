From: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Subject: Re: [PATCH v2 1/8] i2c-mux: add common core data for every mux instance
Date: Thu, 24 Mar 2016 19:59:37 +0100
Message-ID: <56F43919.1020501@lysator.liu.se>
References: <1452009438-27347-1-git-send-email-peda@lysator.liu.se> <1452009438-27347-2-git-send-email-peda@lysator.liu.se> <56F3B86E.4050002@mentor.com> <56F3CA0E.60906@lysator.liu.se> <56F3F89F.8000805@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56F3F89F.8000805-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>Olli Salonen <oll>
List-Id: linux-i2c@vger.kernel.org

Hi Vladimir,

On 2016-03-24 15:24, Vladimir Zapolskiy wrote:
> On 24.03.2016 13:05, Peter Rosin wrote:
>> On 2016-03-24 10:50, Vladimir Zapolskiy wrote:
>>> On 05.01.2016 17:57, Peter Rosin wrote:
>>>> @@ -196,21 +195,21 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
>>>>  		dev_err(dev, "Cannot parse i2c-parent\n");
>>>>  		return -EINVAL;
>>>>  	}
>>>> -	arb->parent = of_get_i2c_adapter_by_node(parent_np);
>>>> +	muxc->parent = of_find_i2c_adapter_by_node(parent_np);
>>>
>>> why do you prefer here to use "unlocked" version of API?
>>>
>>> Foe example would it be safe/possible to unload an I2C bus device driver
>>> module or unbind I2C device itself in runtime?
>>
>> I think you ask why I change from of_get_i2c_... to of_find_i2c_..., and that
>> change was not intentional. It was the result of a bad merge during an early
>> rebase.
>>
>> Does that cover it?
>>
> 
> Yep, thank you for clarification, please account this in v3.

Oh , v3 is old news, v4 was sent out some weeks ago, and there is a v5
on a github branch. This bad rebase was fixed in v4.

> I'll try to find some time to review the whole changeset carefully,
> in fact I briefly reviewed it two months ago, but I didn't find
> anything obviously wrong that time.

Please put that on hold until I have rebased ontop of v4.6-rc1 and
changed a couple of other things. I'd hate for you to waste your
time on outdated patches.

Cheers,
Peter
