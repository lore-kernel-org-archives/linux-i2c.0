From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH i2c-next v7 4/5] i2c: aspeed: Remove hard-coded bus
 timeout value setting
Date: Tue, 9 Oct 2018 17:00:48 -0700
Message-ID: <CAFd5g44vi55oMkif1K+hx=O_J0_jqeQunRNiDARF0=qJ=54jiw@mail.gmail.com>
References: <20181005214507.26315-1-jae.hyun.yoo@linux.intel.com> <20181005214507.26315-5-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005214507.26315-5-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, devicetree <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-aspeed@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jarkko.nikula@linux.intel.com, james.feist@linux.intel.com, vernon.mauery@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 5, 2018 at 2:45 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit removes hard-coded bus timeout value setting so that
> it can be set by i2c-core-base.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
