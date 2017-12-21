From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 4/5] dt-bindings: at24: extend the list of supported chips
Date: Thu, 21 Dec 2017 16:12:00 +0200
Message-ID: <CAHp75Vfv6=HNz0Lyg3qdzXGzym6OTMRJTUphxuGMHRaWyLxxEQ@mail.gmail.com>
References: <20171221134842.31287-1-brgl@bgdev.pl> <20171221134842.31287-5-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171221134842.31287-5-brgl-ARrdPY/1zhM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 21, 2017 at 3:48 PM, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org> wrote:
> Add other variants of at24 EEPROMs we support in the driver to the
> list of allowed compatible strings.

>          "atmel,24c00",
>          "atmel,24c01",
> +        "atmel,24cs01",
>          "atmel,24c02",
> +        "atmel,24cs02",
> +        "atmel,24mac402",
> +        "atmel,24mac602",
>          "atmel,spd",
>          "atmel,24c04",
> +        "atmel,24cs04",
>          "atmel,24c08",
> +        "atmel,24cs08",
>          "atmel,24c16",
> +        "atmel,24cs16",
>          "atmel,24c32",

Same comments as per spd case.

For me more naturally to have them grouped by letters inside, i.e.
          "atmel,24c00",
          "atmel,24c01",
...
        "atmel,24cs01",
        "atmel,24cs02",
...
       "atmel,24mac402",
       "atmel,24mac602",

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
