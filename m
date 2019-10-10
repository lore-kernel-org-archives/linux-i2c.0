From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] i2c: aspeed: fix master pending state handling
Date: Thu, 10 Oct 2019 06:48:15 +0000
Message-ID: <CACPK8XfKCSNsQJa2J2jKZJ7LGZh3zXAOfBYnp5X0w=TH4JfSpQ@mail.gmail.com>
References: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, linux-aspeed <linux-aspeed@lists.ozlabs.org>, Wolfram Sang <wsa@the-dreams.de>, Andrew Jeffery <andrew@aj.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Brendan Higgins <brendanhiggins@google.com>, Rob Herring <robh+dt@kernel.org>, Cedric Le Goater <clg@kaod.org>, Tao Ren <taoren@fb.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 9 Oct 2019 at 21:20, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> In case of master pending state, it should not trigger a master
> command, otherwise data could be corrupted because this H/W shares
> the same data buffer for slave and master operations. It also means
> that H/W command queue handling is unreliable because of the buffer
> sharing issue. To fix this issue, it clears command queue if a
> master command is queued in pending state to use S/W solution
> instead of H/W command queue handling. Also, it refines restarting
> mechanism of the pending master command.
>
> Fixes: 2e57b7cebb98 ("i2c: aspeed: Add multi-master use case support")
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Acked-by: Joel Stanley <joel@jms.id.au>

While reviewing I was concerned about the locking in
aspeed_i2c_master_xfer. It's a bit hairy, and I am not convinced it is
without bugs.
