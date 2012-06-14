From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 2/3] i2c-nomadik: turn the platform driver to an amba
 driver
Date: Thu, 14 Jun 2012 08:04:38 +0000
Message-ID: <201206140804.39083.arnd@arndb.de>
References: <cover.1339447570.git.rubini@gnudd.com>
 <4a198618063924b68182279ffd56c335d621f542.1339447570.git.rubini@gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4a198618063924b68182279ffd56c335d621f542.1339447570.git.rubini@gnudd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Alessandro Rubini <rubini@gnudd.com>, linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, STEricsson_nomadik_linux@list.st.com, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Lee Jones <lee.jones@linaro.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Monday 11 June 2012, Alessandro Rubini wrote:
> The i2c-nomadik gateware is really a PrimeCell APB device. By hosting
> the driver under the amba bus we can access it more easily, for
> example using the generic pci-amba driver. The patch also fixes the
> mach-ux500 users, so they register an amba device instead than a
> platform device.
> 
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/devices-common.h |   22 +----
>  drivers/i2c/busses/i2c-nomadik.c     |  142 +++++++++++++++++----------------
>  2 files changed, 78 insertions(+), 86 deletions(-)

You change only one half of ux500 here: the part where the device gets defined
statically, but not not the definition in the device-tree.

I think all you need to do is mark the device compatible with primecell
and add an ID if necessary, but we should definitely make sure that that
path still works, because the one you patch is going away.

	Arnd
