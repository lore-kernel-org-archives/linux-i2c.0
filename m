From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v10 6/8] dt-bindings: i2c: rk3x: add support for rk3399
Date: Mon, 16 May 2016 11:45:38 -0500
Message-ID: <20160516164538.GA27178@rob-hp-laptop>
References: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
 <1463407452-41418-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1463407452-41418-1-git-send-email-david.wu@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Wu <david.wu@rock-chips.com>
Cc: mark.rutland@arm.com, huangtao@rock-chips.com, heiko@sntech.de, pawel.moll@arm.com, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, ijc+devicetree@hellion.org.uk, dianders@chromium.org, linux-kernel@vger.kernel.org, cf@rock-chips.com, andy.shevchenko@gmail.com, xjq@rock-chips.com, linux-i2c@vger.kernel.org, galak@codeaurora.org, zyw@rock-chips.com, briannorris@google.com, davidriley@google.com, linux-arm-kernel@lists.infradead.org, hl@rock-chips.com
List-Id: linux-i2c@vger.kernel.org

On Mon, May 16, 2016 at 10:04:12PM +0800, David Wu wrote:
> The bus clock and function clock are separated at rk3399,
> and others use one clock as the bus clock and function clock.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Change in v10:
> - none
> 
> Change in v9:
> - remove unnecessary "REQUIRED".
> 
> Change in v8:
> - remove error description.
> 
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
