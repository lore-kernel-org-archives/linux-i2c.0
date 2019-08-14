From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] [RFC] ARM: remove Intel iop33x and iop13xx support
Date: Wed, 14 Aug 2019 12:48:23 +0200
Message-ID: <CAK8P3a3Jtc-hgP+st=oDUF2hWkLK7CCM461YSA2ks3dqcv-W7g@mail.gmail.com>
References: <20190809162956.488941-1-arnd@arndb.de> <20190809163334.489360-1-arnd@arndb.de>
 <CAA9_cmdDbBm0ookyqGJMcyLVFHkYHuR3mEeawQKS2UqYJoWWaQ@mail.gmail.com>
 <20190812094456.GI10598@jirafa.cyrius.com> <CACRpkdao8LF8g5qi_h+9BT9cHwmB4OadabkdGfP0sEFeLbmiLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdao8LF8g5qi_h+9BT9cHwmB4OadabkdGfP0sEFeLbmiLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, Dan Williams <dan.j.williams@intel.com>, soc@kernel.org, Russell King <linux@armlinux.org.uk>, Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Peter Teichmann <lists@peter-teichmann.de>
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 14, 2019 at 10:36 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Aug 12, 2019 at 11:45 AM Martin Michlmayr <tbm@cyrius.com> wrote:
>
> > As Arnd points out, Debian used to have support for various iop32x
> > devices.  While Debian hasn't supported iop32x in a number of years,
> > these devices are still usable and in use (RMK being a prime example).
>
> I suppose it could be a good idea to add support for iop32x to
> OpenWrt and/or OpenEmbedded, both of which support some
> pretty constrained systems. I am personally using these
> distributions to support elder ARM hardware these days.

OpenWRT also had support in the past and dropped it around the
same time as Debian. The way I understand it, a couple of platforms
including iop32x were moved out of the main openwrt source tree
into https://github.com/openwrt/targets/ because there was little
interest in keeping them running.

The idea was that any remaining users could add that feed to get
minimal support, but I'm not sure if would still work. In particular,
iop33x appears to be based on linux-3.3 plus three patches that
are no longer needed in mainline. Building a mainline kernel without
those patches may or may not work.

        Arnd
