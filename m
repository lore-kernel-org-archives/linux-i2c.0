From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 3/7] drivers/i2c: Add port structure to FSI algorithm
Date: Thu, 31 May 2018 00:28:52 +0300
Message-ID: <CAHp75VfOBmYVSLL7q_0CH2dQ3s0u=iYumQbPBJfN88EoYmhc1Q@mail.gmail.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1527632665-25707-4-git-send-email-eajames@linux.vnet.ibm.com>
 <CAHp75Vd38BrJcULxoqj1mTKCEvMh9ZVYEvzCMAg2t9onZrSR6w@mail.gmail.com>
 <ae3de08c-6849-bb3a-7c6c-96309876d48e@linux.vnet.ibm.com> <CAHp75Vd8M4-mK=Fs_SbSX67NKeNty7vrq0-Y8-GyFdy9u6Q3jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd8M4-mK=Fs_SbSX67NKeNty7vrq0-Y8-GyFdy9u6Q3jA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 31, 2018 at 12:27 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, May 30, 2018 at 6:47 PM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
>> On 05/29/2018 06:19 PM, Andy Shevchenko wrote:

>>>> +                       devm_kfree(dev, port);

>>> This hurts my eyes. Why?!
>
>> What would you suggest instead?

> Why are you doing that
> call implicitly?

s/implicitly/explicitly/


-- 
With Best Regards,
Andy Shevchenko
