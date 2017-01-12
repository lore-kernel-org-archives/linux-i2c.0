From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] i2c: piix4: Avoid race conditions with IMC
Date: Thu, 12 Jan 2017 21:36:28 +0200
Message-ID: <CAHp75VfiwtAY6=9-Pz-NNzcYaJaHmxAB3vacMB=XMwb5wFLBkg@mail.gmail.com>
References: <20170111091144.6881-1-ricardo.ribalda@gmail.com>
 <CAHp75VeV2TfgfaYni7oS4ax4H87euJa9ReWX+vYjZ4b5nYRsMg@mail.gmail.com> <20170112192908.zvi7puq72rnfcj6j@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170112192908.zvi7puq72rnfcj6j@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 12, 2017 at 9:29 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> After addressing below comment
>> FWIW:

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>:

> @andy: Please don't prefix tags. Patchwork doesn't seem to find them like this :/

Oops, sorry, didn't notice that. I usually use a new line for them.

>> > Credit-to: Alexandre Desnoyers <alex@qtec.com>
>>
>> It would be nice to put in plain test what you tell in the discussion
>> here instead of non-standard (see submitting-patches.rst) tag.
>
> @ricardo: I agree. Is this Reported-by maybe?

Yeah, since it was mentioned IIRC that guy is hardware engineer I
don't think Suggested-by would work here better.

-- 
With Best Regards,
Andy Shevchenko
