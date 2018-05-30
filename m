From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 3/7] drivers/i2c: Add port structure to FSI algorithm
Date: Thu, 31 May 2018 00:27:01 +0300
Message-ID: <CAHp75Vd8M4-mK=Fs_SbSX67NKeNty7vrq0-Y8-GyFdy9u6Q3jA@mail.gmail.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1527632665-25707-4-git-send-email-eajames@linux.vnet.ibm.com>
 <CAHp75Vd38BrJcULxoqj1mTKCEvMh9ZVYEvzCMAg2t9onZrSR6w@mail.gmail.com> <ae3de08c-6849-bb3a-7c6c-96309876d48e@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ae3de08c-6849-bb3a-7c6c-96309876d48e@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 30, 2018 at 6:47 PM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
> On 05/29/2018 06:19 PM, Andy Shevchenko wrote:
>> On Wed, May 30, 2018 at 1:24 AM, Eddie James <eajames@linux.vnet.ibm.com>
>> wrote:

>>>   static int fsi_i2c_probe(struct device *dev)
>>>   {
>>
>> Isn't below somehow repeats of_i2c_register_devices() ?
>> Why not to use it?
>
>
> Because I need to assign all these port structure fields. Also looks like
> of_i2c_register_devices creates new devices; I just want an adapter for each
> port.

Hmm... Wolfram, what is your opinion on this design?


>>> +                       devm_kfree(dev, port);
>>
>> This hurts my eyes. Why?!

> What would you suggest instead?

You even didn't wait for answer, why to ask then?
Moreover, you didn't answer to my question. Why are you doing that
call implicitly?

>>> +       if (!list_empty(&i2c->ports)) {
>>
>> My gosh, this is done already in list_for_each*()

> No, list_for_each_entry does NOT check if the list is empty or if the first
> entry is NULL.

Please, read the macro source code again.

-- 
With Best Regards,
Andy Shevchenko
