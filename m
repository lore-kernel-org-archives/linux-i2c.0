From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH v3] i2c: mux: remove duplicated i2c_algorithm
Date: Sun, 18 Nov 2018 12:13:51 +0100
Message-ID: <205e1d73-2318-ecd4-c531-3ff18a0e0005@lucaceresoli.net>
References: <20181003151928.17713-1-lucaceresoli77@gmail.com>
 <99cfa6a2-9a60-6bdd-2542-9dd78af75758@axentia.se>
 <70c48ade-b2ac-dde8-4b3e-aa4b2f19940a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <70c48ade-b2ac-dde8-4b3e-aa4b2f19940a@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Ceresoli <lucaceresoli77@gmail.com>, Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

On 10/10/18 17:48, Luca Ceresoli wrote:
> Hi Peter,
> 
> On 08/10/2018 23:43, Peter Rosin wrote:
>> On 2018-10-03 17:19, Luca Ceresoli wrote:
>>> From: Luca Ceresoli <luca@lucaceresoli.net>
>>>
>>> i2c-mux instantiates one i2c_algorithm for each downstream adapter.
>>> However these algorithms are all identical, depending only on the
>>> parent adapter.
>>>
>>> Avoid duplication by hoisting the i2c_algorithm from the adapters to
>>> the i2c_mux_core object, and reuse it in all the adapters.
>>
>> Ouch, while I like the concept of having one i2c_algorithm per mux,
>> this patch is not working. Various i2c-mux drivers set the
>> muxc->mux_locked variable *after* the i2c_mux_alloc call, and this
>> patch breaks such use.

I finally had a look into this issue. Three drivers are setting
mux_locked after i2c_mux_alloc: i2c-mux-gpmux, i2c-mux-gpio and
i2c-mux-pinctrl.

i2c-mux-gpmux is trivial to fix.

The other two are not trivial because:

 1. they compute mux_locked from other variables
 2. those variables are stored in the drivers "private" data
 3. their private data is stored inside struct i2c_mux_core
    (muxc->priv) which exists only after i2c_mux_alloc()

In those cases computing mux_locked before i2c_mux_alloc() involves
quite invasive changes. It took 3 non-trivial commits just for
i2c-mux-gpio, and I still have to look into i2c-mux-pinctrl.

So the question is: do we really want to do this?

Using the private storage provided by i2c_mux_alloc() is a handy
feature, at least for simpler drivers which know in advance the flags
they need to set. OTOH I don't like individual drivers to manipulate
mux_core flags that look very much like internal data. It makes any
change to the i2c mux core harder, since every changed line could have
side effects in some drivers, which is what's happening here.

What's your opinion about this issue?

Thanks,
-- 
Luca
