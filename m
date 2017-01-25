From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] i2c: core: helper function to detect slave mode
Date: Wed, 25 Jan 2017 23:29:39 +0200
Message-ID: <CAHp75VfaG96BgwM2S6Mw3Uv=DcLrV1id7nyMzrk9xSreT_ZAEw@mail.gmail.com>
References: <58edd25a0fbe50b6d5abef14b7e46c63a1e06830.1484663257.git.lolivei@synopsys.com>
 <20170125204537.i66nykln4fkxqryy@ninjato> <1485377409.2133.339.camel@linux.intel.com>
 <20170125210118.z5o6y6aurwic4zxc@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36465 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbdAYV3q (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 25 Jan 2017 16:29:46 -0500
In-Reply-To: <20170125210118.z5o6y6aurwic4zxc@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, Ramiro.Oliveira@synopsys.com, Joao Pinto <Joao.Pinto@synopsys.com>, CARLOS.PALMINHA@synopsys.com

On Wed, Jan 25, 2017 at 11:01 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Wed, Jan 25, 2017 at 10:50:09PM +0200, Andy Shevchenko wrote:
>> On Wed, 2017-01-25 at 21:45 +0100, Wolfram Sang wrote:
>> > > + * i2c_slave_mode_detect - detect operation mode
>> >
>> > I'd rather name it 'i2c_detect_slave_mode'
>>
>> When I proposed that I kept in ming `git grep -n i2c_slave`.
>
> "i2c.*slave"? :)

'i2c[a-z_]\+slave'

> I think having the verb first makes function names more comprehensible.
> i2c-core is not super consistent with that, but I'd say more follow this
> than not.

I'm okay with either.

-- 
With Best Regards,
Andy Shevchenko
