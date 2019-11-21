From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: i2c: stm32: Migrate i2c-stm32
 documentation to yaml
Date: Thu, 21 Nov 2019 13:39:29 -0600
Message-ID: <20191121193929.GA6676@bogus>
References: <1574342866-8348-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1574342866-8348-1-git-send-email-alain.volmat@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alain Volmat <alain.volmat@st.com>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, pierre-yves.mordret@st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com
List-Id: linux-i2c@vger.kernel.org

On Thu, 21 Nov 2019 14:27:46 +0100, Alain Volmat wrote:
> The document was migrated to Yaml format and renamed st,stm32-i2c.yaml
> 
> Signed-off-by: Alain Volmat <alain.volmat@st.com>
> ---
> v2: remove i2c-scl.*time description, ref (moved into i2c-controller.yaml
>     push the st,syscfg-fmt into the if compatible st,stm32f7 part
>     fix the st,syscfg-fmt ref syntax and set minItems/maxItems to 3
>     make the clock-frequency part common and only keep enum in the st,stm32f4 case
>     remove unnecesary minItems/maxItems
>     remove address-cells/size-cells from required fields
> ---
>  .../devicetree/bindings/i2c/i2c-stm32.txt          |  65 ----------
>  .../devicetree/bindings/i2c/st,stm32-i2c.yaml      | 141 +++++++++++++++++++++
>  2 files changed, 141 insertions(+), 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml
> 

Applied, thanks.

Rob
