From: qhou <qi.hou@windriver.com>
Subject: Re: [PATCH 1/3] of: fix of_node leak caused in
 of_find_node_opts_by_path
Date: Fri, 10 Feb 2017 09:15:21 +0800
Message-ID: <d6b700db-7d94-eb93-3b89-3982b8670cd1@windriver.com>
References: <1486356919-97176-1-git-send-email-qi.hou@windriver.com>
 <CAL_JsqJ210Nfwpi=pstTo+E8nTowVdLaMFNjd5rwSUpEcKcNJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJ210Nfwpi=pstTo+E8nTowVdLaMFNjd5rwSUpEcKcNJg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, stable <stable@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Grant Likely <grant.likely@linaro.org>, Bruce Ashfield <bruce.ashfield@windriver.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, ZhangXiao <xiao.zhang@windriver.com>
List-Id: linux-i2c@vger.kernel.org


On 2017年02月09日 23:11, Rob Herring wrote:
> On Sun, Feb 5, 2017 at 10:55 PM, Qi Hou <qi.hou@windriver.com> wrote:
>> During stepping down the tree, parent node is gotten first and its refcount is
>> increased with of_node_get() in __of_get_next_child(). Since it just being used
>> as tmp node, its refcount must be decreased with of_node_put() after traversing
>> its child nodes.
>>
>> Or, its refcount will never be descreased to ZERO, then it will never be freed,
>> as well as other related memory blocks.
>>
>> To fix this, decrease refcount of parent with of_node_put() after
>> __of_find_node_by_path().
>>
>> Signed-off-by: Qi Hou <qi.hou@windriver.com>
>> Acked-by: Peter Rosin <peda@axentia.se>
>> ---
>>   drivers/of/base.c | 3 +++
>>   1 file changed, 3 insertions(+)
> It doesn't look like there is any inter-dependency with this patch and
> the other 2, so I'll apply this one.
No, there is no inter-dependency in these three patches.

Just since they are all related with of_node_put and reported by 
kmemleak and debugged
by the similar means, I sent them together.

-- Best regards,
Qi Hou
>
> Rob
