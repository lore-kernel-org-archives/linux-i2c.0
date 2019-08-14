From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/7] [RFC] ARM: remove Intel iop33x and iop13xx support
Date: Wed, 14 Aug 2019 10:36:01 +0200
Message-ID: <CACRpkdao8LF8g5qi_h+9BT9cHwmB4OadabkdGfP0sEFeLbmiLw@mail.gmail.com>
References: <20190809162956.488941-1-arnd@arndb.de> <20190809163334.489360-1-arnd@arndb.de>
 <CAA9_cmdDbBm0ookyqGJMcyLVFHkYHuR3mEeawQKS2UqYJoWWaQ@mail.gmail.com> <20190812094456.GI10598@jirafa.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812094456.GI10598@jirafa.cyrius.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>, soc@kernel.org, Russell King <linux@armlinux.org.uk>, Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Peter Teichmann <lists@peter-teichmann.de>
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 12, 2019 at 11:45 AM Martin Michlmayr <tbm@cyrius.com> wrote:

> As Arnd points out, Debian used to have support for various iop32x
> devices.  While Debian hasn't supported iop32x in a number of years,
> these devices are still usable and in use (RMK being a prime example).

I suppose it could be a good idea to add support for iop32x to
OpenWrt and/or OpenEmbedded, both of which support some
pretty constrained systems. I am personally using these
distributions to support elder ARM hardware these days.

Just my =E2=82=AC0.01
Linus Walleij
