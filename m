From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v3 0/3] i2c: at91: add dma support
Date: Wed, 21 Nov 2012 10:45:56 +0100
Message-ID: <50ACA2D4.9040904@atmel.com>
References: <1352911493-6979-1-git-send-email-ludovic.desroches@atmel.com>
 <20121116170514.GA21903@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121116170514.GA21903@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: plagnioj@jcrosoft.com, ludovic.desroches@atmel.com, nicolas.ferre@atmel.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Sorry for the delay, I have realized that my answer was not sent =

correctly since I don't see it into the i2c archives.

Le 11/16/2012 06:05 PM, Wolfram Sang a =E9crit :
> Hi Ludovic,
>
>> Here is the third version taking into account your feedback.
>
> Thanks, looks mostly good. I have problems applying patch 3. What is
> this series based against?
>

It was based against v3.7-rc4. Do you want me to rebase it against an
over version?

>> Patch 1/3 should go into v3.7.
>
> No, not necessarily. It is not really a bugfix, and it is probably too
> late in the cycle for compiler silencing. Ah well, I decide later.
>
> BTW if you use --strict with checkpatch, it will tell you about the
> space after casts :)
>

Ok, thanks for the tips.

Regards

Ludovic

> Regards,
>
>     Wolfram
>
