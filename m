From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c: let the core register devices from devicetree
Date: Thu, 14 Jun 2012 12:42:24 +0200
Message-ID: <20120614124224.58a9e823@endymion.delvare>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@st.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Haojian Zhuang <haojian.zhuang@marvell.com>, Grant Likely <grant.likely@secretlab.ca>, Laxman Dewangan <ldewangan@nvidia.com>, linux-i2c@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>, Barry Song <21cnbao@gmail.com>, Jochen Friedrich <jochen@scram.de>, Deepak Sikri <deepak.sikri@st.com>, Li Yang <leoli@freescale.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Vitaly Wool <vitalywool@gmail.com>, Wolfram Sang <wolfram@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, Tang Yuantian <B29983@freescale.com>, Olof Johansson <olof@lixom.net>, Magnus Damm <damm@opensource>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, 13 Jun 2012 23:12:10 +0200, Wolfram Sang wrote:
> Currently, every driver has to do it on its own, but it should be done
> in the core, like we already do with board_info structs.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> 
> Based on v3.5-rc2. Only build tested, I don't have a OF based device
> around at the moment.
> (...)
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index a6ad32b..4791833 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -39,6 +39,7 @@
>  #include <linux/irqflags.h>
>  #include <linux/rwsem.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/of_i2c.h>
>  #include <asm/uaccess.h>
>  
>  #include "i2c-core.h"
> @@ -880,6 +881,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  #endif
>  
>  	/* create pre-declared device nodes */
> +	of_i2c_register_devices(adap);
> +
>  	if (adap->nr < __i2c_first_dynamic_bus_num)
>  		i2c_scan_static_board_info(adap);
>  

This was proposed in the past, and rejected because of dependency
issues. I don't think the situation changed. of_i2c needs i2c-core for
i2c_new_device(), and with the change above, i2c-core needs of_i2c for
of_i2c_register_devices(). If either is built as a module, it will fail.

This might be the reason why of_spi ended up being merged into
drivers/spi according to Grant? I have no objection to the same being
done for of_i2c if it makes everybody happy, as long as it does not
create additional dependencies (i.e. I2C should not depend on OF.)

-- 
Jean Delvare
