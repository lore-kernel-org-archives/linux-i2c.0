From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH] i2c: i2c-stm32f7: rework slave_id allocation
Date: Tue, 22 Oct 2019 15:41:48 +0200
Message-ID: <7092a0d6-2f6a-fa1f-2999-17418b479c5f@st.com>
References: <1571144589-3066-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1571144589-3066-1-git-send-email-alain.volmat@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alain Volmat <alain.volmat@st.com>, wsa@the-dreams.de, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hello

Looks good

Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Thx
Regards

On 10/15/19 3:03 PM, Alain Volmat wrote:
> The IP can handle two slave addresses. One address can either be
> 7 bits or 10 bits while the other can only be 7 bits.
> In order to ensure that a 10 bits address can always be allocated
> (assuming there is only one 7 bits address already allocated),
> pick up the 7-bits only address slot in priority when performing a 7-bits
> address allocation.
> 
> Fixes: 60d609f3 ("i2c: i2c-stm32f7: Add slave support")
> 
> Signed-off-by: Alain Volmat <alain.volmat@st.com>
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index d36cf08461f7..cfae01b15243 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -1265,7 +1265,7 @@ static int stm32f7_i2c_get_free_slave_id(struct stm32f7_i2c_dev *i2c_dev,
>  	 * slave[0] supports 7-bit and 10-bit slave address
>  	 * slave[1] supports 7-bit slave address only
>  	 */
> -	for (i = 0; i < STM32F7_I2C_MAX_SLAVE; i++) {
> +	for (i = STM32F7_I2C_MAX_SLAVE - 1; i >= 0; i--) {
>  		if (i == 1 && (slave->flags & I2C_CLIENT_PEC))
>  			continue;
>  		if (!i2c_dev->slave[i]) {
> 
