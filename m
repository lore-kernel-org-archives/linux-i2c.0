From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH RFC 2/3] i2c-nomadik: turn the platform driver to an amba
 driver
Date: Thu, 31 May 2012 09:37:51 +0100
Message-ID: <4FC72DDF.7080209@codethink.co.uk>
References: <cover.1338398567.git.rubini@gnudd.com>
 <349645b61d0b28f6e84f7ae1f2c8c28e12a11d92.1338398567.git.rubini@gnudd.com>
 <CACRpkdZ79=B8N7omxYY4UPotg8gYotfLeBRViYMr8hA-Uhie0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdZ79=B8N7omxYY4UPotg8gYotfLeBRViYMr8hA-Uhie0w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Alessandro Rubini <rubini@gnudd.com>, linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, STEricsson_nomadik_linux@list.st.com, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On 31/05/12 02:51, Linus Walleij wrote:
> On Thu, May 31, 2012 at 1:45 AM, Alessandro Rubini<rubini@gnudd.com>  wrote:
>
>> The i2c-nomadik gateware is really a PrimeCell APB device. By hosting
>> the driver under the amba bus we can access it more easily, for
>> example using the generic pci-amba driver. The patch also fixes the
>> mach-ux500 users to register an AMBA device, not a platform device.
>>
>> Signed-off-by: Alessandro Rubini<rubini@gnudd.com>
>> Acked-by: Giancarlo Asnaghi<giancarlo.asnaghi@st.com>
>> Cc: Srinidhi Kasagar<srinidhi.kasagar@stericsson.com>
>> Cc: STEricsson_nomadik_linux@list.st.com
>> Cc: Linus Walleij<linus.walleij@stericsson.com>
>
> This will affect Lee Jones' device tree bindings for the same device.
>
> You will need some add-on patch to the db8500 device tree moving this
> over to the AMBA (PrimeCell) bus abstraction.

What does AMBA win us over the platform device here?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
