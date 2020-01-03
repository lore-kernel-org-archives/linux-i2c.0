From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 5/5] i2c: Enable compile testing for some of drivers
Date: Fri, 3 Jan 2020 14:42:31 +0100
Message-ID: <20200103134231.GA2095@pi3>
References: <20191230172751.17985-1-krzk@kernel.org>
 <20191230172751.17985-5-krzk@kernel.org>
 <CAMuHMdUXJo3=x32xbfSUXs3O3JHaFpfxt0mHupEb+vzi=5+S4g@mail.gmail.com>
 <20191231090146.GA6872@pi3>
 <CAMuHMdWhz7x8MnGeGv2f-Gb7fBRTp=5qq_Mz55sY7tQNpRogjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWhz7x8MnGeGv2f-Gb7fBRTp=5qq_Mz55sY7tQNpRogjg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, Max Staudt <max@enpas.org>, Elie Morisse <syniurge@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Juergen Fitschen <jfi@ssv-embedded.de>, Jean Delvare <jdelvare@suse.de>
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 31, 2019 at 10:20:01AM +0100, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Tue, Dec 31, 2019 at 10:01 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Mon, Dec 30, 2019 at 08:11:03PM +0100, Geert Uytterhoeven wrote:
> > > On Mon, Dec 30, 2019 at 6:28 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > Some of the I2C bus drivers can be compile tested to increase build
> > > > coverage.  This requires also:
> > > > 1. Adding dependencies on COMMON_CLK for BCM2835 and Meson I2C
> > > >    controllers,
> > > > 2. Adding 'if' conditional to 'default y' so they will not get enabled
> > > >    by default on all other architectures,
> > > > 3. Limiting few compile test options to supported architectures (which
> > > >    provide the readsX()/writesX() primitives).
> > > >
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> > > > @@ -611,8 +612,8 @@ config I2C_EMEV2
> > > >
> > > >  config I2C_EXYNOS5
> > > >         tristate "Exynos5 high-speed I2C driver"
> > > > -       depends on ARCH_EXYNOS && OF
> > > > -       default y
> > > > +       depends on (ARCH_EXYNOS && OF) || COMPILE_TEST
> > >
> > > This means it is only useful on DT-based Exynos platforms, but compiles
> > > everywhere?
> >
> > Yes. The driver will proble only from DT.
> >
> > >
> > > Do you still have support for non-DT Exynos platforms?
> > > ARCH_EXYNOS depends on ARCH_MULTI_V7?
> >
> > No, only DT. I think dependency here is a left over from board times and
> > optional OF. Actually many drivers depend on OF and some OF-like ARCH so
> > it could be removed.
> >
> > Since driver uses OF, it's rather the choice whether to explicitly
> > mention OF.
> 
> So the !OF case is only for compile-testing.  Then it can be simplified to:
> 
>     depends on ARCH_EXYNOS || COMPILE_TEST
> 

Many other drivers do exactly the same: depend on ARCH_xxx (which is
already OF only) and on OF. Since OF now has all (or almost all) stubs
for !OF case, such "depends on OF" is purely from logical point of view:
the driver will not bind without OF. It will not be useful.

I do not have strong opinion about this but is there a point to change
only this one, while in all other places drivers depend on OF? It will
just bring inconsistency.

Best regards,
Krzysztof
