From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [PATCH v11 5/6] i2c: designware: add SLAVE mode functions
Date: Mon, 19 Jun 2017 17:10:20 +0100
Message-ID: <160b4109-723a-3871-382c-79480f606659@synopsys.com>
References: <cover.1497025304.git.lolivei@synopsys.com>
 <bef9f237bed23f0ea05499b085103f7eea9058a1.1497025304.git.lolivei@synopsys.com>
 <CAHp75VeHoUrq-PfayNZYGP0f-bbnKQQEN4uMBg6ZASJs46b_PQ@mail.gmail.com>
 <6e332d71-1891-21aa-4479-b91a7550f8af@synopsys.com>
 <20170619155858.xjs5nvdkg42b73vg@ninjato>
 <CAHp75VfpgOZ72=5F3aN_tfau3TnyGLsdKt=sdx_ZJ04wtxMtJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfpgOZ72=5F3aN_tfau3TnyGLsdKt=sdx_ZJ04wtxMtJg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Luis Oliveira <Luis.Oliveira@synopsys.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>, Joao Pinto <Joao.Pinto@synopsys.com>, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On 19-Jun-17 17:05, Andy Shevchenko wrote:
> On Mon, Jun 19, 2017 at 6:58 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>>> Believe me I've looked for mistakes like this but I've read the code so many
>>> times I don't think I can see the obvious anymore.
>>
>> Yes, I know this. And you worked hard on this slave feature,
>> acknowledged.
>>
>> Patches 1-4 look good to me from what I glimpsed. I largely trust here
>> the *much* appreciated review from Jarkko and Andy. Thanks a lot, guys!
>>
>> I wonder if we haven't reached a state where Luis just could fix the
>> buildbot error (missing 'select I2C_SLAVE') and the thing pointed out by
>> Andy and we handle further small fixes incrementally during the v4.13
>> cycle? AFAICS there is no major show-stopper, or am I wrong?
> 
> I would go with the following plan:
> 1. Push 1-4
> 2. Resend 5-6 with addressed pointed issues for one more (fast) round
> 

For the Kbuild error I fixed it by changing

ifneq ($(CONFIG_I2C_DESIGNWARE_SLAVE),n)
i2c-designware-core-objs += i2c-designware-slave.o

to:

ifeq ($(CONFIG_I2C_DESIGNWARE_SLAVE),y)
i2c-designware-core-objs += i2c-designware-slave.o

I have test it with the .config provided and it works now.
