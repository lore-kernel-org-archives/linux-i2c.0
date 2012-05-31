From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 2/3] i2c-nomadik: turn the platform driver to an amba
 driver
Date: Thu, 31 May 2012 18:16:54 +0800
Message-ID: <CACRpkdZpjn0RBGY+CqqSW3ip0MSQUJSaqN0GD=a4THnPHNM-jg@mail.gmail.com>
References: <cover.1338398567.git.rubini@gnudd.com>
 <349645b61d0b28f6e84f7ae1f2c8c28e12a11d92.1338398567.git.rubini@gnudd.com>
 <CACRpkdZ79=B8N7omxYY4UPotg8gYotfLeBRViYMr8hA-Uhie0w@mail.gmail.com>
 <4FC72DDF.7080209@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FC72DDF.7080209@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Alessandro Rubini <rubini@gnudd.com>, linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, STEricsson_nomadik_linux@list.st.com, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 31, 2012 at 4:37 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 31/05/12 02:51, Linus Walleij wrote:
>>
>> You will need some add-on patch to the db8500 device tree moving this
>> over to the AMBA (PrimeCell) bus abstraction.
>
> What does AMBA win us over the platform device here?

In Alessandro's case I guess it's that he can use his PCI-to-AMBA wrapper, and
there is no similar PCI-to platformdevice wrapper. So it saves some work
on his part.

But since the device has PrimeCell ID registers, this is really the
right thing to
do anyway, since autodetecting from hardware is allways NiceToDo(TM).
Else ST and us shouldn't have put the magic numbers (0xB105F00D) in there
anyway.

Yours,
Linus Walleij
