From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v6 7/9] i2c: i2c-mux-simple: new driver
Date: Mon, 2 Jan 2017 16:30:02 +0100
Message-ID: <49bbe0f9-8cf7-c932-265e-ebab39bc2a1e@axentia.se>
References: <1480493823-21462-1-git-send-email-peda@axentia.se>
 <1480493823-21462-8-git-send-email-peda@axentia.se>
 <CAHp75Vc2uYhaYJu_eU-uBq_PZrUgaoNt8sxpuRF8eEEs2kPUwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75Vc2uYhaYJu_eU-uBq_PZrUgaoNt8sxpuRF8eEEs2kPUwg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2017-01-01 16:38, Andy Shevchenko wrote:
> On Wed, Nov 30, 2016 at 10:17 AM, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org> wrote:
>> This is a generic simple i2c mux that uses the generic multiplexer
>> subsystem to do the muxing.
> 
>> +static const struct of_device_id i2c_mux_of_match[] = {
>> +       { .compatible = "i2c-mux-simple,parent-locked",
>> +         .data = (void *)0, },
>> +       { .compatible = "i2c-mux-simple,mux-locked",
>> +         .data = (void *)1, },
>> +       {},
>> +};
> 
> Perhaps
> 
> #define I2C_MUX_LOCKED_PARENT  0
> #define I2C_MUX_LOCKED         1

I2C_MUX_LOCKED is already "taken" in include/linux/i2c-mux.h but I'll
use SIMPLE_PARENT_LOCKED and SIMPLE_MUX_LOCKED instead.

Cheers,
peda

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
