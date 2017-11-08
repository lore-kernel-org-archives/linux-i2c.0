From: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] ARM: sa1100: simpad: Correct I2C GPIO offsets
Date: Wed, 8 Nov 2017 09:40:56 +0100
Message-ID: <24888cd2-e3ef-2f34-4c0c-c7e620f5e3e0@scram.de>
References: <20171107151703.3847-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171107151703.3847-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Wolfram Sang <w.sang@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

 > Jochen: did this ever work? I suspect the patch was simply developed 
on top of a different kernel.

This really was developed on top of a much older kernel. I didn't test 
this for a while now as on my Simpad, the touch screen died a while ago 
(mainly returning random position data), so the device is useless...

Cheers, Jochen
