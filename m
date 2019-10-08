From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH 3/5] i2c: aspeed: fix master pending state handling
Date: Tue, 8 Oct 2019 14:54:23 -0700
Message-ID: <CAFd5g47vLN6NyZR73+EqOqfOPnM7CkGGsCwEn3udnJt99d8KCg@mail.gmail.com>
References: <20191007231313.4700-1-jae.hyun.yoo@linux.intel.com>
 <20191007231313.4700-4-jae.hyun.yoo@linux.intel.com>
 <20191008203157.GA184092@google.com>
 <ac256b3f-2a06-6fa5-72ab-d8f8014d253e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ac256b3f-2a06-6fa5-72ab-d8f8014d253e@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, Joel Stanley <joel@jms.id.au>, Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, Tao Ren <taoren@fb.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 8, 2019 at 2:13 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> On 10/8/2019 1:31 PM, Brendan Higgins wrote:
> > On Mon, Oct 07, 2019 at 04:13:11PM -0700, Jae Hyun Yoo wrote:
> >> In case of master pending state, it should not trigger the master
> >> command because this H/W is sharing the same data buffer for slave
> >> and master operations, so this commit fixes the issue with making
> >> the master command triggering happen when the state goes to active
> >> state.
> >
> > nit: Makes sense, but can you explain what might happen without your
> > change?
>
> If we don't use this fix, a master command could corrupt data in the
> shared buffer if H/W is still on processing slave operation at the
> timing.

Right, can you add that to the commit message?

Is this trivially reproducible? We might want to submit this
separately as a bugfix.

Actually yeah, can you send this separately as a bugfix? I think we
might want to include this in 5.4.

Wolfram and Joel, what do you think?
