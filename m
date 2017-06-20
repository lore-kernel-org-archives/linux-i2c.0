From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v11 5/6] i2c: designware: add SLAVE mode functions
Date: Tue, 20 Jun 2017 11:03:27 +0300
Message-ID: <b6346c22-7078-13f3-dc0e-d3f8b452aee6@linux.intel.com>
References: <cover.1497025304.git.lolivei@synopsys.com>
 <bef9f237bed23f0ea05499b085103f7eea9058a1.1497025304.git.lolivei@synopsys.com>
 <CAHp75VeHoUrq-PfayNZYGP0f-bbnKQQEN4uMBg6ZASJs46b_PQ@mail.gmail.com>
 <6e332d71-1891-21aa-4479-b91a7550f8af@synopsys.com>
 <20170619155858.xjs5nvdkg42b73vg@ninjato>
 <CAHp75VfpgOZ72=5F3aN_tfau3TnyGLsdKt=sdx_ZJ04wtxMtJg@mail.gmail.com>
 <20170619162235.o2i4wzuyvcyoguwk@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170619162235.o2i4wzuyvcyoguwk@ninjato>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ramiro Oliveira <Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06/19/2017 07:22 PM, Wolfram Sang wrote:
>
>>> I wonder if we haven't reached a state where Luis just could fix the
>>> buildbot error (missing 'select I2C_SLAVE') and the thing pointed out by
>>> Andy and we handle further small fixes incrementally during the v4.13
>>> cycle? AFAICS there is no major show-stopper, or am I wrong?
>>
>> I would go with the following plan:
>> 1. Push 1-4
>> 2. Resend 5-6 with addressed pointed issues for one more (fast) round
>
> Good, so I'll pick up 1-4 now. Thanks!
>
Yep, that's easier for everyone.

-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
