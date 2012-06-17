From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Fwd: [PATCH 1/3] i2c: Add Device Tree support to the Nomadik I2C
 driver
Date: Sun, 17 Jun 2012 19:43:13 +0200
Message-ID: <CACRpkdZ7ESKhokk8Z+6sC9Kq+jPztFNwzger0Db7nCD1fPnG1A@mail.gmail.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
 <4FD8BAD2.50703@linaro.org>
 <CACRpkdZFi34nChnMEo6yik67zk9owZLk-6zcdP7mmOXyLz8uqQ@mail.gmail.com>
 <4FDAFA17.6050502@linaro.org>
 <CAE2-_9rRYxjU9QQgtBv9ReMY5x+oRiJG1cDQahYHanjDrwVUYA@mail.gmail.com>
 <20120615115042.GA27480@bnru02> <4FDB2E57.4030904@linaro.org>
 <20120615130544.GA28537@bnru02> <4FDB3642.5030804@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FDB3642.5030804@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Linus WALLEIJ <linus.walleij@stericsson.com>, "arnd@arndb.de" <arnd@arndb.de>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Gah, what a thread...

On Fri, Jun 15, 2012 at 3:18 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On 15/06/12 14:05, Srinidhi Kasagar wrote:
>> On Fri, Jun 15, 2012 at 14:45:11 +0200, Lee Jones wrote:
>>> On 15/06/12 12:50, Srinidhi Kasagar wrote:

>>>>> +static struct nmk_i2c_controller u8500_i2c =3D {
>>>>> + =A0 =A0 =A0 /*
>>>>> + =A0 =A0 =A0 =A0* Slave data setup time; 250ns, 100ns, and 10ns, whi=
ch
>>>>> + =A0 =A0 =A0 =A0* is 14, 6 and 2 respectively for a 48Mhz i2c clock.
>>>>> + =A0 =A0 =A0 =A0*/
>>>>> + =A0 =A0 =A0 .slsu =A0 =A0 =A0 =A0 =A0 =3D 0xe,
>>>>> + =A0 =A0 =A0 .tft =A0 =A0 =A0 =A0 =A0 =A0=3D 1, =A0 =A0 =A0/* Tx FIF=
O threshold */
>>>>> + =A0 =A0 =A0 .rft =A0 =A0 =A0 =A0 =A0 =A0=3D 8, =A0 =A0 =A0/* Rx FIF=
O threshold */
>>>>> + =A0 =A0 =A0 .clk_freq =A0 =A0 =A0 =3D 100000, /* std. mode operatio=
n */
>>>>> + =A0 =A0 =A0 .timeout =A0 =A0 =A0 =A0=3D 200, =A0 =A0/* Slave respon=
se timeout(ms) */
>>>>> + =A0 =A0 =A0 .sm =A0 =A0 =A0 =A0 =A0 =A0 =3D I2C_FREQ_MODE_FAST,
>>>>
>>>> How is this possible? you are setting clk_freq as 100kb/s and mode
>>>> as fast mode which is supposed to be 400kb/s.
>>>
>>> That's not how I read it:
>>
>>
>> But it is not readable. It confuses people.
>
> I understood it. :)
>
> If you think it's unclear speak to the author, Linus. He's CC'ed.

Author of what? The i2c driver was written by Srinidhi. (The
MODULE_AUTHOR() clause should be a good hint...)

But it's true that board data for the ux500 kernel use
100000 Hz and I2C_FREQ_MODE_FAST, in the board-mop500.c
file, like this:

U8500_I2C_CONTROLLER(0, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
U8500_I2C_CONTROLLER(1, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
U8500_I2C_CONTROLLER(2, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
U8500_I2C_CONTROLLER(3, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);

This is indeed a bit odd. But obviously it works... But reading some
fixes in another tree it seems it should look like this:

/*
 * The board uses 4 i2c controllers, initialize all of
 * them with slave data setup time of 250 ns,
 * Tx & Rx FIFO threshold values as 1 and standard
 * mode of operation
 */
U8500_I2C_CONTROLLER(0, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
U8500_I2C_CONTROLLER(1, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
U8500_I2C_CONTROLLER(2, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
U8500_I2C_CONTROLLER(3, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);

Which makes *much* more sense.

I'll cook a separate patch for this or something.

Thanks,
Linus Walleij
