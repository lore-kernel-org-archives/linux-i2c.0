From: Sagar Kadam <sagar.kadam@sifive.com>
Subject: Re: [PATCH v6 3/3] i2c-ocores: sifive: add polling mode workaround
 for FU540-C000 SoC.
Date: Wed, 22 May 2019 10:28:58 +0530
Message-ID: <CAARK3HnTkpkH9rP4oW456V6KYsCah7-gAXdjm5+3cLwJaPs6tg@mail.gmail.com>
References: <1558445574-16471-1-git-send-email-sagar.kadam@sifive.com>
 <1558445574-16471-4-git-send-email-sagar.kadam@sifive.com>
 <20190521135439.GM22024@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190521135439.GM22024@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, peter@korsgaard.com, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,

On Tue, May 21, 2019 at 7:24 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> >  static void ocores_process_polling(struct ocores_i2c *i2c)
> >  {
> > +     const struct of_device_id *match;
> > +
> > +     match = of_match_node(ocores_i2c_match, i2c->adap.dev.of_node);
> > +
> >       while (1) {
> >               irqreturn_t ret;
> >               int err;
>
> Please keep with the idea of i2c->flags, which is set during probe.
> Just because it was removed because it was no longer needed does not
> stop you from putting it back again if it is needed.
>
I had modified the implementation, so as to keep it compatible with
the new implementation of polling mode.
As per your suggestion, I will keep the older method (the v5 version
which you Reviewed earlier : https://lkml.org/lkml/2019/5/20/1261)
 and submit a v7 for this.

>        Andrew

Thanks & Regards,
Sagar
