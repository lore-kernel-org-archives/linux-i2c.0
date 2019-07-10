From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [RFC] SW connection between DVB Transport Stream demuxer and
 I2C-based frontend
Date: Wed, 10 Jul 2019 17:07:34 +0200
Message-ID: <ae5896d2-3046-8c28-2419-c5a932050c95@free.fr>
References: <5e35b4fb-646d-6428-f372-ee47d7352cd6@free.fr>
 <7d47a978-5307-a2c8-acc2-f29ce7567bd5@axentia.se>
 <12b7118b-5118-cc43-2d0b-aff9650914a5@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <12b7118b-5118-cc43-2d0b-aff9650914a5@free.fr>
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
To: Peter Rosin <peda@axentia.se>, I2C <linux-i2c@vger.kernel.org>, linux-media <linux-media@vger.kernel.org>, GPIO <linux-gpio@vger.kernel.org>
Cc: Peter Korsgaard <peter@korsgaard.com>, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Brad Love <brad@nextdimension.cc>, =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>, Bjorn Andersson <bjorn.andersson@linaro.org>, Antti Palosaari <crope@iki.fi>, Simon Horman <horms+renesas@verge.net.au>, Mauro Carvalho Chehab <mchehab@kernel.org>, Olli Salonen <olli.salonen@iki.fi>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On 10/07/2019 15:52, Marc Gonzalez wrote:

> Your solution works great. It's refreshing to have stuff work
> out-of-the-box!

Arg! I spoke too soon. For some reason, si2157_init() is not being
called when it should. I'm trying to trace it down...
