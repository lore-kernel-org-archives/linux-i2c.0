From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: core: helper function to detect slave mode
Date: Fri, 6 Jan 2017 19:17:52 +0200
Message-ID: <CAHp75Vdv3daVnkFmGc7gXWoqcy+CNgyqdtRXkvTJQpjyJX3eDg@mail.gmail.com>
References: <f4ec62119145bc70c938800c91eb396d30457304.1483636071.git.lolivei@synopsys.com>
 <CAHp75VdB+pApFgjFOwWYYQFUmxv5k6OYKgB4fstuy=3=2QesBQ@mail.gmail.com> <475d9c2a-da11-97d0-d0b6-37ccd4990f18@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <475d9c2a-da11-97d0-d0b6-37ccd4990f18-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 6, 2017 at 7:15 PM, Luis Oliveira
<Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org> wrote:
> On 06-Jan-17 16:29, Andy Shevchenko wrote:
>> On Thu, Jan 5, 2017 at 7:24 PM, Luis Oliveira

>> Please, add kernel doc description here, important thing is to explain
>> return codes in Return: section of it.
>>
>>> +int i2c_slave_mode_detect(struct device *dev)

Just to make sure you didn't miss this one.


-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
