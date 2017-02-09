From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] of: fix of_node leak caused in of_find_node_opts_by_path
Date: Thu, 9 Feb 2017 09:11:16 -0600
Message-ID: <CAL_JsqJ210Nfwpi=pstTo+E8nTowVdLaMFNjd5rwSUpEcKcNJg@mail.gmail.com>
References: <1486356919-97176-1-git-send-email-qi.hou@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1486356919-97176-1-git-send-email-qi.hou@windriver.com>
Sender: stable-owner@vger.kernel.org
To: Qi Hou <qi.hou@windriver.com>
Cc: Peter Rosin <peda@axentia.se>, stable <stable@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Grant Likely <grant.likely@linaro.org>, Bruce Ashfield <bruce.ashfield@windriver.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, ZhangXiao <xiao.zhang@windriver.com>
List-Id: linux-i2c@vger.kernel.org

On Sun, Feb 5, 2017 at 10:55 PM, Qi Hou <qi.hou@windriver.com> wrote:
> During stepping down the tree, parent node is gotten first and its refcount is
> increased with of_node_get() in __of_get_next_child(). Since it just being used
> as tmp node, its refcount must be decreased with of_node_put() after traversing
> its child nodes.
>
> Or, its refcount will never be descreased to ZERO, then it will never be freed,
> as well as other related memory blocks.
>
> To fix this, decrease refcount of parent with of_node_put() after
> __of_find_node_by_path().
>
> Signed-off-by: Qi Hou <qi.hou@windriver.com>
> Acked-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/of/base.c | 3 +++
>  1 file changed, 3 insertions(+)

It doesn't look like there is any inter-dependency with this patch and
the other 2, so I'll apply this one.

Rob
