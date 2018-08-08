From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v4 4/4] i2c: Add multi-instantiate pseudo driver
Date: Wed, 8 Aug 2018 12:26:54 +0200
Message-ID: <9f24c437-b7ca-0844-82b2-4899bd9c21be@axentia.se>
References: <20180808083006.31919-1-hdegoede@redhat.com>
 <20180808083006.31919-5-hdegoede@redhat.com>
 <CAHp75Vchow81kAaJ-b5Fr2ZjG7huasvM7HOfaKQzso7jaG2xXg@mail.gmail.com>
 <69e355c2-89ea-16bc-3d52-4ef9d0eb953b@axentia.se>
 <CAHp75VdyEannOhudrqMvFqEMR3hZkJ+RG_cGojkte2EfXVmZ8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdyEannOhudrqMvFqEMR3hZkJ+RG_cGojkte2EfXVmZ8w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, John Garry <john.garry@huawei.com>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2018-08-08 12:01, Andy Shevchenko wrote:
> On Wed, Aug 8, 2018 at 12:47 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2018-08-08 11:08, Andy Shevchenko wrote:
>>> On Wed, Aug 8, 2018 at 11:30 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
>>>> +       /* Count number of clients to instantiate */
>>>> +       for (i = 0; inst_data[i].type; i++) {}
>>>> +
>>>> +       multi = devm_kmalloc(dev,
>>>> +                       offsetof(struct i2c_multi_inst_data, clients[i]),
>>>> +                       GFP_KERNEL);
>>>> +       if (!multi)
>>>> +               return -ENOMEM;
>>>
>>> Here I see the following:
>>>  - it's kinda unusual use of offsetof(), perhaps i*sizeof() + sizeof()
>>> would be more understandable
>>>  - there is no guard against i == 0
>>
>> I don't see why a guard is needed?
> 
> Because there is no point to have a module loaded when there is none
> client to serve.
> 
>> *Your* code below needs it, but that
>> issue is not a concern for the original code.
> 
> I can admit that's not a big deal, just making logic slightly more robust.
> 
>> It might however be a
>> good idea to fail the probe if there are no clients to instantiate, but
>> that's a different issue...
> 
> That's what I have in mind.

Ah, but there is no reason what-so-ever for i being zero. The whole point
of the driver is for cases where i > 1. Or to put it bluntly, anyone
defining a struct i2c_inst_data with zero entries deserves to be punished...

>>> multi = devm_kmalloc(sizeof(*multi), GFP_KERNEL);
>>> if (!multi)
>>>  return -ENOMEM;
>>>
>>> multi->clients = devm_kcalloc(i, sizeof(*multi->clients), GFP_KERNEL);
>>> if (ZERO_PTR_OR_NULL(multi->clients))
>>>  return -ENOMEM;
>>>
>>> But I would like to hear your (other's) opinion(s).
>>
>> I think using two allocations is a waste in this case.
> 
> On the other hand it makes code more readable. With offsetof() it is a
> bit hard to get it on the first glance.

The driver is tiny, I think it's good if there is at least one thing that
can be a little bit interesting :-)

>>>> +               if (inst_data[i].irq_idx != -1) {
>>>
>>>> = 0 sounds more robust
>>
>> But not as flexible/future-proof. Why should 0 be the only valid IRQ index?
> 
> Ah, because > is used usually is a quoting character in email you
> missed the point.
> It was written as >= 0.

Ahh, good catch, that explains it.

Cheers,
Peter
