From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: i2c: jz4780: silence log flood on txabrt
Date: Wed, 12 Feb 2020 15:59:55 +0100
Message-ID: <0C9F4243-159B-418C-B481-4B45B210F9F6@goldelico.com>
References: <cover.1581457290.git.hns@goldelico.com> <7facef52af9cff6ebe26ff321a7fd4f1ac640f74.1581457290.git.hns@goldelico.com> <20200212094628.GB1143@ninjato> <213C52CC-E5DC-4641-BE68-3D5C4FEA1FB5@goldelico.com> <20200212145356.GB2492@ninjato>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-owner@vger.kernel.org>
In-Reply-To: <20200212145356.GB2492@ninjato>
Sender: linux-mips-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Paul Cercueil <paul@crapouillou.net>, Paul Boddie <paul@boddie.org.uk>, Alex Smith <alex.smith@imgtec.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "David S. Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Andi Kleen <ak@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Miquel Raynal <miquel.raynal@bootlin.com>, =?utf-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>, Richard Fontana <rfontana@redhat.com>, Allison Randal <allison@lohutok.net>, Stephen Boyd <swboyd@chro>
List-Id: linux-i2c@vger.kernel.org


> Am 12.02.2020 um 15:53 schrieb Wolfram Sang <wsa@the-dreams.de>:
> 
> Hi,
> 
>>> Sorry, normally I don't do counter patches. Yet, this time I realized
>>> that it would be faster to actually do what I envisioned than to
>>> describe it in words. I hope you don't feel offended.
>> 
>> No problem. I had thought a little about that myself, but did not
>> dare to solve more than my problem...
> 
> Glad you like it. Well, it still kinda solves your problem only, because
> there are still too many dev_err in there, but I think this is good
> enough for now.
> 
>>> Obviously, I can't test, does it work for you?
>> 
>> Yes,it works.
> 
> Good!
> 
>> Do you want to push your patch yourself, or should I add it to my
>> patch series and resubmit in a v2?
> 
> I'll apply the patch to my tree directly as a bugfix for 5.6. You can
> drop the I2C list from V2 then.

Ok, fine.

BR and thanks,
Nikolaus
