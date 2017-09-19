From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 1/7] i2c: gpio: Convert to use descriptors
Date: Tue, 19 Sep 2017 10:19:52 +0100
Message-ID: <42702eb3-d1dd-5dd0-dbd6-ac163bcc27c2@codethink.co.uk>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-2-linus.walleij@linaro.org>
 <20170918083629.qn4dlrmk7ffipfsz@dell>
 <CACRpkdb8jDRZxuTUNoosLORqDbF4PP4RSHj3avtUqzvW2RwpmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdb8jDRZxuTUNoosLORqDbF4PP4RSHj3avtUqzvW2RwpmQ@mail.gmail.com>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>
Cc: Linux MIPS <linux-mips@linux-mips.org>, Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>, Steven Miao <realmz6@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, adi-buildroot-devel@lists.sourceforge.net, Ralf Baechle <ralf@linux-mips.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Heiko Schocher <hs@denx.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On 18/09/17 20:00, Linus Walleij wrote:
> On Mon, Sep 18, 2017 at 10:36 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> On Sun, 17 Sep 2017, Linus Walleij wrote:
> 
>>> Lee: requesting ACK for Wolfram to take this patch.
>>
>> This ...
>>
>>> SM501 users: requesting Tested-by on this patch.
>>
>> ... loosely depends on this (until it doesn't).
> 
> Yeah I did my best to scout around the commit logs
> to figure out who's been contributing to the SM501 and
> using it, I hope someone will step up and test it.

I don't know if anything I have available working has an
SM501 on it. We did a couple of boards with S3C2440 and
an SM501 connected via external IO. However these have
not been supported in years (since Simtec)

I don't even think I have the PCI SM501 kit, that may have
ended up either at Simtec or one of the other engineers.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
