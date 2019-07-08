From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [RFC] SW connection between DVB Transport Stream demuxer and
 I2C-based frontend
Date: Mon, 8 Jul 2019 21:10:20 +0200
Message-ID: <bb66e283-477b-38f1-cc0d-95ee94b70dc2@metux.net>
References: <5e35b4fb-646d-6428-f372-ee47d7352cd6@free.fr>
 <b6abf5a2-3151-29e5-8eb7-c960580fd4ea@metux.net>
 <79b9bd5e-be05-daa8-0d16-d84a383138a7@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <79b9bd5e-be05-daa8-0d16-d84a383138a7@free.fr>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Gonzalez <marc.w.gonzalez@free.fr>, I2C <linux-i2c@vger.kernel.org>, linux-media <linux-media@vger.kernel.org>, GPIO <linux-gpio@vger.kernel.org>
Cc: Peter Korsgaard <peter@korsgaard.com>, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Brad Love <brad@nextdimension.cc>, =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>, Bjorn Andersson <bjorn.andersson@linaro.org>, Antti Palosaari <crope@iki.fi>, Simon Horman <horms+renesas@verge.net.au>, Mauro Carvalho Chehab <mchehab@kernel.org>, Olli Salonen <olli.salonen@iki.fi>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On 08.07.19 17:03, Marc Gonzalez wrote:

> One problem is that since the internal bus is "created" (declared?) at run-time,
> it doesn't seem possible to define it (or its client) in DT.

Maybe declare it nested inside the si2168 device ?
The driver then needs a piece of glue code for triggering device probing
on that bus. (so, it really needs to provide a full blown i2c driver ?)

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
