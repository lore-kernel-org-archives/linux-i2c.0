From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH] i2c: aspeed: fixed invalid clock parameters for very
 large divisors
Date: Fri, 21 Sep 2018 15:18:31 -0700
Message-ID: <CAFd5g455kDnOQfkZK=U-gs2JrPVXdnA0GViRuWEcHrvjFASOEw@mail.gmail.com>
References: <20180920232820.243734-1-brendanhiggins@google.com> <07af0253-1efc-2ae1-93fb-ebcc1996d768@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <07af0253-1efc-2ae1-93fb-ebcc1996d768@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, linux-aspeed@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 21, 2018 at 10:46 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> Hi Brendan,
>
> nit:
> Title in imperative mood. I'd put 'fix' instead of 'fixed'.
>
<snip>
>
> One minor issue is, 'base_clk_divisor' instead of 'base_clk' could avoid
> misreading on this code.
>
> With that, it looks nice to me. Thanks!
>
> Reviewed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Thanks for the review!
