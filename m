From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v6 0/3] add support for Socionext SynQuacer I2C controller
Date: Tue, 3 Apr 2018 20:56:26 +0200
Message-ID: <CAKv+Gu9pMCAB1L0+8vO4w6yj_1O0fK_uyQboLzFfcbUMGjhsNw@mail.gmail.com>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180403150139.l7oec4doafmsidfp@ninjato>
 <CAKv+Gu9cqQqq_etTSvdBp4Jjk5O_0FePe74phDqt5EO6Cm-_vQ@mail.gmail.com>
 <20180403181216.f22vtkqrnxjgreuo@ninjato>
 <CAKv+Gu8R19T+9O2tODQeS9vtKANmBXgGcavkRdVRU0NmVtHn2w@mail.gmail.com>
 <20180403183219.htbg3w6mejmysoel@ninjato>
 <CAKv+Gu_GTmCr8att-_iQ5rD64gvaQC2FJ3cAmYpqRqp_OqPcAg@mail.gmail.com>
 <20180403184559.z5lixuheqd4ojoti@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180403184559.z5lixuheqd4ojoti@ninjato>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On 3 April 2018 at 20:45, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> We don't have suspend/resume support yet for this SoC, so I haven't
>> been able to try that. Also, the clocks are fixed in this particular
>> implementation, so the clk_xxx() calls don't actually do anything.
>
> Then please remove that, too! Good that I asked...
>

OK

> Frankly, not nice to make me review untested code without mentioning
> that fact somewhere :(
>

My apologies. I simply didn't think to remove it - I didn't write the
code, I am just the one upstreaming it.

> BTW are you willing to maintain this driver? Then an entry for
> MAINTAINERS would be needed.
>

OK, I will add that as well.
