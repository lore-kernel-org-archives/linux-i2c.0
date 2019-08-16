From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 1/7] [RFC] ARM: remove Intel iop33x and iop13xx support
Date: Fri, 16 Aug 2019 18:42:49 +0300
Message-ID: <20190816154249.GA30291@darkstar.musicnaut.iki.fi>
References: <20190809162956.488941-1-arnd@arndb.de>
 <20190809163334.489360-1-arnd@arndb.de>
 <CAA9_cmdDbBm0ookyqGJMcyLVFHkYHuR3mEeawQKS2UqYJoWWaQ@mail.gmail.com>
 <20190812094456.GI10598@jirafa.cyrius.com>
 <CACRpkdao8LF8g5qi_h+9BT9cHwmB4OadabkdGfP0sEFeLbmiLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdao8LF8g5qi_h+9BT9cHwmB4OadabkdGfP0sEFeLbmiLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, Peter Teichmann <lists@peter-teichmann.de>, Arnd Bergmann <arnd@arndb.de>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, soc@kernel.org, Russell King <linux@armlinux.org.uk>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vinod Koul <vkoul@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Wed, Aug 14, 2019 at 10:36:01AM +0200, Linus Walleij wrote:
> On Mon, Aug 12, 2019 at 11:45 AM Martin Michlmayr <tbm@cyrius.com> wrote:
> > As Arnd points out, Debian used to have support for various iop32x
> > devices.  While Debian hasn't supported iop32x in a number of years,
> > these devices are still usable and in use (RMK being a prime example).
> 
> I suppose it could be a good idea to add support for iop32x to
> OpenWrt and/or OpenEmbedded, both of which support some
> pretty constrained systems.

This platform is not really too constrained... E.g. on N2100 you have
512 MB RAM, SATA disks and gigabit ethernet. Not that different from
mvebu that Debian currently (?) supports. Maybe with multiplatform they
could support iop32x again.

A.
