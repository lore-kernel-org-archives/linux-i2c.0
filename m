From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 36/62] i2c: irq: Remove IRQF_DISABLED
Date: Sun, 11 Sep 2011 23:36:25 +0200
Message-ID: <CACRpkdbL2XOPu63r5=twSSs+TvPEvD9S8M7yYAcTP6HJ4MLvJg@mail.gmail.com>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
	<1315383059-3673-37-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315383059-3673-37-git-send-email-yong.zhang0@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, linux-i2c@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>, Kukjin Kim <kgene.kim@samsung.com>, mingo@elte.hu, Alessandro Rubini <rubini@unipv.it>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, uclinux-dist-devel@blackfin.uclinux.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@stericsson.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, STEricsson <STEricsson_nomadik_linux@list.st.com>, Joe Perches <joe@perches.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 7, 2011 at 10:10 AM, Yong Zhang <yong.zhang0@gmail.com> wrote:

> This flag is a NOOP and can be removed now.
>
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
