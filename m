From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: piix4: Avoid race conditions with IMC
Date: Thu, 12 Jan 2017 21:37:29 +0200
Message-ID: <CAHp75Vf3quKtdB-uUmPaHzdF=acSgbBp1sFyUYpA=htUm9xJjg@mail.gmail.com>
References: <20170110121600.30649-1-ricardo.ribalda@gmail.com>
 <CAHp75VdnoW84sQh-vf57NSC6_tXGqvb_36KCPpi-XFbktWiKfw@mail.gmail.com>
 <20170112104006.4dfed9b7@endymion> <20170112100046.GB1477@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170112100046.GB1477@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.de>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 12, 2017 at 12:00 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > > +       unsigned short piix4_smba = adapdata->smba;
>> > >         u8 smba_en_lo;
>> > >         u8 port;
>> > >         int retval;
>> > > +       int timeout = 0;
>> > > +       int smbslvcnt;
>> >
>> > Keep them just after your another added variable.
>>
>> FWIW, I don't think this makes sense as a general rule. I'd rather have
>> the variables in an order which makes sense (for human readers or for
>> stack size optimization - unless gcc does it for us?), rather than
>> always adding at the same place. Is there a rationale for doing that? I
>> don't think shrinking the patch size is good enough a reason.
>
> Not really. Some say "Reorder to save bytes", some say "reorder to
> utilize cache lines most". Unless I get some numbers showing the desired
> effect,

> I go for "most readable" approach which is subjective, of
> course. I'd be totally fine with the above.

My motivation was pure readability.

-- 
With Best Regards,
Andy Shevchenko
