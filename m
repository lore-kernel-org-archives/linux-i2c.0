From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v6 0/3] add support for Socionext SynQuacer I2C controller
Date: Tue, 3 Apr 2018 20:14:04 +0200
Message-ID: <CAKv+Gu8R19T+9O2tODQeS9vtKANmBXgGcavkRdVRU0NmVtHn2w@mail.gmail.com>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180403150139.l7oec4doafmsidfp@ninjato>
 <CAKv+Gu9cqQqq_etTSvdBp4Jjk5O_0FePe74phDqt5EO6Cm-_vQ@mail.gmail.com>
 <20180403181216.f22vtkqrnxjgreuo@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180403181216.f22vtkqrnxjgreuo@ninjato>
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

On 3 April 2018 at 20:12, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Yeah, good point. So when exactly should this be called? Only on error
>> conditions that could be caused by a misbehaving slave?
>
> Chapter 3.1.16 of the I2C specification, only when a slave keeps SDA
> low. Usually you detect that before you start transmitting.
>
> Really, please remove it for now and add it later, properly tested!
>

OK, I will remove it for now.

> BTW what kind of tests did you do with this driver so far?
>

I have used it with a ATSHA204A crypto chip, using a userland driver
and i2c-dev, and with a NXP PCF8563 RTC using the kernel driver.
