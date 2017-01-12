From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH v2] i2c: piix4: Avoid race conditions with IMC
Date: Thu, 12 Jan 2017 21:02:19 +0100
Message-ID: <CAPybu_36pu5SDhcxnqmFwviQ4NiEH9cAx0mr7bUF6_oaGfL_Mg@mail.gmail.com>
References: <20170111091144.6881-1-ricardo.ribalda@gmail.com>
 <CAHp75VeV2TfgfaYni7oS4ax4H87euJa9ReWX+vYjZ4b5nYRsMg@mail.gmail.com>
 <20170112192908.zvi7puq72rnfcj6j@ninjato> <CAHp75VfiwtAY6=9-Pz-NNzcYaJaHmxAB3vacMB=XMwb5wFLBkg@mail.gmail.com>
 <20170112195424.mprdpyjscnj6vq6j@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170112195424.mprdpyjscnj6vq6j@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram and Andy,


I have already sent a v3 with the latest suggested changes.

On Thu, Jan 12, 2017 at 8:54 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> > @andy: Please don't prefix tags. Patchwork doesn't seem to find them like this :/
>>
>> Oops, sorry, didn't notice that. I usually use a new line for them.
>
> Thanks for fixing it :)
>
>> > @ricardo: I agree. Is this Reported-by maybe?

I still believe that we miss a Credit-to: or Co-author: tag ;). Most
times we do not give enough credit to the hardware engineers. I would
have taken me a long time through dark AMD doc to figure this out. But
for the meantime Reported-by will do the job.

Thanks all of you for your fast review!


-- 
Ricardo Ribalda
