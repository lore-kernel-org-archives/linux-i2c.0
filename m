From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: i2c-stm32: Document the STM32F7 I2C
 bindings
Date: Fri, 7 Jul 2017 08:41:01 -0500
Message-ID: <20170707134101.pm6cni7mjefi56iv@rob-hp-laptop>
References: <1499356386-28779-1-git-send-email-pierre-yves.mordret@st.com>
 <1499356386-28779-2-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1499356386-28779-2-git-send-email-pierre-yves.mordret@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 06, 2017 at 05:53:02PM +0200, Pierre-Yves MORDRET wrote:
> This patch adds the documentation of device tree bindings for STM32F7 I2C
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>  Version history:
>     v3:
>         * None
>     v2:
>         * Remove i2c-timing binding in order to use generic bindings SCL
>           Rising and Falling time instead
> ---
> ---
>  .../devicetree/bindings/i2c/i2c-stm32.txt          | 29 +++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)

I acked v2. Please add acks when posting new versions.

Rob
