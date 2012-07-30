From: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v7] ARM: davinci: i2c: add OF support
Date: Mon, 30 Jul 2012 11:31:05 +0200
Message-ID: <50165459.4000507@denx.de>
References: <1343632872-25896-1-git-send-email-hs@denx.de>
 <CAM=Q2csb6pvU5WA6BeFMmBSXg9h_jacft5U8239ZtE=2dbyODw@mail.gmail.com>
Reply-To: hs-ynQEQJNshbs@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CAM=Q2csb6pvU5WA6BeFMmBSXg9h_jacft5U8239ZtE=2dbyODw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Shubhrajyoti,

On 30.07.2012 10:42, Shubhrajyoti Datta wrote:
> On Mon, Jul 30, 2012 at 12:51 PM, Heiko Schocher<hs-ynQEQJNshbs@public.gmane.org>  wrote:
>> add of support for the davinci i2c driver.
[...]
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
>> index 79b4bcb..b6185dc 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
[...]
>> @@ -635,6 +633,12 @@ static struct i2c_algorithm i2c_davinci_algo = {
>>          .functionality  = i2c_davinci_func,
>>   };
>>
>> +static const struct of_device_id davinci_i2c_of_match[] = {
>> +       {.compatible = "ti,davinci-i2c", },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, davinci_i2c_of_match);
>> +
>
> Should this be protected under OF flag?

No, as I know, this is not needed.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
