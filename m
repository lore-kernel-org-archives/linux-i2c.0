From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH RFC 1/3] i2c-nomadik: move header from <plat/i2c.h> to
 <linux/i2c-nomadik.h>
Date: Thu, 31 May 2012 09:37:15 +0100
Message-ID: <4FC72DBB.6030601@codethink.co.uk>
References: <cover.1338398567.git.rubini@gnudd.com>
 <ca47a47e0a4db31545549ed978e1dc7b3aad4377.1338398567.git.rubini@gnudd.com>
 <CACRpkdY_bg5s_eKot8Ywbmb+SmixsJOSJW_jWjjenedjJng4Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdY_bg5s_eKot8Ywbmb+SmixsJOSJW_jWjjenedjJng4Jg@mail.gmail.com>
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
Cc: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Alessandro Rubini <rubini@gnudd.com>, linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On 31/05/12 02:47, Linus Walleij wrote:
> On Thu, May 31, 2012 at 1:45 AM, Alessandro Rubini<rubini@gnudd.com>  wrote:
>
>> The header and driver were only used by arm/mach-nomadik and
>> arm/mach-u8500.  The STA2X11 I/O Hub exports on PCIe a number of
>> devices, including i2c-nomadik.  This patch allows compilation of
>> the driver under x86.
>>
>> Signed-off-by: Alessandro Rubini<rubini@gnudd.com>
>> Acked-by: Giancarlo Asnaghi<giancarlo.asnaghi@st.com>
>
> The new place to put pure platform data headers is:
> include/linux/platform_data/i2c-nomadik.h so please use this.

Aha, didn't see your reply before making mine.

> Pls use git format-patch -M so we get a nice movement patch
> without all the -/+ lines. (No big deal though.)

Agreed, useful for when actually submitting.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
