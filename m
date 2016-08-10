From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0244/1285] Replace numeric parameter like 0444 with macro
Date: Wed, 10 Aug 2016 15:45:30 +0200
Message-ID: <5052478.g1CZhtD17T@wuerfel>
References: <20160802105246.30008-1-baolex.ni@intel.com>
 <CACRpkdZsgSfL9rwe-vU5S6nNy0weD3O3PZymUZQsvJhQTSjf=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdZsgSfL9rwe-vU5S6nNy0weD3O3PZymUZQsvJhQTSjf=w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Krzysztof =?utf-8?B?S296xYJvd3NraQ==?= <k.kozlowski@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, Dave Airlie <airlied@linux.ie>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Baole Ni <baolex.ni@intel.com>, Andrew Duggan <aduggan@synaptics.com>, Kukjin Kim <kgene@kernel.org>, Borislav Petkov <bp@alien8.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, dougthompson@xmission.com, chuansheng.liu@intel.com, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-i2c@vger.kernel.org

On Wednesday, August 10, 2016 3:02:05 PM CEST Linus Walleij wrote:
> On Tue, Aug 2, 2016 at 12:52 PM, Baole Ni <baolex.ni@intel.com> wrote:
> 
> > I find that the developers often just specified the numeric value
> > when calling a macro which is defined with a parameter for access permission.
> > As we know, these numeric value for access permission have had the corresponding macro,
> > and that using macro can improve the robustness and readability of the code,
> > thus, I suggest replacing the numeric parameter with the macro.
> >
> > Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> > Signed-off-by: Baole Ni <baolex.ni@intel.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I assume Wolfram will merge this.

I assume not, see http://lwn.net/Articles/696227/

	Arnd
