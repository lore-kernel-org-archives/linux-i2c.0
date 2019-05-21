From: Patrice CHOTARD <patrice.chotard@st.com>
Subject: Re: [PATCH 6/8] MAINTAINERS: add I2C DT bindings to STI architecture
Date: Tue, 21 May 2019 08:55:14 +0000
Message-ID: <f1035a9b-c6a8-5e6e-4b08-81b5f6b473db@st.com>
References: <20190521082137.2889-1-wsa@the-dreams.de>
 <20190521082137.2889-7-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190521082137.2889-7-wsa@the-dreams.de>
Content-Language: en-US
Content-ID: <DA23ABE00F0C4542881DD9049BF3D5C5@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram

On 5/21/19 10:21 AM, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09f32866bdef..cce1173be35c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2281,6 +2281,7 @@ M:	Patrice Chotard <patrice.chotard@st.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  W:	http://www.stlinux.com
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/i2c/i2c-st.txt
>  F:	arch/arm/mach-sti/
>  F:	arch/arm/boot/dts/sti*
>  F:	drivers/char/hw_random/st-rng.c
> 

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
