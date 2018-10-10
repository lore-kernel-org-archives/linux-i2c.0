From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH i2c-next v7 5/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
Date: Tue, 9 Oct 2018 17:08:00 -0700
Message-ID: <CAFd5g45JkK4BnGR7yOA3eCazTZ86FyUaNdi81Ew6VBbKxS3EZA@mail.gmail.com>
References: <20181005214507.26315-1-jae.hyun.yoo@linux.intel.com> <20181005214507.26315-6-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005214507.26315-6-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, devicetree <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-aspeed@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jarkko.nikula@linux.intel.com, james.feist@linux.intel.com, vernon.mauery@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 5, 2018 at 2:45 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> In multi-master environment, this driver's master cannot know
> exactly when peer master sends data to this driver's slave so a
> case can be happened that this master tries to send data through
> the master_xfer function but slave data from peer master is still
> being processed by this driver.
>
> To prevent any state corruption in the case, this patch adds
> checking code if any slave operation is ongoing and it waits up to
> the bus timeout duration before starting a master_xfer operation.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
